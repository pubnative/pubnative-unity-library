using UnityEngine;
using System;
using System.Collections;

namespace Pubnative.Model
{
    public class PNNativeModel
    {
        private const string KEY_CLICK_URL              = "click_url";
        private const string KEY_POINTS                 = "points";
        private const string KEY_CTA_TEXT               = "cta_text";
        private const string KEY_TYPE                   = "type";
        private const string KEY_TITLE                  = "title";
        private const string KEY_DESCRIPTION            = "description";
        private const string KEY_ICON_URL               = "icon_url";
        private const string KEY_BANNER_URL             = "banner_url";
        private const string KEY_PORTRAIT_BANNER_URL    = "portrait_banner_url";
        private const string KEY_APP_DETAILS            = "app_details";
        private const string KEY_BEACONS                = "beacons";
        
        public string click_url                 = string.Empty;
        public int points                       = 0;
        public string cta_text                  = string.Empty;
        public string type                      = string.Empty;
        public string title                     = string.Empty;
        public string description               = string.Empty;
        public string icon_url                  = string.Empty;
        public string banner_url                = string.Empty;
        public string portrait_banner_url       = string.Empty;
        public PNAppDetailsModel app_details    = null;
        public PNBeaconsModel beacons           = null;
        
        public PNNativeModel(Hashtable data)
        {
            click_url           = (string) data[KEY_CLICK_URL];
            points              = Convert.ToInt32(data[KEY_POINTS]);
            cta_text            = (string) data[KEY_CTA_TEXT];
            type                = (string) data[KEY_TYPE];
            title               = (string) data[KEY_TITLE];
            description         = (string) data[KEY_DESCRIPTION];
            icon_url            = (string) data[KEY_ICON_URL];
            banner_url          = (string) data[KEY_BANNER_URL];
            portrait_banner_url = (string) data[KEY_PORTRAIT_BANNER_URL];
            app_details         = new PNAppDetailsModel(((Hashtable) data[KEY_APP_DETAILS]));
            beacons             = new PNBeaconsModel(((ArrayList) data[KEY_BEACONS]));
        }
    }
}

