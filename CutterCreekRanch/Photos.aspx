<%@ Page MasterPageFile="~/Site.Master" Title="Photos" Language="C#" AutoEventWireup="true" CodeBehind="Photos.aspx.cs" Inherits="CutterCreekRanch.Photos" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style>
        table{
            width:100%;
            padding:20px;
            margin:20px;
        }
        table, td, th{
            border-collapse:collapse;
            border: solid thin black;
        }
        th, td{
            padding:5px;
        }
        th {
            margin:auto;
            text-align:center;
            vertical-align:middle;
            font-size:x-large;
        }
        .thumbPhoto{
            width: 150px;
            border: solid thin black;
            padding:5px;
        }
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <h1>Photos</h1>
    <p>A picture is worth a thousand words.</p>
    <h1><% if (id != 0) Response.Write(dogs.First().Name); else Response.Write("Select A Dog"); %></h1>
    <hr />
    <asp:Repeater runat="server" SelectMethod="GetDogs" ItemType="CutterCreekRanch.Models.Dog">
        <ItemTemplate>
            <button class="btn btn-default">
                <img src="Image/<%#Item.ProfilePic %>" class="roundBorder" />
            </button>
        </ItemTemplate>
    </asp:Repeater>
    <table>
        <tr>
            <asp:Repeater runat="server" SelectMethod="GetPhotos" ItemType="CutterCreekRanch.Models.Photo">
                <ItemTemplate>
                    <td>
                        <figure>
                            <img src="/img/photos/<%# Item.URL %>" class="roundBorder" />
                            <figcaption><%# Item.Caption %></figcaption>
                        </figure>
                    </td>
                    <% count++; if (count % 4 == 0) { Response.Write("</tr><tr>"); }%>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
    </table>
</asp:Content>