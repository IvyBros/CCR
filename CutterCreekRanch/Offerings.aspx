<%@ Page Title="Offerings" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Offerings.aspx.cs" Inherits="CutterCreekRanch.Services" %>

<asp:Content runat="server" ContentPlaceHolderID="head">
    <!--
    TODO: implement paging?
          create a search
          implement sorting/filtering results?
          Add button to "View All Dogs"
    -->
    <style>
        
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <p>
        Here you can find a list of pups currently or recently for sale.  You can also view additional information about 
        each dog such as date of birth, coloring, sex, parents, additional pictures, a short description of their personality, etc. 
        by clicking on their picture or one of the provided buttons.  To view a history of all our dogs, click 
        <a style="font-weight:bold;" href="AllDogs.aspx">here</a>
    </p>
    <hr />
    <h1>Future Best Friends</h1>
    <form id="form1" runat="server">
        <CCR:DogListing runat="server" />
    </form>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="footerScripts">
    <script>
       
    </script>
</asp:Content>