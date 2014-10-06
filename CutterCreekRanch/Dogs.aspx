<%@ Page Title="Dog Details" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Dogs.aspx.cs" Inherits="CutterCreekRanch.Dogs" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>       
        table, td {
            border: solid thin #ddd;
            border-collapse: collapse;
        }
        td {
            padding: 20px;
        }
        #carousel-dog-details{
            width:580px;
            height:350px;
            float:right;
            margin-left:20px;
            vertical-align:middle;
            border:solid thin black;            
        }
        .carousel-pics{    
            max-height:345px;
            max-width:573px;
            height:345px;
            /*display:block;            */
            margin:auto;
            padding-left:2px;
            /*border-radius:10px;
            border:solid thin black;*/
        }
        .pic-wrapper{
            /*vertical-align:middle;
            padding:25px;

            margin:auto;*/
        }
        .desc-p{
            max-width:300px;
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
            min-height:350px;
            max-height:350px;
            height:350px;
        }
        .desc-buttons button{
            width:100px;
            height:100px;
            margin-left:20px;
            border:solid thin black;
            border-radius:10px;
            float:right;
        }
        .desc-buttons button span{
            font-size:50px;
        }
        .tree-modal-content,
        .documents-modal-content,
        .video-modal-content{
            border:solid thin black;
            max-height:300px;
            min-height:300px;
        }
        #dogNav{
            margin-top:-12px;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <h1><%= Dog.Name %></h1>
    <CCR:DogNav runat="server" />
    <hr />
    <!--carousel-->
    <div id="carousel-dog-details" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <%  for (int i = 0; i < numberOfPhotos; ++i )
                { %>
                    <li data-target="#carousel-dog-details" data-slide-to="<% this.Response.Write(i.ToString()); %>" <%
                        if(i == 0) { %> class="active" <% } %>></li>
            <%  } %>
        </ol>
        <div class="carousel-inner">
            <asp:Repeater runat="server" SelectMethod="GetPicturesByDogId" ItemType="CutterCreekRanch.Models.Photo">
                <ItemTemplate>                    
                    <div class="item <%if(count == 0){ count++; %>active<%}%> pic-wrapper">
                        <a href="/img/photos/<%#Item.URL %>"><img src="/img/photos/<%#Item.CarouselURL 
                           ?? "default.png" %>" class="img-responsive carousel-pics" title="<%# Item.Caption %>" /></a>
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
                        <td><span class="<%: Dog.ForSale.ToString() %>"><%= Dog.Price.ToString("c") %></span></td>
                    </tr>
            <% } %>
        </table>
        
    </div>
    <hr />
    <div class="desc-buttons">
        <button id="tree-modal-btn" class="btn btn-default" title="Family Tree" data-toggle="modal" data-target="#tree-modal">
            <span class="glyphicon glyphicon-leaf"></span><br />Family Tree
        </button>
        <button id="documents-modal-btn" class="btn btn-default" title="ABCA Registration" data-toggle="modal" data-target="#documents-modal">
            <span class="glyphicon glyphicon-certificate"></span><br />ABCA
        </button>
        <button id="video-modal-btn" class="btn btn-default" title="Watch Video" data-toggle="modal" data-target="#video-modal">
            <span class="glyphicon glyphicon-play-circle"></span><br />Play Video
        </button>
        <% if (Dog.ForSale != CutterCreekRanch.Models.ForSaleStatusCode.NotForSale && 
               Dog.ForSale != CutterCreekRanch.Models.ForSaleStatusCode.Sold) 
           { %>
                <form id="form1" runat="server">
                    <button id="apply-modal-btn" class="btn btn-default" title="Apply" type="submit" name="apply" value="<%=Dog.DogId %>">
                        <span class="glyphicon glyphicon-check"></span><br />Apply Now!
                    </button>
                </form>
        <% } %>
    </div>
    <p class="desc-p"><%= Dog.Description %></p>
</asp:Content>
<asp:Content ContentPlaceHolderID="modals" runat="server">
    <!--begin modals-->
    <div id="video-modal" class="modal" tabindex="-1" role="dialog" aria-labelledby="video-modal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Watch Video of <%=Dog.Name %></h4>
                </div>
                <div class="modal-body">
                    <div class="video-modal-content">
                        <%= Dog.VideoUrl %>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div id="documents-modal" class="modal" tabindex="-1" role="dialog" aria-labelledby="video-modal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">ABCA Registration for <%=Dog.Name %></h4>
                </div>
                <div class="modal-body">
                    <div class="documents-modal-content">
                        <%=Dog.CertificateURL %>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <div id="tree-modal" class="modal" tabindex="-1" role="dialog" aria-labelledby="tree-modal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title">Family Tree for <%=Dog.Name %></h4>
                </div>
                <div class="modal-body">
                    <div class="tree-modal-content">
                        <h4>Offspring</h4>
                        <ul>
                            <asp:Repeater ID="Relationships" SelectMethod="GetRelationships" ItemType="CutterCreekRanch.Models.Dog" runat="server">
                                <ItemTemplate>
                                    <li><a href="/Dogs/<%# Item.DogId %>"><%# Item.Name %></a></li>
                                </ItemTemplate>
                            </asp:Repeater>
                        </ul>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <!--//end modals-->
</asp:Content>
<asp:Content ContentPlaceHolderID="footerScripts" runat="server">
    <script>
        $(document).ready(function () {            
            
        });        
    </script>
</asp:Content>