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
    <h2>Photos</h2>
    <p>A picture is worth a thousand words.</p>
    <asp:Repeater ID="dog" runat="server" SelectMethod="GetDogs" ItemType="System.String">
        <ItemTemplate>
            <table>
                <thead>
                    <tr>
                        <th colspan="5">
                            <%# Item %>
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="photoAlbums" runat="server" ItemType="CutterCreekRanch.Thumbs" DataSource="<%# GetThumbsByDogName(Item) %>" >
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <a href="<%#Item.ImageURL %>">
                                        <img src="<%#Item.ThumbURL %>" title="<%#Item.Name %>,<%#Item.Date.ToShortDateString() %>" class="thumbPhoto img-responsive img-rounded" />
                                    </a>
                                </td>                                
                            </tr>  
                        </ItemTemplate>
                    </asp:Repeater>    
                </tbody>
            </table>
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>