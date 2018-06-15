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
    <asp:Literal ID="ltrResult" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="scripts" runat="server">
    <script>
        $('document').ready(function() {
            var $username = $('.txt-username'),
                $password = $('.txt-password'),
                $btn = $('.btn-submit'),
                valid = false;

            $btn.on("click", function() {
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

                    console.log(toSend);
                    console.log(dataToSend);

                    $.ajax({
                        method: "POST",
                        url: "https://api.nowcerts.com/token",
                        contentType: 'application/json',
                        data: dataToSend
                    })
                    .done(function(result) {
                        console.log(result);
                        // Save the transformed result to local storage - authorizationData with token inside.
                        
                    });
                }
            });
        });
    </script>
</asp:Content>
