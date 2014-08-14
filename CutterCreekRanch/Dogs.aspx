<%@ Page Title="Dog Details" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Dogs.aspx.cs" Inherits="CutterCreekRanch.Dogs" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        table, td {
            border: solid thin black;
            border-collapse: collapse;
        }
        td {
            padding: 20px;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1><%= Dog.Name %></h1>
    <table>
        <tr>
            <td>Gender:</td>
            <td><%= Dog.Sex %></td>
        </tr>
        <tr>
            <td>Birthdate:</td>
            <td><%= Dog.Birthdate.ToShortDateString() %></td>
        </tr>
        <tr>
            <td>Mother:</td>
            <td>
                <%= Mother != null ? String.Format("<a href=\"{0}\">", Mother.DogId) : String.Empty %>
                <%= Mother != null ? Mother.Name ?? "Unknown" : "Unknown" %>
                <%= Mother != null ? "</a>" : String.Empty %>
            </td>
        </tr>
        <tr>
            <td>Father:</td>
            <td>
                <%= Father != null ? String.Format("<a href=\"{0}\">", Father.DogId) : String.Empty %>
                <%= Father != null ? Father.Name ?? "Unknown" : "Unknown" %>
                <%= Father != null ? "</a>" : String.Empty %>
            </td>
        </tr>
        <% if (Dog.ForSale != CutterCreekRanch.Models.ForSaleStatusCode.NotForSale) 
           { %> 
                <tr>
                    <td>Price:</td>
                    <td><span class="<%: Dog.ForSale.ToString() %>"><%= Dog.Price %></span></td>
                </tr>
        <% } %>
    </table>
</asp:Content>
<asp:Content ContentPlaceHolderID="footerScripts" runat="server">
    <script>
        //
    </script>
</asp:Content>