package net.pubnative.unity;

import com.unity3d.player.UnityPlayer;

import net.pubnative.interstitials.PubNativeInterstitials;
import net.pubnative.interstitials.api.PubNativeInterstitialsListener;
import net.pubnative.interstitials.api.PubNativeInterstitialsType;
import net.pubnative.library.model.response.NativeAd;
import android.util.Log;

public class PubnativeAdapter 
{
    private static Boolean initialized = false;
    
    @SuppressWarnings("unused")
    private static void Pubnative_Request(final int type, String appToken)
    {
        switch(type)
        {
            case 0: onInterstitialRequested(appToken);      break;
            case 1: onVideoInterstitialRequested(appToken); break;
        }
    }
    
    private static void initialize(final String appToken)
    {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable(){
            @Override
            public void run() {
                
                if(!PubnativeAdapter.initialized)
                {
                    PubnativeAdapter.initialized = true;
                    PubNativeInterstitials.init(UnityPlayer.currentActivity, appToken);
                    PubNativeInterstitials.addListener(new PubNativeInterstitialsListener(){
        
                        @Override
                        public void onShown(PubNativeInterstitialsType type) {
                            UnityPlayer.currentActivity.runOnUiThread(new Runnable(){
                                @Override
                                public void run() {
                                    UnityPlayer.UnitySendMessage("PNAdapter_Instance", "pn_ad_loaded", "");
                                    UnityPlayer.UnitySendMessage("PNAdapter_Instance", "pn_ad_shown", "");
                                }
                            });
                        }
        
                        @Override
                        public void onTapped(NativeAd ad) {
                            // TODO Auto-generated method stub
                            
                        }
        
                        @Override
                        public void onClosed(PubNativeInterstitialsType type) {
                            UnityPlayer.currentActivity.runOnUiThread(new Runnable(){
                                @Override
                                public void run() {
                                    UnityPlayer.UnitySendMessage("PNAdapter_Instance", "pn_ad_closed", "");
                                }
                            });
                        }
        
                        @Override
                        public void onError(final Exception ex) {
                            UnityPlayer.currentActivity.runOnUiThread(new Runnable(){
                                @Override
                                public void run() {
                                    UnityPlayer.UnitySendMessage("PNAdapter_Instance", "pn_ad_error", ex.toString());
                                }
                            });
                            
                        }
                        
                    });
                }
            }
        });
    }
    
    private static void onInterstitialRequested(String appToken)
    {
        PubnativeAdapter.initialize(appToken);
        UnityPlayer.currentActivity.runOnUiThread(new Runnable(){
            @Override
            public void run() {
                PubNativeInterstitials.show(UnityPlayer.currentActivity, 
                                            PubNativeInterstitialsType.INTERSTITIAL, 
                                            1);
            }
        });
    }
    
    private static void onVideoInterstitialRequested(String appToken)
    {
        UnityPlayer.currentActivity.runOnUiThread(new Runnable(){
            @Override
            public void run() {
                Log.d("PubnativeAdapter","VIDEO not available, please use INTERSTITIAL instead");
            }
        });
    }
}