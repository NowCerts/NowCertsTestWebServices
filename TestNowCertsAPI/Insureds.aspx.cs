using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TestNowCertsAPI.Helpers;
using TestNowCertsAPI.NcInsuredService;

namespace TestNowCertsAPI
{
    public partial class Insureds : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (SessionHelper.NowCertsAuthenticationData != null)
            {
                if (SessionHelper.NowCertsAuthenticationData.ExpiresOn < DateTime.Now)
                {
                    ltrResultMessage.Text = "Your token has been expired. Please Re-Authenticate.";
                }
                //else
                //{
                //    ltrResultMessage.Text = String.Format("You are already authenticated. Your token expires on {0} {1}.", SessionHelper.NowCertsAuthenticationData.ExpiresOn.ToShortDateString(), SessionHelper.NowCertsAuthenticationData.ExpiresOn.ToShortTimeString());
                //}
            }
            else
            {
                ltrResultMessage.Text = "You are not authenticated. Please Authenticate.";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (SessionHelper.NowCertsAuthenticationData != null)
            {
                InsuredServiceSoapClient insuredService = new InsuredServiceSoapClient("InsuredServiceSoap12");
                NcInsured insured = new NcInsured()
                {
                    CommercialName = txtCommercialName.Text,

                    FirstName = txtFirstName.Text,
                    LastName = txtLastName.Text,

                    Active = true,
                    AddressLine1 = "AddrLine1",
                    StateNameOrAbbreviation = "FL",
                    Description = "imported from Web Services",
                    
                };

                NowCertsAuthenticationData authData = new NowCertsAuthenticationData()
                {
                    Token = SessionHelper.NowCertsAuthenticationData.Token
                };

                NowCertsApiResult result = insuredService.ImportInsured(authData, insured);


                if (result != null)
                {
                    ltrResultStatus.Text = result.Status.ToString();
                    ltrResultMessage.Text = result.Message;
                }
            }
        }
    }
}