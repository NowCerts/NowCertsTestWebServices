<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AuthenticateRestApi.aspx.cs" Inherits="TestNowCertsAPI.AuthenticateRestApi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Username:
    <asp:TextBox ID="txtUsername" class="txt-username" runat="server"></asp:TextBox>
    <br />
    Password:
    <asp:TextBox ID="txtPassword" class="txt-password" runat="server" TextMode="Password"></asp:TextBox>
    <br />
    <asp:Button ID="btnAuthenticate" class="btn-submit" runat="server" Text="Authenticate" OnClientClick="return false;" />
    <br />
    Result:
    <asp:Label ID="lblResult" runat="server"></asp:Label>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="scripts" runat="server">
    <script>
        $('document').ready(function () {
            var $username = $('.txt-username'),
                $password = $('.txt-password'),
                $btn = $('.btn-submit'),
                valid = false;

            localStorage.clear();

            $btn.on("click", function () {
                var usernameValue = $username.val(),
                    passwordValue = $password.val(),
                    toSend = {};

                if (usernameValue && passwordValue) {
                    toSend['username'] = usernameValue;
                    toSend['password'] = passwordValue;
                    valid = true;
                }

                if (valid) {
                    var dataToSend = `grant_type=password&username=${usernameValue}&password=${passwordValue}`;
                    if (true) { // loginData.useRefreshTokens
                        dataToSend = `${dataToSend}&client_id=ngAuthApp`;
                    }

                    //var dataJson = {};
                    //dataJson.grant_type = "password";
                    //dataJson.username = usernameValue;
                    //dataJson.password = passwordValue;
                    //dataJson.client_id = "ngAuthApp";

                    console.log(toSend);
                    console.log(dataToSend);

                    $.ajax({
                        method: "POST",
                        url: "https://api.nowcerts.com/api/token",
                        contentType: 'application/json',
                        data: dataToSend,
                        success: function (result) {
                            if (result && result.access_token) {
                                localStorage.setItem("authorizationData", JSON.stringify(result));
                                document.getElementById("<%=lblResult.ClientID%>").innerHTML = "You've been authenticated successfully. You can go to Insureds and Policies pages to test import functionality.";
                            }
                        },
                        error: function (r) {
                            if (r.responseJSON && r.responseJSON.error && r.responseJSON.error_description) {
                                document.getElementById("<%=lblResult.ClientID%>").innerHTML = r.responseJSON.error_description;
                            }
                        }
                    })
                }
            });
        });
    </script>
</asp:Content>
