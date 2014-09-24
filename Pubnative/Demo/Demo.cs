using UnityEngine;
using Pubnative;

public class Demo : MonoBehaviour 
{
    // Use this for initialization
    private PNImage image;
    private bool imageReady = false;
    private GUISkin imageSkin;

    private PNNative native;
    private bool nativeReady = false;
    private GUISkin nativeSkin;

    private string AppToken
    {
        get
        {
            string result = string.Empty;
            
            #if UNITY_EDITOR
            result = "1dbe82c9cf40d82aeea6368a878c756cccf0ac10f4db75672e12a4c6c0a6c0e2";
            #elif UNITY_ANDROID
            result = "af117147db28ef258bfd6d042c718b537bc6a2b0760aca3d073a1c80865545f9";
            #elif UNITY_IOS
            result = "1dbe82c9cf40d82aeea6368a878c756cccf0ac10f4db75672e12a4c6c0a6c0e2";
            #endif
            
            return result;
        }
    }
    
    private string BundleID
    {
        get
        {
            string result = string.Empty;
            
            #if UNITY_EDITOR
            result = "com.pubnative.PNLibrary";
            #elif UNITY_ANDROID
            result = "net.pubnative.demo";
            #elif UNITY_IOS
            result = "com.pubnative.PNLibrary";
            #endif
            
            return result;
        }
    }

    private void Start()
    {
        if(image == null)
        {
            image = this.gameObject.AddComponent<PNImage>();
            image.Fail += HandleFail;
            image.Ready += HandleImageReady;
        }

        if(native == null)
        {
            native = this.gameObject.AddComponent<PNNative>();
            native.Fail += HandleFail;
            native.Ready += HandleNativeReady;
        }
    }

    private Rect CenteredButtonRect(float widthPercent, float heightPercent, int position)
    {
        float screenWidth = Screen.width * widthPercent;
        float screenHeight = Screen.height * heightPercent;

        float xPosition = (Screen.width / 2) - (screenWidth / 2);
        float yPosition = screenHeight * position;

        return new Rect (xPosition, yPosition, screenWidth, screenHeight);
    }

    private void OnGUI()
    {
        float buttonWidthPercent = 0.6f;
        float buttonHeightPercent = 0.05f;

        if(imageSkin == null)
        {
            imageSkin = (GUISkin) ScriptableObject.CreateInstance("GUISkin");
        }

        if(nativeSkin == null)
        {
            nativeSkin = (GUISkin) ScriptableObject.CreateInstance("GUISkin");
        }

        if(GUI.Button(CenteredButtonRect(buttonWidthPercent, buttonHeightPercent, 0),"REQUEST IMAGE AD"))
        {
            this.imageReady = false;
            RequestImageAd();
        }

        if(imageReady)
        {
            GUI.skin = imageSkin;
            if(GUI.Button(new Rect((Screen.width / 2) - 160, Screen.height - 50, 320, 50),""))
            {
                this.imageReady = false;
                image.Open();
            }
            GUI.skin = null;
        }

        if(GUI.Button(CenteredButtonRect(buttonWidthPercent, buttonHeightPercent, 1),"REQUEST NATIVE AD"))
        {
            this.nativeReady = false;
            RequestNativeAd();
        }

        if(nativeReady)
        {
            GUI.skin = nativeSkin;
            if(GUI.Button(new Rect(10, 10, 150, 150),""))
            {
                this.nativeReady = false;
                native.Open();
            }
            GUI.skin = null;
        }
    }

    private void RequestImageAd()
    {   
        image.AddParameter(PNImage.REQUEST_APP_TOKEN, this.AppToken);
        image.AddParameter(PNImage.REQUEST_BUNDLE_ID, this.BundleID);
        image.AddParameter(PNImage.REQUEST_BANNER_SIZE, "320x50");
        image.RequestAd();
    }

    private void RequestNativeAd()
    {
        native.AddParameter(PNNative.REQUEST_APP_TOKEN, this.AppToken);
        native.AddParameter(PNNative.REQUEST_BUNDLE_ID, this.BundleID);
        native.AddParameter(PNNative.REQUEST_ICON_SIZE, "150x150");
        native.RequestAd();
    }

    private void HandleImageReady ()
    {
        if(image.banner != null)
        {
            imageSkin.button.normal.background = image.banner;
            imageSkin.button.hover.background = image.banner;
            imageSkin.button.active.background = image.banner;

            this.imageReady = true;
            image.ConfirmImpression();
        }
    }

    private void HandleNativeReady ()
    {
        if(native.icon != null)
        {
            nativeSkin.button.normal.background = native.icon;
            nativeSkin.button.hover.background = native.icon;
            nativeSkin.button.active.background = native.icon;
            
            this.nativeReady = true;
            native.ConfirmImpression();
        }
    }

    private void HandleFail ()
    {
        Debug.Log ("Download FAIL");
    }
}