<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PoliciesRestApi.aspx.cs" Inherits="TestNowCertsAPI.PoliciesRestApi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Policy Number:
    <asp:TextBox ID="txtPolicyNumber" class="txt-policy-number" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="btnAuthenticate" class="btn-submit" runat="server" Text="Create Policy" OnClientClick="return false;" />
    <br />
    Result:
    <asp:Literal ID="ltrResult" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="scripts" runat="server">
	<script>
		$('document').ready(function() {
			var $policyNumber = $('.txt-policy-number'),
				$btn = $('.btn-submit'),
				valid = false,
				authorizationData = localStorage.getItem('authorizationData');

			$btn.on("click", function() {
				var policyNumberValue = $policyNumber.val(),
					toSend = {};

				if (policyNumberValue) {
					toSend['policyNumber'] = policyNumberValue;
					valid = true;
				}

				if (valid) {
					console.log(toSend);

					if (authorizationData) {
						$.ajax({
							method: "POST",
							url: "https://api.nowcerts.com/Policies",
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
