<%@ Page Title="Dog Details" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Dogs.aspx.cs" Inherits="CutterCreekRanch.Dogs" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        table{
            margin:auto;
            /*margin-top:20px;
            margin-bottom:50px;*/
        }
        table, td {
            border: solid thin black;
            border-collapse: collapse;
        }
        td {
            padding: 20px;
        }
        #carousel-dog-details{
            width:500px;
            height:350px;
            float:right;
            margin-left:30px;
            /*margin-top:30px;*/
        }
        .carousel-pics{    
            max-height:350px;
            height:350px;
            display:block;
            margin-left:auto;
            margin-right:auto;
        }
        .desc-p{
            padding-bottom:30px;
            padding-top:10px;
        }
        .small-pics{
            float:right;
            width:150px;
        }
        td:first-child{
            font-weight:bolder;
        }
        #dog-demo-wrapper{
            display:block;
            margin:auto;
            min-height:350px;
            max-height:350px;
            height:350px;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1><%= Dog.Name %></h1>
    <CCR:DogNav runat="server" DogId="<% Dog.DogId %>"/>
    <hr />
    <!--carousel-->
    <div id="carousel-dog-details" class="carousel slide roundBorder" data-ride="carousel">
        <ol class="carousel-indicators">
            <%  for (int i = 0; i < repo.Photos.Where(x => x.DogId == Dog.DogId).Count(); ++i )
                { %>
                    <li data-target="#carousel-dog-details" data-slide-to="<% this.Response.Write(i.ToString()); %>" <%
                        if(i == 0) { %> class="active" <% } %>></li>
            <%  } %>
        </ol>
        <div class="carousel-inner">
            <asp:Repeater runat="server" SelectMethod="GetPicturesByDogId" ItemType="CutterCreekRanch.Models.Photo">
                <ItemTemplate>
                    <div class="item <%if(count==0){ count++; %>active<%}%>">
                        <img src="<%#Item.URL %>" class="img-responsive carousel-pics" title="<%# Item.Caption %>" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>            
        </div>
        <a class="left carousel-control" href="#carousel-dog-details" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#carousel-dog-details" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>
    <!--end carousel-->
    <div id="dog-demo-wrapper">
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
    </div>
    <p class="desc-p"><%= Dog.Description %></p>
</asp:Content>
<asp:Content ContentPlaceHolderID="footerScripts" runat="server">
    <script>
        //
    </script>
</asp:Content>