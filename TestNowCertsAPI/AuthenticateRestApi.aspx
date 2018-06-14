<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AuthenticateRestApi.aspx.cs" Inherits="TestNowCertsAPI.AuthenticateRestApi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Username:
    <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
    <br />
    Password:
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
    <br />
    <asp:Button ID="btnAuthenticate" runat="server" Text="Authenticate" OnClick="btnAuthenticate_Click" />
    <br />
    Result:
    <asp:Literal ID="ltrResult" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
