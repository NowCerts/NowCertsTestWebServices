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
    Result Status:
    <asp:Literal ID="ltrResultStatus" runat="server"></asp:Literal>
    <br />
    Result Message:
    <asp:Literal ID="ltrResultMessage" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="scripts" runat="server">
    <script>
        $('document').ready(function() {
            var $commercialName = $('.txt-commercial-name'),
                $firstName = $('.txt-first-name'),
                $lastName = $('.txt-last-name'),
                $btn = $('.btn-submit'),
                valid = false,
                authorizationData = localStorage.getItem('authorizationData');

            $btn.on("click", function() {
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
                            url: "https://api.nowcerts.com/Insureds",
                            headers: { 'Authorization': 'Bearer ' + authorizationData.token },
                            contentType: 'application/json',
                            data: JSON.stringify(toSend)
                        })
                        .done(function( result ) {
                            console.log(result);
                        });
                    } else {
                        console.log('No authorization!');
                    }
                }
            });
        });
    </script>
</asp:Content>
