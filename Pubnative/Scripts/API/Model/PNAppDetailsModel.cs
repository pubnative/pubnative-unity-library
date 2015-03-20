using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Pubnative.Model
{
    public class PNAppDetailsModel
    {
        private const string KEY_NAME               = "name";
        private const string KEY_PLATFORM           = "platform";
        private const string KEY_REVIEW             = "review";
        private const string KEY_REVIEW_URL         = "review_url";
        private const string KEY_REVIEW_PROS        = "review_pros";
        private const string KEY_REVIEW_CONS        = "review_cons";
        private const string KEY_PUBLISHER          = "publisher";
        private const string KEY_DEVELOPER          = "developer";
        private const string KEY_VERSION            = "version";
        private const string KEY_SIZE               = "size";
        private const string KEY_AGE_RATING         = "age_rating";
        private const string KEY_STORE_RATING       = "store_rating";
        private const string KEY_STORE_DESCRIPTION  = "store_description";
        private const string KEY_STORE_URL          = "store_url";
        private const string KEY_STORE_ID           = "store_id";
        private const string KEY_URL_SCHEME         = "url_scheme";
        private const string KEY_RELEASE_DATE       = "release_date";
        private const string KEY_TOTAL_RATINGS      = "total_ratings";
        private const string KEY_INSTALLS           = "installs";
        private const string KEY_CATEGORY           = "category";
        private const string KEY_STORE_CATEGORIES   = "store_categories";
        private const string KEY_SUB_CATEGORY       = "sub_category";

        public string name                      = string.Empty;
        public string platform                  = string.Empty;
        public string review                    = string.Empty;
        public string review_url                = string.Empty;
        public List<string> review_pros         = null;
        public List<string> review_cons         = null;
        public string publisher                 = string.Empty;
        public string developer                 = string.Empty;
        public string version                   = string.Empty;
        public string size                      = string.Empty;
        public string age_rating                = string.Empty;
        public double store_rating              = 0;
        public string store_description         = string.Empty;
        public string store_url                 = string.Empty;
        public string store_id                  = string.Empty;
        public string url_scheme                = string.Empty;
        public string release_date              = string.Empty;
        public double total_ratings             = 0;
        public string installs                  = string.Empty;
        public string category                  = string.Empty;
        public List<string> store_categories    = null;
        public string sub_category              = string.Empty;

        public PNAppDetailsModel(Hashtable data)
        {
            name                = (string) data[KEY_NAME];
            platform            = (string) data[KEY_PLATFORM];
            review              = (string) data[KEY_REVIEW];
            review_url          = (string) data[KEY_REVIEW_URL];
            review_pros         = ToList((ArrayList) data[KEY_REVIEW_PROS]);
            review_cons         = ToList((ArrayList) data[KEY_REVIEW_CONS]);
            publisher           = (string) data[KEY_PUBLISHER];
            developer           = (string) data[KEY_DEVELOPER];
            version             = (string) data[KEY_VERSION];
            size                = (string) data[KEY_SIZE];
            age_rating          = (string) data[KEY_AGE_RATING];
            store_rating        = Convert.ToDouble(data[KEY_STORE_RATING]);
            store_description   = (string) data[KEY_STORE_DESCRIPTION];
            store_url           = (string) data[KEY_STORE_URL];
            store_id            = (string) data[KEY_STORE_ID];
            url_scheme          = (string) data[KEY_URL_SCHEME];
            release_date        = (string) data[KEY_RELEASE_DATE];
            total_ratings       = Convert.ToDouble(data[KEY_TOTAL_RATINGS]);
            installs            = (string) data[KEY_INSTALLS];
            category            = (string) data[KEY_CATEGORY];
            store_categories    = ToList((ArrayList) data[KEY_STORE_CATEGORIES]);
            sub_category        = (string) data[KEY_SUB_CATEGORY];
        }

        private List<string> ToList(ArrayList items)
        {
            List<string> result = new List<string>();
            if(items != null)
            {
                foreach(string item in items)
                {
                    result.Add(item);
                }
            }
            return result;
        }
    }
}