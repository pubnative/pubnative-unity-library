using UnityEngine;
using Pubnative.Core;
using Pubnative.Model;
using System.Collections;

namespace Pubnative
{
    public class PNNative : PNAd
    {
        private const int imageCount = 3;

        public const string REQUEST_ICON_SIZE               = "icon_size";
        public const string REQUEST_BANNER_SIZE             = "banner_size";
        public const string REQUEST_PORTRAIT_BANNER_SIZE    = "portrait_banner_size";

        public Texture2D icon;
        public Texture2D banner;
        public Texture2D portrait_banner;

        public PNNativeModel data = null;

        private int readyCounter = 0;

        protected override string APIName ()
        {
            return "native";
        }

        protected override void Initialize ()
        {
            readyCounter = 0;
        }

        protected override void ParseAd(Hashtable ad)
        {
            data = new PNNativeModel(ad);

            RequestImage(data.icon_url, new ImageDownload(
            (Texture2D texture) => 
            {
                if(texture != null)
                {
                    icon = texture;
                }
                CheckReady();
            }));
            
            RequestImage(data.banner_url, new ImageDownload(
            (Texture2D texture) => 
            {
                if(texture != null)
                {
                    banner = texture;
                }
                CheckReady();
            }));
            
            RequestImage(data.portrait_banner_url, new ImageDownload(
            (Texture2D texture) => 
            {
                if(texture != null)
                {
                    portrait_banner = texture;
                }
                CheckReady();
            }));
        }

        private void CheckReady()
        {
            readyCounter++;
            if(readyCounter >= imageCount)
            {
                InvokeReady();
            }
        }

        public override void ConfirmImpression ()
        {
            StartCoroutine(ConfirmImpression(data.beacons.impression_url));
        }

        public override void Open ()
        {
            OpenURL(data.click_url);
        }
    }
}