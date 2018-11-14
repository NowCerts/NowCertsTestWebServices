<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="RefreshToken.aspx.cs" Inherits="TestNowCertsAPI.RefreshToken" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    Authentication Status:
    <asp:Label ID="ltrAuthenticationStatus" runat="server"></asp:Label>

    <div class="main">
        <h3>Access Token:</h3>
        <br />
        <span class="accessToken"></span>
        <h3>Expiration date:</h3>
        <br />
        <span class="expirationDate"></span>

        <div style="margin-top: 40px;">
            <asp:Button ID="btnGetToken" class="btn-get-token" runat="server" Text="Get New Token" OnClientClick="return false;" />
        </div>

        <div style="margin-top: 15px;">
            <strong>
                <asp:Label ID="ltrRequestUrl" runat="server"></asp:Label></strong>
            <br />
            <asp:Label ID="ltrResultMessage" runat="server"></asp:Label>
        </div>

        <h3>New Access Token:</h3>
        <br />
        <span class="new-accessToken"></span>
        <h3>New Expiration date:</h3>
        <br />
        <span class="new-expirationDate"></span>

    </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="scripts" runat="server">
    <script>
        $('document').ready(function () {
            var $btnGetToken = $('.btn-get-token'),
                $accessToken = $(".accessToken"),
                $expirationDate = $(".expirationDate"),
                authorizationData = localStorage.getItem('authorizationData');

            if (authorizationData) {
                authorizationData = JSON.parse(authorizationData);
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are already authenticated.";

                $accessToken.text(authorizationData["access_token"]);
                $expirationDate.text(authorizationData[".expires"]);

                refreshToken = authorizationData["refresh_token"];
                clientId = authorizationData["as:client_id"];
                data = `grant_type=refresh_token&refresh_token=${refreshToken}&client_id=${clientId}`;

                tokenUrl = `<%=ConfigurationHelper.ApiUrl%>token`;
            }
            else {
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are not authenticated. Please Authenticate.";
                $(".main").hide();
            }

            $btnGetToken.on('click', function () {
                $.ajax({
                    method: "POST",
                    url: tokenUrl,
                    data: data,
                    contentType: 'text/plain'
                })
                    .fail(function (error) {
                        document.getElementById("<%=ltrResultMessage.ClientID %>").innerHTML = `Error. Please try again or re-authenticate.`;
                    })
                    .done(function (result) {
                        if (result && result.access_token) {
                            localStorage.setItem("authorizationData", JSON.stringify(result));

                            $(".new-accessToken").text(result["access_token"]);
                            $(".new-expirationDate").text(result[".expires"]);

                            $accessToken.text(authorizationData["access_token"]);
                            $expirationDate.text(authorizationData[".expires"]);

                            authorizationData = result;

                            refreshToken = authorizationData["refresh_token"];
                            clientId = authorizationData["as:client_id"];
                            data = `grant_type=refresh_token&refresh_token=${refreshToken}&client_id=${clientId}`;
                        }
                    });
            });
        });

    </script>
</asp:Content>
