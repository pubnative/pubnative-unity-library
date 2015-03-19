package net.pubnative;

import com.unity3d.player.UnityPlayer;

import net.pubnative.interstitials.PubNativeInterstitials;
import net.pubnative.interstitials.api.PubNativeInterstitialsType;
import android.util.Log;

public class PubnativeAdapter 
{
    @SuppressWarnings("unused")
    private static void Pubnative_Request(final int type, String appToken)
    {
        switch(type)
        {
            case 0: onInterstitialRequested(appToken);      break;
            case 1: onVideoInterstitialRequested(appToken); break;
        }
    }
    
    private static void onInterstitialRequested(String appToken)
    {
        PubNativeInterstitials.show(UnityPlayer.currentActivity, PubNativeInterstitialsType.INTERSTITIAL, 1);
    }
    
    private static void onVideoInterstitialRequested(String appToken)
    {
        Log.d("PubnativeAdapter","VIDEO not available, please use INTERSTITIAL instead");
    }
}
