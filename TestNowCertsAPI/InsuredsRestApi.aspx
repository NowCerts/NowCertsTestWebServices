<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InsuredsRestApi.aspx.cs" Inherits="TestNowCertsAPI.InsuredsRestApi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Commercial Name:
    <asp:TextBox ID="txtCommercialName" class="txt-commercial-name" runat="server"></asp:TextBox>
    <br />
    or
    <br />
    Personal First Name:
    <asp:TextBox ID="txtFirstName" class="txt-first-name" runat="server"></asp:TextBox>
    Last Name:
    <asp:TextBox ID="txtLastName" class="txt-last-name" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="btnSubmit" class="btn-submit" runat="server" Text="Submit" OnClientClick="return false;" />
    <br />
    Authentication Status:
    <asp:Label ID="ltrAuthenticationStatus" runat="server"></asp:Label>
    <br />
    Result Message:
    <asp:Label ID="ltrResultMessage" runat="server"></asp:Label>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="scripts" runat="server">
    <script>
        $('document').ready(function () {
            var $commercialName = $('.txt-commercial-name'),
                $firstName = $('.txt-first-name'),
                $lastName = $('.txt-last-name'),
                $btn = $('.btn-submit'),
                valid = false,
                authorizationData = localStorage.getItem('authorizationData');

            if (authorizationData) {
                authorizationData = JSON.parse(authorizationData);
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are already authenticated.";

                $btn.on("click", function () {
                    var commercialNameValue = $commercialName.val(),
                        firstNameValue = $firstName.val(),
                        lastNameValue = $lastName.val(),
                        toSend = {};

                    if (commercialNameValue) {
                        toSend['commercialName'] = commercialNameValue;
                        valid = true;
                    } else if (firstNameValue && lastNameValue) {
                        toSend['firstName'] = firstNameValue;
                        toSend['lastName'] = lastNameValue;
                        valid = true;
                    }

                    if (valid) {
                        toSend['active'] = true,
                            toSend['addressLine1'] = "AddrLine1",
                            toSend['stateNameOrAbbreviation'] = "FL",
                            toSend['description'] = "imported from Web Services",
                            console.log(toSend);

                        if (authorizationData) {
                            $.ajax({
                                method: "POST",
                                url: "https://api.nowcerts.com/api/Insured/Insert",
                                headers: { 'Authorization': authorizationData.token_type + ' ' + authorizationData.access_token },
                                contentType: 'application/json',
                                data: JSON.stringify(toSend)
                            })
                                .fail(function (error) {
                                    document.getElementById("<%=ltrResultMessage.ClientID %>").innerHTML = "Error. Please try again or re-authenticate.";
                                })
                                .done(function (result) {
                                    console.log(result);
                                    document.getElementById("<%=ltrResultMessage.ClientID %>").innerHTML = "The Insured has been imported successfully.";
                                });
                        } else {
                            console.log('No authorization!');
                        }
                    }
                });
            }
            else {
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are not authenticated. Please Authenticate.";
            }
        });
    </script>
</asp:Content>
