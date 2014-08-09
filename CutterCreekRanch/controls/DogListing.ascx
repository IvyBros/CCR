﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DogListing.ascx.cs" Inherits="CutterCreekRanch.controls.DogListing" ViewStateMode="Disabled" EnableViewState="false" %>
<asp:Repeater runat="server" SelectMethod="GetDogs" ItemType="CutterCreekRanch.Models.Dog">
    <ItemTemplate>
        <div class="dog">
            <a href="~/Dogs/<%# Item.DogId %>" />
                <img src="<%# Item.ProfilePic ?? "~/img/photos/defaultProfilePic.jpg"
                        %>" title="<%# Item.Name %>" class="profilePic roundBorder" />
            </a>
            <div class="profileInfo">
                <h3><%#Item.Name %></h3>
                <p><%# Item.Description %></p>
                <img src="<%# Item.Photos != null 
                            ? Item.Photos.ElementAt(0) 
                            ?? "img/photos/default-thumb-0.jpg" 
                            :  "img/photos/default-thumb-0.jpg" %>" class="morePhotos roundBorder" />
                <img src="<%# Item.Photos != null
                            ? Item.Photos.ElementAt(1)
                            ?? "img/photos/default-thumb-1.jpg"
                            :  "img/photos/default-thumb-1.jpg" %>" class="morePhotos roundBorder" />
                <img src="<%# Item.Photos != null
                            ? Item.Photos.ElementAt(1)
                            ?? "img/photos/default-thumb-2.jpg"
                            :  "img/photos/default-thumb-2.jpg" %>" class="morePhotos roundBorder" />
                <ul>
                    <li><label>Birthday:</label> <%# Item.Birthdate.ToShortDateString() %></li>
                    <li><label>Gender:</label> <%# Item.Sex.ToString() %></li>
                    <li><label>Price:</label> <span class="<%# Item.ForSale.ToString() ?? String.Empty %>">
                        <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.FreeToGoodHome || 
                            Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.Adoption 
                            ? " FREE" 
                            : Item.Price.ToString("c") %></span> </li>
                    <li><label>Dame:</label> <a href="dogs/<%# Item.Mother %>"><%# GetDogNameById(Item.Mother) %></a></li>
                    <li><label>Sire:</label> <a href="dogs/<%# Item.Father %>"><%# GetDogNameById(Item.Father) %></a></li>
                </ul>            
            </div>
        </div>
        <hr />
    </ItemTemplate>
</asp:Repeater>
