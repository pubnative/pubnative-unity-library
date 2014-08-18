![ScreenShot](/Docs/PNLogo.png)

PubNative is an API-based publisher platform dedicated to native advertising which does not require the integration of an SDK. Through PubNative, publishers can request over 20 parameters to enrich their ads and thereby create any number of combinations for unique and truly native ad units.

# Pubnative library

Pubnative library is a collection of Open Source tools, to implement API based native ads in Unity.

## Install

### Source files

1. Download the Pubnative repository
2. Copy the Pubnative/ folder into your Unity project

## Native request

1. To get native ads from our API you should import Pubnative namespace, add a PNNative behaviour in your node and hook Ready and Fail events from the behaviour
2. Initialize a request setting up at least your *REQUEST_APP_TOKEN* *REQUEST_BUNDLE_ID* and if needed, set up required sizes for images with *REQUEST_ICON_SIZE* *REQUEST_BANNER_SIZE* *REQUEST_PORTRAIT_BANNER_SIZE* for respective sizes with detailed values in the [wiki](https://pubnative.atlassian.net/wiki/display/PUB/API+Documentation) for the native API. Once everything is set up, call RequestAd() to start the request
3. Use returned data from data field to configure your own layout and invoke ConfirmImpression() when you show it on the screen.
4. Once you want to open the ad (heading to device-store), call Open() method from the native ad

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

## Image request

1. To get native ads from our API you should import Pubnative namespace, add a PNNative behaviour in your node and hook Ready and Fail events from the behaviour
2. Initialize a request setting up at least your *REQUEST_APP_TOKEN* *REQUEST_BUNDLE_ID* and if needed, set up required size for image with *REQUEST_IMAGE_SIZE* with detailed values in the [wiki](https://pubnative.atlassian.net/wiki/display/PUB/API+Documentation) for the native API. Once everything is set up, call RequestAd() to start the request
3. Use returned data from data field to configure your own layout and invoke ConfirmImpression() when you show it on the screen.
4. To open the ad (heading to the device-store), call Open() method in the image holder.

```cs
private PNImage image;
private void InitializeAd()
{
	image = this.gameObject.AddComponent<PNImage>();
	image.Fail += HandleFail;
	image.Ready += HandleReady;
}

private void RequestImageAd()
{
	image.AddParameter(PNImage.REQUEST_APP_TOKEN, "<YOUR_APP_TOKEN>");
	image.AddParameter(PNImage.REQUEST_BUNDLE_ID, "<YOUR_BUNDLE_ID>");
	image.AddParameter(PNImage.REQUEST_BANNER_SIZE, "<SELECTED_BANNER_SIZE>");
	image.RequestAd();
}

private void HandleReady ()
{
	Texture2D banner = image.banner;

	//TODO: Set up your layout with returned texture

	image.ConfirmImpression();
}

private void HandleFail()
{
	//TODO: Do whatever you need when call fails
}

private void OpenAd ()
{
	image.Open();
}
```

## Misc

### Author

David Martin

### License

This code is distributed under the terms and conditions of the MIT license. 

### Contribution guidelines

If you fix a bug you discovered or have development ideas, feel free to make a pull request.

