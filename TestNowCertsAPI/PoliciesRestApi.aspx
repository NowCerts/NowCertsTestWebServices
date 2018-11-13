<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PoliciesRestApi.aspx.cs" Inherits="TestNowCertsAPI.PoliciesRestApi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Policy Number:
    <asp:TextBox ID="txtPolicyNumber" class="txt-policy-number" runat="server"></asp:TextBox>
    <br />
    Insured Name:
    <asp:TextBox ID="txtInsuredName" class="txt-insured-name" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="btnAuthenticate" class="btn-submit" runat="server" Text="Create Policy" OnClientClick="return false;" />
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
            var $policyNumber = $('.txt-policy-number'),
                $insuredName = $('.txt-insured-name'),
                $btn = $('.btn-submit'),
                valid = false,
                authorizationData = localStorage.getItem('authorizationData');

            if (authorizationData) {
                authorizationData = JSON.parse(authorizationData);
                document.getElementById("<%=ltrAuthenticationStatus.ClientID %>").innerHTML = "You are already authenticated.";

                $btn.on("click", function () {
                    var policyNumberValue = $policyNumber.val(),
                        insuredNameValue = $insuredName.val(),
                        toSend = {};

                    if (policyNumberValue && insuredNameValue) {
                        toSend['number'] = policyNumberValue;
                        toSend['insuredName'] = insuredNameValue;

                        valid = true;
                    }

                    if (valid) {
                        console.log(toSend);

                        if (authorizationData) {
                            $.ajax({
                                method: "POST",
                                url: "<%=ConfigurationHelper.ApiUrl%>Policy/Insert",
                                headers: { 'Authorization': authorizationData.token_type + ' ' + authorizationData.access_token },
                                contentType: 'application/json',
                                data: JSON.stringify(toSend)
                            })
                                .fail(function (error) {
                                    document.getElementById("<%=ltrResultMessage.ClientID %>").innerHTML = "Error. Please try again or re-authenticate.";
                                })
                                .done(function (result) {
                                    console.log(result);
                                    document.getElementById("<%=ltrResultMessage.ClientID %>").innerHTML = "The Policy has been imported successfully.";
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
