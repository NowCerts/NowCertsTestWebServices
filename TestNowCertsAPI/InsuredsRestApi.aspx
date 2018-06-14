<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="InsuredsRestApi.aspx.cs" Inherits="TestNowCertsAPI.InsuredsRestApi" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    Commercial Name:
    <asp:TextBox ID="txtCommercialName" runat="server"></asp:TextBox>
    <br />
    or
    <br />
    Personal First Name:
    <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
    Last Name:
    <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
    <br />
    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
    <br />
    Result Status:
    <asp:Literal ID="ltrResultStatus" runat="server"></asp:Literal>
    <br />
    Result Message:
    <asp:Literal ID="ltrResultMessage" runat="server"></asp:Literal>
</asp:Content>

<asp:Content ID="ContentScripts" ContentPlaceHolderID="scripts" runat="server">
</asp:Content>
