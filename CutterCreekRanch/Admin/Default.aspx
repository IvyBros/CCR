<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CutterCreekRanch.Admin.Default" %>

<!DOCTYPE html>
<!--
    TODO:
    create /Apply.aspx
    create /Dogs.aspx, add path processing information so you can display one dog if desired.
    add ability to search and sort
    Add ability to upload profile pic
    add ability to upload photos
    add data validation rules
    FIX birthdate.  currently broken.  research storing date times of varying lengths in TSQL/MSSQL w/entity framework,
    maybe using a string for date(not ideal), etc.
    
    decide how to store photos on the site (in the database or on the server as part of the file system)
    create more complex types for photos?
    add functions to optimize photos, auto thumbnailing, cropping, etc.
    additional property of "papers" or certificate?
    consider implementing color as an enum type to allow searching and sorting
    Add pagination to results? 
    split into 2 rows per dog?
-->

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CCR Manage Dogs</title>
    <style>
        table, td, th{
            border:solid thin black; 
            border-collapse:collapse;
        }
        td, th{
            padding:10px;
        }
        .bday{
            width:70px;
        }
        .name{
            width:70px;
        }
        .parent{
            width:20px;
        }
        .price{
            max-width:60px; 
            text-align:right;
        }
        .color{
            width:60px;
            max-width:60px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Manage Dogs</h1>
            <asp:ListView ItemType="CutterCreekRanch.Models.Dog" DataKeyNames="DogId" SelectMethod="GetDogs" 
                UpdateMethod="UpdateDog" DeleteMethod="DeleteDog" InsertMethod="InsertDog" 
                InsertItemPosition="LastItem" EnableViewState="false" runat="server" >
                <LayoutTemplate>
                    <table>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Birthday</th>
                            <th>Mom</th>
                            <th>Dad</th>
                            <th>Sex</th>
                            <th>Description</th>
                            <th>Coloring</th>
                            <th>For Sale?</th>
                            <th>Price</th>                
                            <th>Actions</th>
                        </tr>        
                        <tr runat="server" id="itemPlaceHolder" />
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
                        <td style="white-space:nowrap; text-align:center;">
                            <asp:Button CommandName="edit" Text="Edit" runat="server" />
                            <asp:Button CommandName="delete" Text="Delete" runat="server"/>
                        </td>
                    </tr>
                </ItemTemplate>
                <EditItemTemplate>
                    <tr>
                        <td><%# Item.DogId %><input name="DogId" type="hidden" value="<%# Item.DogId %>" /></td>
                        <td><input name="Name" value="<%# Item.Name %>" class="name" /></td>
                        <td><input name="birthday" type="date" class="bday" 
                            value="<%# Item.Birthdate.ToShortDateString() %>" /></td>
                        <td><input type="number" class="parent" value="<%# Item.Mother %>" name="mother" /></td>
                        <td><input type="number" class="parent" value="<%# Item.Father %>" name="father" /></td>
                        <td>
                            <select name="sex" class="sex">
                                <option <%# Item.Sex == CutterCreekRanch.Models.Gender.Male 
                                                ? "selected=\"selected\"" 
                                                : String.Empty %>" value="Male">M</option>
                                <option <%# Item.Sex == CutterCreekRanch.Models.Gender.Female 
                                                ? "selected=\"selected\"" 
                                                : String.Empty %> value="Female">F</option>
                            </select>
                        </td>
                        <td><textarea name="description" class="description" rows="3" cols="40"><%# Item.Description %></textarea></td>
                        <td><input name="color" class="color" value="<%#Item.Color %>" /></td>
                        <td>
                            <select name="forSale" class="forSale">
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
                        <td><input  class="price" name="price" type="number" value="<%# Item.Price %>" /></td>
                        <td style="white-space:nowrap;">
                            <asp:Button CommandName="Update" Text="Update" runat="server" />
                            <asp:Button CommandName="Cancel" Text="Cancel" runat="server" />
                        </td>
                    </tr>
                </EditItemTemplate>
                <InsertItemTemplate>
                    <tr>
                        <td>+
                            <input name="DogId" type="hidden" value="0" />
                        </td>
                        <td>
                            <input name="name" placeholder="Rover" class="name" />
                        </td>
                        <td><input type="date"   name="birthday" placeholder="12/25/2014" class="bday"  /></td>
                        <td><input type="number" name="mother"   placeholder="1" class="parent"  /></td>
                        <td><input type="number" name="father"   placeholder="2" class="parent"  /></td>
                        <td>
                            <select name="sex" class="sex">
                                <option value="Male">M</option>
                                <option value="Female">F</option>
                            </select>
                        </td>
                        <td><textarea class="description" name="description" rows="3" cols="40" placeholder="Write Description Here"></textarea></td>
                        <td><input class="color" name="color" placeholder="Standard Black and White" /></td>
                        <td>
                            <select class="forSale" name="forSale">
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.ForSale %>">ForSale</option>
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.NotForSale %>">NotForSale</option>
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Sold %>">Sold</option>
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Discounted %>">Discounted</option>
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Adoption %>">Adoption</option>
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.FreeToGoodHome %>">Free</option>
                            </select>
                        </td>
                        <td><input class="price" name="price" placeholder="500.00"  type="number" /></td>
                        <td style="text-align:center;">
                           <asp:Button CommandName="Insert" Text="Add Dog" runat="server" />
                        </td>
                    </tr>
                </InsertItemTemplate>
            </asp:ListView>
    </form>
    <script src="../js/jquery-2.1.1.min.js"></script>
    <script src="../js/jquery-ui-1.10.4.min.js"></script>
    <script>
        $(document).ready(function () {
            $('.bday').datepicker();
        })
    </script>
</body>
</html>
