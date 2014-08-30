<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ViewPersonDetails.aspx.cs" Inherits="CutterCreekRanch.Admin.ViewPersonDetails" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        label{
            font-weight:bold;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="main" runat="server">
    <h1><%= person.Name %> </h1>
    <hr />
    <table>
        <tr>
            <td><label>Person Id:</label></td>
            <td><%= person.PersonId %></td>
        </tr>
        <tr>
            <td><label>Name:</label></td>
            <td><%= person.Name %></td>
        </tr>
        <tr>
            <td><label>Email:</label></td>
            <td><a href="mailto:<%= person.Email %>"><%= person.Email %></a></td>
        </tr>
        <tr>
            <td><label>Phone:</label></td>
            <td><%= person.Phone %></td>
        </tr>
        <tr>
            <td><label>Age:</label></td>
            <td><%= person.BirthYear.HasValue ? (DateTime.Now.Year - person.BirthYear.Value.Year).ToString() : "Unknown" %></td>
        </tr>
        <tr>
            <td><label>Dog:</label></td>
            <td><%= dog != null ? dog.Name : "None" %></td>
        </tr>
        <tr>
            <td><label>Number of People in Household:</label></td>
            <td><%= person.NumInHousehold %></td>
        </tr>
        <tr>
            <td><label>Home Ownership Status:</label></td>
            <td><%= person.HomeOwner.HasValue ? person.HomeOwner.Value.ToString() : "Unknown" %></td>
        </tr>
        <tr>
            <td><label>Does this person have a yard:</label></td>
            <td><%= person.HaveYard == true ? "Yes" : "No/Unknown" %></td>
        </tr>
        <tr>
            <td><label>Reason Why this person wants a dog:</label></td>
            <td><%= person.Reason %></td>
        </tr>
        <tr>
            <td><label>Pet Ownership Experience:</label></td>
            <td><%= person.PetOwnershipExperience %></td>
        </tr>
    </table>
</asp:Content>
<asp:Content ContentPlaceHolderID="footer" runat="server">

</asp:Content>