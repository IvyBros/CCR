<%@ Page Title="All Dogs" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="AllDogs.aspx.cs" Inherits="CutterCreekRanch.AllDogs" %>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1>All Dogs</h1>
    <CCR:DogListing runat="server" Unfiltered="true" />
</asp:Content>