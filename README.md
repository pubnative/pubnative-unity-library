![ScreenShot](/Docs/PNLogo.png)

PubNative is an API-based publisher platform dedicated to native advertising which does not require the integration of an SDK. Through PubNative, publishers can request over 20 parameters to enrich their ads and thereby create any number of combinations for unique and truly native ad units.

# Pubnative library

Pubnative library is a collection of Open Source tools, to implement API based native ads in Unity.

## Contents

* [Install](#install)
* [Usage](#usage)
    * [Native](#native)
    * [Interstitials](#interstitials)
        * [Android](#interstitials_android)
        * [iOS](#interstitials_ios)
            
* [Misc](#misc)
    * [Dependencies](#misc_dependencies)
    * [License](#misc_license)
    * [Contribution](#misc_contribution)


<a name="install"></a>
## Install

1. Download the Pubnative repository
2. Copy the Pubnative/ folder into your Unity project

**Some other integration steps may be needed depending on the usage**

<a name="usage"></a>
## Usage

<a name="native"></a>
### Native

* To get native ads from our API you should import Pubnative namespace, add a PNNative behaviour in your node and hook Ready and Fail events from the behaviour
* Initialize a request setting up at least the following fields:
    * **REQUEST\_APP_TOKEN**
    * **REQUEST\_BUNDLE_ID**

* If needed, set up required sizes for images with the following parameters:
    * **REQUEST\_ICON_SIZE** 
    * **REQUEST\_BANNER_SIZE** 
    * **REQUEST\_PORTRAIT\_BANNER_SIZE** 

* Use returned data from data field to configure your own layout and invoke ConfirmImpression() when you show it on the screen.
* Once you want to open the ad (heading to device-store), call Open() method from the native ad

```cs
private PNNative native;
private void InitializeAd()
{
	native = this.gameObject.AddComponent<PNNative>();
	native.Fail += HandleFail;
	native.Ready += HandleReady;
}
private void RequestNativeAd()
{
	native.AddParameter(PNNative.REQUEST_APP_TOKEN, "<YOUR_APP_TOKEN>");
	native.AddParameter(PNNative.REQUEST_BUNDLE_ID, "<YOUR_BUNDLE_ID>");
	native.AddParameter(PNNative.REQUEST_ICON_SIZE, "<SELECTED_ICON_SIZE>");
	native.AddParameter(PNNative.REQUEST_BANNER_SIZE, "<SELECTED_BANNER_SIZE>");
	native.AddParameter(PNNative.REQUEST_PORTRAIT_BANNER_SIZE, "<SELECTED_PORTRAIT_BANNER_SIZE>");
	native.RequestAd();
}
private void HandleReady ()
{
	Texture2D icon = native.icon;
	Texture2D banner = native.banner;
	Texture2D portrait_banner = native.portrait_banner;

	//TODO: Set up your layout with returned textures

	native.ConfirmImpression();
}

private void HandleFail()
{
	//TODO: Do whatever you need when call fails
}

private void OpenAd()
{
	native.Open();
}
```

<a name="interstitials"></a>
### Interstitials

We are currently supporting 2 types of native interstitials that will work only in the generated project. 

* **INTERSTITIAL**: This is a full screen interstitial
* **VIDEO**: This is a full screen video

In general therms you will need to:

* Request through PNAdapter the desired Interstitial type with the desired APP_TOKEN
* Configure your generated native project

```cs
private void Start()
{
    PNAdapter.Loaded += PNAdapter_InterstitialLoaded;
    PNAdapter.Error += PNAdapter_InterstitialError;
    PNAdapter.Shown += PNAdapter_InterstitialShown;
    PNAdapter.Closed += PNAdapter_InterstitialClosed;
}

public void RequestInterstitialAd()
{
    PNAdapter.Request(PNAdapter.AdType.Interstitial, <YOUR_APP_TOKEN>);
}

public void RequestVideoInterstitialAd()
{
    PNAdapter.Request(PNAdapter.AdType.Video, <YOUR_APP_TOKEN>);
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
```

To configure your native project, depends on the generated platform you will need to do different steps

<a name="interstitials_android"></a>
####Android

* Download [pubnative-android-library](https://github.com/pubnative/pubnative-android-library) and add **pubnative-interstitials** and **pubnative-library** projects to your workspace.
* Link **pubnative-interstitials** project to your generated project
* Link **google-play-services-lib** to your generated project
* Drag and drop **Pubnative/Editor/Android/PubnativeAdapter.java** file to your project
* Add the following to your AndroidManifest file:

```XML
<activity
android:name="net.pubnative.interstitials.PubNativeInterstitialsActivity"
android:configChanges="keyboardHidden|orientation|screenSize"
android:hardwareAccelerated="true"
android:taskAffinity="net.pubnative.interstitials"
android:theme="@style/Theme.PubNativeInterstitials" />
<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />
```

<a name="interstitials_ios"></a>
####iOS

* Add AdSupport framework to the application target.

<a name="misc"></a>
## Misc

<a name="misc_dependencies"></a>
### Dependencies

* [XUPorter](https://github.com/onevcat/XUPorter)
* MiniJSON

<a name="misc_license"></a>
### License

This code is distributed under the terms and conditions of the MIT license. 

<a name="misc_contribution"></a>
### Contribution

**NB!** If you fix a bug you discovered or have development ideas, feel free to make a pull request.

