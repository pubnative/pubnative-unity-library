using UnityEngine;
using Pubnative.Core;
using Pubnative.Model;
using System.Collections;

namespace Pubnative
{
    public class PNImage : PNAd
    {
        public const string REQUEST_BANNER_SIZE = "banner_size";

        public Texture2D banner = null;
        public PNImageModel data = null;

        protected override string APIName ()
        {
            return "image";
        }

        protected override void Initialize ()
        {
            // Do nothing
        }

        protected override void ParseAd(Hashtable ad)
        {
            data = new PNImageModel(ad);

            RequestImage(data.image_url, DownloadDelegate);
        }

        private void DownloadDelegate(Texture2D texture)
        {
            if(texture != null)
            {
                banner = texture;
                InvokeReady();
            }
            else
            {
                InvokeFail();
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