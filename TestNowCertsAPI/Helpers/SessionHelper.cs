using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TestNowCertsAPI.NcAuthenticationService;

namespace TestNowCertsAPI.Helpers
{
    public class SessionHelper
    {
        public static AuthenticationData NowCertsAuthenticationData
        {
            get
            {
                AuthenticationData result = null;
                if (HttpContext.Current != null && HttpContext.Current.Session != null && HttpContext.Current.Session["NowCertsAuthenticationData"] != null)
                {
                    result = (AuthenticationData)HttpContext.Current.Session["NowCertsAuthenticationData"];
                }
                return result;
            }
            set
            {
                if (HttpContext.Current != null && HttpContext.Current.Session != null)
                {
                    HttpContext.Current.Session["NowCertsAuthenticationData"] = value;
                }
            }
        }
    }
}