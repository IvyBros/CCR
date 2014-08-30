<%@ Page MasterPageFile="~/Site.Master" Title="Photos" Language="C#" AutoEventWireup="true" CodeBehind="Photos.aspx.cs" Inherits="CutterCreekRanch.Photos" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style>
        table{
            width:100%;
            padding:20px;
            margin:20px;
        }
        /*table, td, th{
            border-collapse:collapse;
            border: solid thin black;
        }*/
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
        .profile-btn{
            border:none;
            padding:0;
            margin:auto;
            opacity:.5;
            max-width:60px;
            min-width:60px;
        }
        .profile-btn:hover{
            opacity:1;
            background-color:transparent;
        }
        .profile-btn image{
            max-height:50px;
            max-width:50px;
            height:50px;
            width:50px;
        }
        .selected-btn{
            opacity:1;
        }
        .center-txt{
            text-align:center;
            font-style:italic;
            padding-top:5px;
        }
        figure{
            text-align:center;
        }
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <h1>Photos</h1>
    <p>Please select a dog.</p>
    <hr />
    <asp:Repeater runat="server" SelectMethod="GetDogs" ItemType="CutterCreekRanch.Models.Dog">
        <ItemTemplate>
            <button class="btn btn-default profile-btn<%#Item.DogId == id 
                 ? " selected-btn" : String.Empty %>" name="<%#Item.DogId %>" title="<%#Item.Name %>" >
                <img src="/Image/<%#Item.ProfilePic %>/1" class="roundBorder" title="<%#Item.Name %>" />
                <div class="btn-name"><%#Item.Name %></div>
            </button>
        </ItemTemplate>
    </asp:Repeater>
    <hr />
    <table>
        <tr>
            <asp:Repeater runat="server" SelectMethod="GetPhotos" ItemType="CutterCreekRanch.Models.Photo">
                <ItemTemplate>
                    <td>
                        <figure>
                            <a href="/img/photos/<%# Item.URL %>"><img src="/img/photos/<%# Item.ThumbURL%>" class="roundBorder" /></a>
                            <figcaption class="center-txt"><%# Item.Caption %></figcaption>
                        </figure>
                    </td>
                    <% count++; if (count % 3 == 0) { Response.Write("</tr></table><hr/><table><tr>"); }%>
                </ItemTemplate>
            </asp:Repeater>
        </tr>
    </table>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="footerScripts">
    <script>
        $(document).ready(function(){
            $('button').click(function () {
                var path = '/Photos/' + this.name;
                window.location.href = path;
            });
        });
    </script>
</asp:Content>