<%@ Page Title="Offerings" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Offerings.aspx.cs" Inherits="CutterCreekRanch.Services" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <!--
    TODO: implement paging?
          create a search
          implement sorting/filtering results?
    -->
    <style>
        
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    K so the plan is to build an "<a href="Admin/" >admin</a>" section of the site.  The content of this page will be dynamically generated
    from input managed and created by the admin. (i'm thinking dad)  I'd like to see a list of pups for sale here
    with as much information about them as we can capture, for instance, date of birth, coloring/classification, sex,
    parents, profile picture, additional picture(s), a short description of their personality, etc. See an example below:
    <hr />
    <h1>Future Best Friends</h1>
    <CCR:DogListing runat="server" />
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="footerScripts">
    <script>
       
    </script>
</asp:Content>