<%@ Page Title="All Dogs" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="AllDogs.aspx.cs" Inherits="CutterCreekRanch.AllDogs" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1>All Dogs</h1>
    <form id="form1" runat="server">
        <CCR:DogListing runat="server" Unfiltered="true" />
    </form>
</asp:Content>