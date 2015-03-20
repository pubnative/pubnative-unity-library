using UnityEngine;
using Pubnative;

public class Demo : MonoBehaviour 
{
    // Use this for initialization
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
            result = "net.pubnative.unity.demo";
            #elif UNITY_ANDROID
            result = "net.pubnative.unity.demo";
            #elif UNITY_IOS
            result = "net.pubnative.unity.demo";
            #endif
            
            return result;
        }
    }

    private void Start()
    {
        if(native == null)
        {
            native = this.gameObject.AddComponent<PNNative>();
            native.Fail += PNAdapter_NativeFail;
			native.Ready += PNAdapter_NativeReady;
        }
        
        PNAdapter.Loaded += PNAdapter_InterstitialLoaded;
		PNAdapter.Error += PNAdapter_InterstitialError;
		PNAdapter.Shown += PNAdapter_InterstitialShown;
		PNAdapter.Closed += PNAdapter_InterstitialClosed;
    }
    
    private void OnGUI()
    {
        if(nativeSkin == null)
        {
            nativeSkin = (GUISkin) ScriptableObject.CreateInstance("GUISkin");
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
    public void RequestNativeAd()
    {
    	this.nativeReady = false;
        native.AddParameter(PNNative.REQUEST_APP_TOKEN, this.AppToken);
        native.AddParameter(PNNative.REQUEST_BUNDLE_ID, this.BundleID);
        native.AddParameter(PNNative.REQUEST_ICON_SIZE, "150x150");
        native.RequestAd();
    }

    public void RequestInterstitialAd()
    {
		this.nativeReady = false;
        PNAdapter.Request(PNAdapter.AdType.Interstitial, this.AppToken);
    }

    public void RequestVideoInterstitialAd()
    {
		this.nativeReady = false;
        PNAdapter.Request(PNAdapter.AdType.Video, this.AppToken);
    }

	#region Events

	private void PNAdapter_NativeReady ()
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
    
	private void PNAdapter_NativeFail ()
	{
		Debug.Log ("Download FAIL");
	}

	private void PNAdapter_InterstitialLoaded ()
	{
		Debug.Log("PNAdapter_InterstitialLoaded()");
	}
	
	private void PNAdapter_InterstitialError (string obj)
	{
		Debug.Log("PNAdapter_InterstitialError("+obj+")");
	}
	
	private void PNAdapter_InterstitialShown ()
	{
		Debug.Log("PNAdapter_InterstitialShown()");
	}
	
	private void PNAdapter_InterstitialClosed ()
	{
		Debug.Log("PNAdapter_InterstitialClosed()");
	}
	
	#endregion
}