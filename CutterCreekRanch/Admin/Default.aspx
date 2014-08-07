<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CutterCreekRanch.Admin.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        
        table, td, th{
            border:solid thin black; 
            border-collapse:collapse;
        }
        td, th{
            padding:2px;
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
                        <td><input name="Name" value="<%# Item.Name %>" /></td>
                        <td><input type="date" name="birthday" class="bday" value="<%# Item.Birthdate.ToShortDateString() %>" /></td>
                        <td>
                            <select name="sex">
                                <option <%# Item.Sex == CutterCreekRanch.Models.Gender.Male 
                                                ? "selected=\"selected\"" 
                                                : String.Empty %>" 
                                    value="Male">Male</option>
                                <option <%# Item.Sex == CutterCreekRanch.Models.Gender.Female 
                                                ? "selected=\"selected\"" 
                                                : String.Empty %> 
                                    value="Female">Female</option>
                            </select>
                        </td>
                        <td><textarea name="description" rows="3" cols="40"><%# Item.Description %></textarea></td>
                        <td><input name="color" value="<%#Item.Color %>" /></td>
                        <td>
                            <select name="forSale">
                                <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.ForSale
                                            ? "selected=\"selected\""
                                            : String.Empty %> 
                                    value="<%= CutterCreekRanch.Models.ForSaleStatusCode.ForSale %>">ForSale</option>
                                <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.NotForSale
                                            ? "selected=\"selected\""
                                            : String.Empty %> 
                                    value="<%= CutterCreekRanch.Models.ForSaleStatusCode.NotForSale %>">NotForSale</option>
                                <option <%# Item.ForSale == CutterCreekRanch.Models.ForSaleStatusCode.Sold
                                            ? "selected=\"selected\""
                                            : String.Empty %> 
                                    value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Sold %>">Sold</option>
                            </select>
                        </td>
                        <td><input style="max-width:60px; text-align:right;" name="price" type="number" value="<%# Item.Price %>" /></td>
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
                            <input name="name" placeholder="Rover" />
                        </td>
                        <td><input type="date" name="birthday" class="bday" placeholder="12/25/2014" /></td>
                        <td>
                            <select name="sex">
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                            </select>
                        </td>
                        <td><textarea name="description" rows="3" cols="40" placeholder="Write Description Here"></textarea></td>
                        <td><input name="color" placeholder="Standard Black and White" /></td>
                        <td>
                            <select name="forSale">
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.ForSale %>">ForSale</option>
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.NotForSale %>">NotForSale</option>
                                <option value="<%= CutterCreekRanch.Models.ForSaleStatusCode.Sold %>">Sold</option>
                            </select>
                        </td>
                        <td><input style="max-width:60px; text-align:right;" name="price" placeholder="500.00"  type="number" /></td>
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
