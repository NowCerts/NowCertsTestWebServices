using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TestNowCertsAPI.Helpers;
using TestNowCertsAPI.NcAuthenticationService;

namespace TestNowCertsAPI
{
    public partial class AuthenticateRestApi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionHelper.NowCertsAuthenticationData != null)
            {
                if (SessionHelper.NowCertsAuthenticationData.ExpiresOn < DateTime.Now)
                {
                    ltrResult.Text = "Your token has been expired. Please Re-Authenticate.";
                }
                else
                {
                    ltrResult.Text = String.Format("You are already authenticated. Your token expires on {0} {1}.", SessionHelper.NowCertsAuthenticationData.ExpiresOn.ToShortDateString(), SessionHelper.NowCertsAuthenticationData.ExpiresOn.ToShortTimeString());
                }
            }
        }

        protected void btnAuthenticate_Click(object sender, EventArgs e)
        {
            AuthenticationServiceSoapClient authenticationService = new AuthenticationServiceSoapClient("AuthenticationServiceSoap12");
            LoginData loginData = new LoginData()
            {
                UserName = txtUsername.Text,
                Password = txtPassword.Text
            };
            AuthenticationData result = authenticationService.GetToken(loginData);


            if (result != null && !String.IsNullOrEmpty(result.Token))
            {
                SessionHelper.NowCertsAuthenticationData = result;
                ltrResult.Text = String.Format("You've been successfully authenticated. Token is stored in Session. Expires on {0} {1}.", SessionHelper.NowCertsAuthenticationData.ExpiresOn.ToShortDateString(), SessionHelper.NowCertsAuthenticationData.ExpiresOn.ToShortTimeString());
            }
            else
            {
                ltrResult.Text = "Not Authenticated.";
            }
        }
    }
}