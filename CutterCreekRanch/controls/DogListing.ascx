<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DogListing.ascx.cs" Inherits="CutterCreekRanch.controls.DogListing" ViewStateMode="Disabled" EnableViewState="false" %>
<!--TODO: Implement Photos-->
<asp:Repeater runat="server" SelectMethod="GetDogs" ItemType="CutterCreekRanch.Models.Dog">
    <ItemTemplate>
        <div class="dog">
            <img src="/Image/<%#Item.ProfilePic %>/1" class="profilePic roundBorder" title="<%# Item.Name %>" />
            <div class="profileInfo">
                <h3><a href="/Dogs/<%# Item.DogId %>"><%#Item.Name %></a></h3>
                <p><%# Item.Description %></p>
                <button class="btn btn-default dog-list-btn roundBorder" type="submit" name="apply" value="<%# 
                    Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.NotForSale || 
                    Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.Sold 
                    ? 0 
                    : Item.DogId %>" id="apply-btn">
                    <span class="glyphicon glyphicon-check"></span><br />
                    Apply
                </button>
                <button class="btn btn-default dog-list-btn roundBorder" type="submit" name="photos" value="<%# Item.DogId %>" id="photos-btn">
                    <span class="glyphicon glyphicon-picture"></span><br />
                    Photos
                </button>
                <button class="btn btn-default dog-list-btn roundBorder" type="submit" name="details" value="<%# Item.DogId %>" id="details-btn">
                    <span class="glyphicon glyphicon-eye-open"></span><br />
                    Details
                </button>
                <ul>
                    <li><label>Birthday:</label> <%# Item.Birthdate.ToShortDateString() %></li>
                    <li><label>Gender:</label> <%# Item.Sex.ToString() %></li>
                    <li><label>Price:</label> <span class="<%# Item.ForSale.ToString() ?? String.Empty %>">
                        <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.FreeToGoodHome || 
                            Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.Adoption 
                            ? " FREE" 
                            : Item.Price.ToString("c") %></span> </li>
                    <li><label>Dame:</label> <%#Item.Mother == 0 ? String.Empty : 
                                                String.Format("<a href=\"/Dogs/{0}\">", Item.Mother)
                                             %><%# GetDogNameById(Item.Mother) %>
                                            <%# Item.Mother == 0 ? String.Empty :"</a>" %></li>
                    <li><label>Sire:</label> <%#Item.Father == 0 ? String.Empty : 
                                                String.Format("<a href=\"/Dogs/{0}\">", Item.Father)
                                             %><%# GetDogNameById(Item.Father) %>
                                            <%# Item.Father == 0 ? String.Empty :"</a>" %></li>
                </ul>            
            </div>
        </div>
        <hr />
    </ItemTemplate>
</asp:Repeater>
