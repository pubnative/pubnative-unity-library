using UnityEngine;
using System;
using System.Collections;

public class PNAdapter : MonoBehaviour 
{
    #region Scene object
    
    private const string INSTANCE_NAME = "PNAdapter_Instance";
    
    private void Awake()
    {
        name = INSTANCE_NAME;
        DontDestroyOnLoad(transform.gameObject);
    }
    
    private static PNAdapter _instance;
    private static PNAdapter EnsureInstance()
    {
        if(_instance == null)
        {
            _instance = FindObjectOfType(typeof(PNAdapter) ) as PNAdapter;
            if(_instance == null)
            {
                _instance = new GameObject(INSTANCE_NAME).AddComponent<PNAdapter>();
            }
        }
        return _instance;
    }
    
    #endregion

    #region Public
    
    public static event Action Loaded;
    public static event Action<string> Error;
    public static event Action Shown;
    public static event Action Closed;
    
    public enum AdType
    {
        Interstitial    = 0,
        Video           = 1
    }
    
    public static void Request(AdType adType, string appToken)
    {
        PNAdapter.EnsureInstance();
        PNAdapter.Pubnative_Request((int)adType, appToken); 
    }

    #endregion
    
    #region Private
    
    private void InvokeLoaded()
    {
        if(PNAdapter.Loaded != null)
        {
            PNAdapter.Loaded();
        }
    }
    
    private void InvokeError(string error)
    {
        if(PNAdapter.Error != null)
        {
            PNAdapter.Error(error);
        }
    }
    
    private void InvokeShown()
    {
        if(PNAdapter.Shown != null)
        {
            PNAdapter.Shown();
        }
    }
    
    private void InvokeClosed()
    {
        if(PNAdapter.Closed != null)
        {
            PNAdapter.Closed();
        }
    }
    
    #endregion
    
    #region Native binding

    #if UNITY_EDITOR

    private static void Pubnative_Request(int adType, string appToken)
    {
        Debug.Log("Pubnative_Request("+adType+","+appToken+")");
        PNAdapter._instance.pn_ad_loaded("");
        PNAdapter._instance.pn_ad_shown("");
        PNAdapter._instance.pn_ad_closed("");
    }

    #elif UNITY_IOS
    
    [System.Runtime.InteropServices.DllImport("__Internal")]
    private static extern void Pubnative_Request(int adType, string appToken);

    #elif UNITY_ANDROID

    private static AndroidJavaClass AndroidSDK;
    private static void Pubnative_Request(int adType, string appToken)
    {
        CallAndroidSDK("Pubnative_Request", adType, appToken);
    }
    
    private static void CallAndroidSDK(string methodName, params object[] args)
    {
        if(AndroidSDK == null)
        {
            AndroidSDK = new AndroidJavaClass("net.pubnative.unity.PubnativeAdapter");
        }
        AndroidSDK.CallStatic(methodName, args);
    }

    #endif  

    #endregion

    #region Native Callbacks
    
    private void pn_ad_loaded(string message)
    {
        this.InvokeLoaded();
    }
    
    private void pn_ad_error(string error)
    {
        this.InvokeError(error);
    }
    
    private void pn_ad_shown(string message)
    {
        this.InvokeShown();
    }
    
    private void pn_ad_closed(string message)
    {
        this.InvokeClosed();
    }
    
    #endregion
}

