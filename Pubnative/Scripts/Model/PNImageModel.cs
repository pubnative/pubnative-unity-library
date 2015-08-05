using UnityEngine;
using System;
using System.Collections;

namespace Pubnative.Model
{
    public class PNImageModel
    {
        private const string KEY_TYPE       = "type";
        private const string KEY_WIDTH      = "width";
        private const string KEY_HEIGHT     = "height";
        private const string KEY_IMAGE_URL  = "image_url";
        private const string KEY_CLICK_URL  = "click_url";
        private const string KEY_BEACONS    = "beacons";

        public string type              = string.Empty;
        public int width                = 0;
        public int height               = 0;
        public string image_url         = string.Empty;
        public string click_url         = string.Empty;
        public PNBeaconsModel beacons   = null;
        
        public PNImageModel(Hashtable data)
        {
            type        = (string) data[KEY_TYPE];
            width       = Convert.ToInt32(data[KEY_WIDTH]);
            height      = Convert.ToInt32(data[KEY_HEIGHT]);
            image_url   = (string) data[KEY_IMAGE_URL];
            click_url   = (string) data[KEY_CLICK_URL];
            if(data.ContainsKey(KEY_BEACONS))
            {
            	beacons     = new PNBeaconsModel(((ArrayList) data[KEY_BEACONS]));
            }
        }
    }
}