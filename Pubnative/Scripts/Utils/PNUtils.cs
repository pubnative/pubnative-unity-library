using UnityEngine;
using System;
using System.Collections;

namespace Pubnative.Utils
{
	public class PNUtils
	{
		public static string UserID()
		{
			return PubnativeUserID();
		}

#if UNITY_EDITOR

		private static string PubnativeUserID()
		{
			return "";
		}

#elif UNITY_IPHONE
		
		private static string PubnativeUserID()
		{
			return System.Runtime.InteropServices.Marshal.PtrToStringAnsi(PubnativeUserIDNative());
		}

		[System.Runtime.InteropServices.DllImport("__Internal")]
   		private static extern IntPtr PubnativeUserIDNative();

#elif UNITY_ANDROID
		
		private static string PubnativeUserID()
		{
			AndroidJavaClass up = new AndroidJavaClass ("com.unity3d.player.UnityPlayer");
		    AndroidJavaObject currentActivity = up.GetStatic<AndroidJavaObject> ("currentActivity");
		    AndroidJavaObject contentResolver = currentActivity.Call<AndroidJavaObject> ("getContentResolver");
		    AndroidJavaClass secure = new AndroidJavaClass ("android.provider.Settings$Secure");
		    string android_id = secure.CallStatic<string> ("getString", contentResolver, "android_id");
		    return android_id;
		}

#endif
	}
}