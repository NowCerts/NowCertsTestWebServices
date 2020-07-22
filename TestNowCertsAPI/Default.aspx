<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TestNowCertsAPI._Default" %>

<asp:Content ID="BodyContentTop" ContentPlaceHolderID="MainContentAlt" runat="server">
    <section class="background-light top-section">
        <div class="container">
            <div class="row mt-30">
                <div class="text-center">
                    <img src="https://www.nowcerts.com/Resources/Images/intro/nowcerts-insurance-agency-management-system-identity-dark.png" alt="NowCerts" />
                    <h3 class="text-primary mb-5">NowCerts Web API - Example Project</h3>
                    <p class="font-semi-bold">
                        Check our example project to see what is possible using our developer Web API.
                    </p>
                    <a target="_blank" href="https://api.nowcerts.com/Help" class="btn btn-info">API Docs</a>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="row mt-30">
            <div class="col-lg-6">
                <h4 class="text-normal mt-0">
                    <span class="square square-info"></span>
                    <span>Example Project</span>
                </h4>

                <p>
                    We know examples are very important for understanding any API, so we made this project to help you getting started using <strong>NowCerts API</strong>.
                    <br /><br />
                    Currently the example project demonstrates the following possibilities: <br /><br />
                    <span class="font-italic"><a runat="server" href="~/AuthenticateRestApi">- User Authetication</a>;</span> <br />
                    <span class="font-italic"><a runat="server" href="~/RefreshToken">- Getting a refresh Token</a>;</span> <br />
                    <span class="font-italic"><a runat="server" href="~/InsuredsRestApi">- Insert Insured/Prospect</a>;</span> <br />
                    <span class="font-italic"><a runat="server" href="~/PoliciesRestApi">- Insert Policy/Quote for a specified Insured</a>;</span> <br />
                    <span class="font-italic"><a runat="server" href="~/SearchInsureds">- Search and Filter Insureds</a>;</span> <br />
                    <span class="font-italic"><a runat="server" href="~/SearchPolicies">- Search and Filter Policies</a>.</span> <br />

                    <br />
                    The source code of the project is available on our <a class="font-semi-bold" target="_blank" href="https://github.com/NowCerts/NowCertsTestWebServices">GitHub account</a>.
                    <br />
                    You can preview the <a class="font-semi-bold" target="_blank" href="http://test.api.nowcerts.com">live demo</a>.
                </p>
            </div>

            <div class="col-lg-6">
                <h4 class="text-normal mt-0">
                    <span class="square square-primary"></span>
                    <span>Docs and Materials</span>
                </h4>

                <p>
                    If you are a new user who wants to use <strong>NowCerts API</strong> for your project, we've prepared some materials to help you get started.
                    <br /><br />
                    In our support portal there are several articles explaning in details how to start using <strong>NowCerts API</strong>. You can take a look here: <br /><br />
                    <a target="_blank" href="https://nowcerts.freshdesk.com/support/solutions/articles/48000154522-nowcerts-com-rest-api">REST API - Intro</a> <br />
                    <a target="_blank" href="https://nowcerts.freshdesk.com/support/solutions/articles/48000146941-nowcerts-com-rest-api-search-insureds">REST API - Search Insureds</a> <br />
                    <a target="_blank" href="https://nowcerts.freshdesk.com/support/solutions/articles/48000146940-nowcerts-com-rest-api-custom-fields">REST API - Custom Fields</a> <br />

                    <br />
                    You can preview the <a class="font-semi-bold" target="_blank" href="https://api.nowcerts.com/Help">API Documentation Portal</a>.
                </p>
            </div>
        </div>

        <div class="row mt-30">
            <div class="col-lg-12">
                <div class="text-center">
                    <h4 class="text-normal mt-0">
                        <span class="square square-passive"></span>
                        <span>Get In Touch</span>
                    </h4>

                    <p>
                        If you have any questions or suggestions for additions <br /> please feel free to contact us.
                        <br />
                        <a href="mailto:support@nowcerts.com">support@nowcerts.com</a>
                    </p>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
