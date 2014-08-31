<%@ Page Title="Manage Dogs" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageDogs.aspx.cs" Inherits="CutterCreekRanch.Admin.Default" %>
<asp:Content ContentPlaceHolderID="main" runat="server">
    
<!--
    TODO:
    Assigned to Ryan: style and theme for phone, tablet, larger displays, etc.

    add ability to search and sort?
    Add ability to choose a profile picture, crop, resize, zoom, etc.
   
    add video link functionality
    consider implementing color as an enum type to allow searching and sorting
    Add pagination to results
-->
    <form id="form1" runat="server">
        <asp:ListView ItemType="CutterCreekRanch.Models.Dog" DataKeyNames="DogId" SelectMethod="GetDogs" 
            UpdateMethod="UpdateDog" DeleteMethod="DeleteDog" InsertMethod="InsertDog" 
            InsertItemPosition="LastItem" EnableViewState="false" runat="server" ClientIDMode="Static" >
            <LayoutTemplate>
                <table id="dogsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Birthday</th>
                            <th>Mom</th>
                            <th>Dad</th>
                            <th>Sex</th>
                            <th>Description</th>
                            <th>Coloring</th>
                            <th>Sale Status</th>
                            <th>Price</th>
                            <th>Profile Pic</th>
                            <th>Actions</th>
                        </tr>        
                    </thead>
                    <tbody>
                        <tr runat="server" id="itemPlaceHolder" />
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Item.DogId %></td>
                    <td><%# Item.Name %></td>
                    <td><%# Item.Birthdate.ToShortDateString() %></td>
                    <td><%# Item.Mother %></td>
                    <td><%# Item.Father %></td>
                    <td><%# Item.Sex %></td>
                    <td><%# Item.Description %></td>
                    <td><%# Item.Color %></td>
                    <td><%# Item.ForSale %></td>
                    <td style="text-align:right;"><%# Item.Price.ToString("c") %></td>
                    <td><img src="/Image/<%# Item.ProfilePic != null ? Item.ProfilePic : 0 %>/1" style="max-width:75px; max-height:75px;" /></td>
                    <td style="white-space:nowrap; text-align:center;">
                        <asp:Button CommandName="edit" Text="Edit" runat="server" />
                        <asp:Button CommandName="delete" Text="Delete" runat="server"/>
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td><%# Item.DogId %><input name="DogId" type="hidden" value="<%# Item.DogId %>" /></td>
                    <td><input name="Name" value="<%# Item.Name %>" class="name"  required="required" /></td>
                    <td><input name="BirthDate" type="date" class="bday" value="<%# Item.Birthdate.ToShortDateString() %>" /></td>
                    <td><input type="number" class="parent" value="<%# Item.Mother %>" name="mother" /></td>
                    <td><input type="number" class="parent" value="<%# Item.Father %>" name="father" /></td>
                    <td>
                        <select name="Sex" class="sex">
                            <option <%# Item.Sex == CutterCreekRanch.Models.Gender.Male 
                                            ? "selected=\"selected\"" 
                                            : String.Empty %>" value="<%# Item.Sex %>">M</option>
                            <option <%# Item.Sex == CutterCreekRanch.Models.Gender.Female 
                                            ? "selected=\"selected\"" 
                                            : String.Empty %> value="<%# Item.Sex %>">F</option>
                        </select>
                    </td>
                    <td><textarea name="Description" class="description" rows="3" cols="40"><%# Item.Description %></textarea></td>
                    <td><input name="Color" class="color" value="<%# Item.Color %>" /></td>
                    <td>
                        <select name="ForSale" class="forSale">
                            <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.ForSale
                                        ? "selected=\"selected\""
                                        : String.Empty %> value="<%= CutterCreekRanch.Models.ForSaleStatusCode.ForSale %>">ForSale</option>
                            <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.NotForSale
                                        ? "selected=\"selected\""
                                        : String.Empty %> value="<%= CutterCreekRanch.Models.ForSaleStatusCode.NotForSale %>">NotForSale</option>
                            <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.Sold
                                        ? "selected=\"selected\""
                                        : String.Empty %> value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Sold %>">Sold</option>
                            <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.Discounted
                                        ? "selected=\"selected\""
                                        : String.Empty %> value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Discounted %>">Discounted</option>
                            <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.Adoption
                                        ? "selected=\"selected\""
                                        : String.Empty %> value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Adoption %>">Adoption</option>
                            <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.FreeToGoodHome
                                        ? "selected=\"selected\""
                                        : String.Empty %> value="<%= CutterCreekRanch.Models.ForSaleStatusCode.FreeToGoodHome %>">Free</option>
                        </select>
                    </td>
                    <td><input name="Price" type="number" value="<%# Item.Price %>"  class="price" /></td>
                    <td><input name="ProfilePic" type="number" value="<%#Item.ProfilePic %>" class="parent" /></td>
                    <td style="white-space:nowrap;">
                        <asp:Button CommandName="update" Text="Update" runat="server" />
                        <asp:Button CommandName="cancel" Text="Cancel" runat="server" />
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr>
                    <td>+
                        <input name="DogId" type="hidden" value="0" />
                    </td>
                    <td>
                        <input name="Name" placeholder="Rover" class="name"/>
                    </td>
                    <td><input type="date"   name="Birthdate" placeholder="12/25/2014" class="bday"  /></td>
                    <td><input type="number" name="Mother"    placeholder="1" class="parent"  /></td>
                    <td><input type="number" name="Father"    placeholder="2" class="parent"  /></td>
                    <td>
                        <select name="Sex" class="sex">
                            <option value="0">M</option>
                            <option value="1">F</option>
                        </select>
                    </td>
                    <td><textarea class="description" name="description" rows="3" cols="40" placeholder="Write Description Here"></textarea></td>
                    <td><input class="color" name="color" placeholder="Standard Black and White" /></td>
                    <td>
                        <select class="forSale" name="ForSale">
                            <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.ForSale %>">ForSale</option>
                            <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.NotForSale %>">NotForSale</option>
                            <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Sold %>">Sold</option>
                            <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Discounted %>">Discounted</option>
                            <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Adoption %>">Adoption</option>
                            <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.FreeToGoodHome %>">Free</option>
                        </select>
                    </td>
                    <td><input class="price"  name="Price" placeholder="500.00"  type="number" /></td>
                    <td><input class="parent" name="ProfilePic" placeholder="0" type="number" /></td>
                    <td style="text-align:center;">
                        <asp:Button CommandName="Insert" Text="Add Dog" runat="server" />
                    </td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
    </form>
</asp:Content>
<asp:Content ContentPlaceHolderID="footer" runat="server">
    <script>
        $(document).ready(function () {
            $('#dogsTable').DataTable();
            $('.bday').datepicker();
        });
    </script>
</asp:Content>
    