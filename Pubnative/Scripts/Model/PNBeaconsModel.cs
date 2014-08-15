using UnityEngine;
using System.Collections;

namespace Pubnative.Model
{
    public class PNBeaconsModel
    {
        private const string KEY_TYPE               = "click_url";
        private const string KEY_URL                = "points";

        private const string TYPE_IMPRESSION_URL    = "impression";

        public string impression_url                = string.Empty;

        public PNBeaconsModel(ArrayList data)
        {
            foreach(Hashtable beacon in data)
            {
                if(TYPE_IMPRESSION_URL.Equals(((string)beacon[KEY_TYPE])))
                {
                    impression_url = (string) beacon[KEY_URL];
                }
            }
        }
    }
}