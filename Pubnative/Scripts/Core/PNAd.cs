using UnityEngine;
using Pubnative;
using Pubnative.Utils;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;

namespace Pubnative.Core
{
    public abstract class PNAd : MonoBehaviour
    {
        #region Events

        public event Action Fail;
        public event Action Ready;

        #endregion

        #region Constants

        protected static string server_url = "http://api.pubnative.net/api/partner/v2/promotions/";

        public const string REQUEST_APP_TOKEN           = "app_token";
        public const string REQUEST_BUNDLE_ID           = "bundle_id";
        
        private const string REQUEST_OS_NAME            = "os";
        private const string REQUEST_OS_VERSION         = "os_version";
        private const string REQUEST_DEVICE_MODEL       = "device_model";
        private const string REQUEST_DEVICE_RESOLUTION  = "device_resolution";
        private const string REQUEST_APPLE_IDFA         = "apple_idfa";
        private const string REQUEST_ANDROID_ID         = "android_id";
        private const string REQUEST_NO_USER_ID         = "no_user_id";
        
        private const string REQUEST_NO_USER_ID_VALUE   = "1";

        #endregion

        #region Attributes

        private Dictionary<string, object> requestParameters = new Dictionary<string, object>();

        private bool notifyAdReady = false;
        private bool notifyFail = false;
        private bool impressionConfirmed = false;

        #endregion

        #region Delegates

        protected delegate void ImageDownload(Texture2D texture);

        #endregion

        #region MonoBehaviour

        private void Update()
        {
            if(this.notifyFail)
            {
                this.notifyFail = false;
                if(Fail != null)
                {
                    Fail();
                }
            }
            
            if(this.notifyAdReady)
            {
                this.notifyAdReady = false;
                if(Ready != null)
                {
                    Ready();
                }
            }
        }

        #endregion

        #region Public methods

        public void RequestAd()
        {
            //Initialize common parameters
            string os = string.Empty;
            string version = string.Empty;
            string deviceModel = string.Empty;
            string deviceResolution = String.Format("{0}x{1}", Screen.width, Screen.height);
            string userIDKey = REQUEST_NO_USER_ID;
            string userID = PNUtils.UserID();
            

#if UNITY_EDITOR
            os = "ios";
            version = "7.1.1";
            deviceModel = WWW.EscapeURL("iPhone5");
#elif UNITY_IOS
            os = "ios";
            version = WWW.EscapeURL(SystemInfo.operatingSystem.Replace("iPhone OS ", ""));
            deviceModel = WWW.EscapeURL(SystemInfo.deviceModel);
            userIDKey = REQUEST_APPLE_IDFA;

            if(deviceModel.Equals("x86_64"))
            {
                deviceModel="iPhone5";
            }
#elif UNITY_ANDROID
            os = "android";
            IntPtr clazz = AndroidJNI.FindClass("android.os.Build$VERSION");
            IntPtr field = AndroidJNI.GetStaticFieldID(clazz, "RELEASE", AndroidJNIHelper.GetSignature(""));
            version = WWW.EscapeURL(AndroidJNI.GetStaticStringField(clazz, field));
            deviceModel = WWW.EscapeURL(SystemInfo.deviceModel);
            userIDKey = REQUEST_ANDROID_ID;
#endif
            AddParameter(REQUEST_OS_NAME, os);
            AddParameter(REQUEST_OS_VERSION, version);
            AddParameter(REQUEST_DEVICE_MODEL, deviceModel);
            AddParameter(REQUEST_DEVICE_RESOLUTION, deviceResolution);

            Debug.Log("UserIDKey: " + userIDKey + " - UserID: " + userID);

            if(string.IsNullOrEmpty(userID))
            {
                AddParameter(REQUEST_NO_USER_ID, REQUEST_NO_USER_ID_VALUE);
            }
            else
            {
                AddParameter(userIDKey, userID);   
            }

            //Create request URL
            string url = string.Format("{0}{1}?", server_url, APIName());
            url = string.Format("{0}{1}={2}", url, REQUEST_APP_TOKEN, requestParameters[REQUEST_APP_TOKEN]);
            requestParameters.Remove(REQUEST_APP_TOKEN);
            foreach (string key in requestParameters.Keys)
            {
                url = string.Format("{0}&{1}={2}", url, key, requestParameters[key]);
            }

            requestParameters.Clear();

            StartCoroutine(RequestAdCoroutine(url));
        }

        public void AddParameter(string parameter, string value)
        {
            if(requestParameters.ContainsKey(parameter))
            {
                requestParameters.Remove(parameter);
            }
            requestParameters.Add(parameter, value);
        }

        #endregion

        #region Helpers

        private IEnumerator RequestAdCoroutine(string url)
        {
            WWW request = new WWW(url);
            yield return request;
            
            if (request.error == null)
            {
                Hashtable responseData = (Hashtable) MiniJSON.jsonDecode(request.text);

                string status = (string)responseData["status"];

                if(status.Equals("ok"))
                {
                    ArrayList rawAds = (ArrayList) responseData["ads"];
                    if(rawAds.Count > 0)
                    {
                        ParseAd(((Hashtable)rawAds[0]));
                    }
                    else
                    {
                        Debug.Log("PubNative - No ads");
                        InvokeFail();
                    }
                }
                else
                {
                    Debug.Log("PubNative - Request error in status: " + status + " - Request URL: " + url);
                    InvokeFail();
                }

            }
            else
            {
                Debug.Log("PubNative - Network error: " + request.error + " - Request URL: " + url);
                InvokeFail();
            }
        }

        protected void OpenURL(string url)
        {
            Application.OpenURL(url);
        }

        protected IEnumerator ConfirmImpression(string url)
        {
            if(!this.impressionConfirmed)
            {
                WWW www = new WWW(url);
                //Load the data and yield (wait) till it's ready before we continue executing the rest of this method.
                yield return www;
                
                if (www.error == null)
                {
                    this.impressionConfirmed = true;
                }
                else
                {
                    this.impressionConfirmed = false;
                }
            }
        }

        protected void RequestImage(string url, ImageDownload downloadDelegate)
        {
            if(url != null)
            {
                StartCoroutine(RequestImageCoroutine(url, downloadDelegate));
            }
            else
            {
                Debug.Log("PubNative - Image not provided by server");
                downloadDelegate(null);
            }
        }

        private IEnumerator RequestImageCoroutine(string url, ImageDownload downloadDelegate)
        {
            if(Path.GetExtension(url).Equals(".gif"))
            {
                Debug.Log("PubNative - Invalid image extension " + Path.GetExtension(url) + " - Request URL: " + url);
                downloadDelegate(null);
            }
            else
            {
                WWW request = new WWW(url);
                yield return request;
                
                if (request.error == null)
                {
                    downloadDelegate(request.texture);
                }
                else
                {
                    Debug.Log("PubNative - Network error: " + request.error + " - Request URL: " + url);
                    downloadDelegate(null);
                }
            }
        }

        protected void InvokeFail()
        {
            this.notifyFail = true;
        }
        
        protected void InvokeReady()
        {
            this.notifyAdReady = true;
        }

        #endregion

        #region Abstract methods

        public abstract void Open();
        public abstract void ConfirmImpression();

        protected abstract string APIName();
        protected abstract void Initialize ();
        protected abstract void ParseAd(Hashtable ad);

        #endregion
    }
}