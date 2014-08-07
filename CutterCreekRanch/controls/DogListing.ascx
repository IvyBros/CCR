<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DogListing.ascx.cs" Inherits="CutterCreekRanch.controls.DogListing" %>
<asp:Repeater runat="server" SelectMethod="GetDogs" ItemType="CutterCreekRanch.Models.Dog">
    <ItemTemplate>
        <div class="dog">
            <img src="test" title="<%# Item.Name %>" class="profilePic" />
            <div class="profileInfo">
                <h3><%#Item.Name %></h3>
                <p>
                    <%# Item.Description %>
                </p>
                <hr />
                <img src="img/photos/test.jpg" class="morePhotos" />
                <img src="img/photos/test.jpg" class="morePhotos" />
                <img src="img/photos/test.jpg" class="morePhotos" />
                <ul>
                    <li><label>Birthday:</label> <%#Item.Birthdate.ToShortDateString() %></li>
                    <li><label>Gender:</label> <%# Item.Sex.ToString() %></li>
                    <li><label>Price:</label> <%# Item.Price.ToString("c") %> </li>
                    <%--<li><label>Dame:</label> <a href="something"><%# Item.Mother %></a></li>
                    <li><label>Sire:</label> <a href="dogs"><%# Item.Father %></a></li>--%>
                </ul>            
            </div>
        </div>
        <hr />
    </ItemTemplate>
</asp:Repeater>
