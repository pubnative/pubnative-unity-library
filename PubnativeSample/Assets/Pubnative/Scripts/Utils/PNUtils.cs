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
        	return "";
    	}
    	
#endif
	}
}