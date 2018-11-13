using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;

public static class ConfigurationHelper
{
    public static string ApiUrl
    {
        get
        {
            string result = System.Web.Configuration.WebConfigurationManager.AppSettings["ApiUrl"];
            if (String.IsNullOrEmpty(result))
            {
                result = "https://api.nowcerts.com/api/";
            }
            return result;
        }
    }
}