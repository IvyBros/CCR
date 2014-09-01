<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageOwners.aspx.cs" Inherits="CutterCreekRanch.Admin.ManageOwners" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        table {
            margin-top:20px;
        }
        label{
            font-weight:bold;
            margin:10px;
        }
        .address{
            width:300px;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="main" runat="server">
    <form runat="server" id="form1">
        <asp:ListView runat="server" ItemType="CutterCreekRanch.Models.Owner" DataKeyNames="OwnerId" SelectMethod="GetOwners"
            UpdateMethod="UpdateOwners" DeleteMethod="DeleteOwners" ClientIDMode="Static">
            <LayoutTemplate>
                <table id="ownersTable">
                    <thead>
                        <tr>
                            <th>Id</th>
                            <th>Name</th>
                            <th>Dog</th>
                            <th>Address</th>
                            <th>Date of Purchase</th>
                            <th>Cost</th>
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
                    <td><%# Item.OwnerId %></td>
                    <td><%# GetPersonName(Item.PersonId) %> </td>
                    <td><%# GetDogName(Item.DogId) %></td>
                    <td>
                        <%# Item.Address1 %><br />
                        <%# Item.Address2 == null ? String.Empty : Item.Address2 + "<br />" %>
                        <%# Item.City %><br />
                        <%# Item.State %><br />
                        <%# Item.Zip %>
                    </td>
                    <td><%# Item.DateOfPurchase.ToShortDateString() %></td>
                    <td><%# Item.Cost.ToString("c") %></td>
                    <td>
                        <asp:Button runat="server" CommandName="edit" Text="Edit" ID="edit" />
                        <asp:Button runat="server" CommandName="delete" Text="Delete" ID="delete" />
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td><%# Item.OwnerId %></td>
                    <td>
                        <select name="persons">
                            <% foreach(var person in personsById)
                               { %>
                                    <option value="<%= person.Key %>"><%= person.Value %></option>
                            <% } %>
                        </select>
                    </td>
                    <td>
                        <select name="dogs">
                            <% foreach(var dog in dogsById)
                               { %>
                                    <option value="<%= dog.Key %>"><%= dog.Value %></option>
                            <% } %>
                        </select>
                    </td>
                    <td>
                        <label class="address">Address 1:</label><input name="address1" value="<%# Item.Address1 %>" /><br />
                        <label class="address">Address 2:</label><input name="address2" value="<%# Item.Address2 %>" /><br />
                        <label class="address">City:</label><input name="city" value="<%# Item.City %>" /><br />
                        <label class="address">State:</label><input name="state" value="<%# Item.State %>" /><br />
                        <label class="address">Zip:</label><input name="zip" value="<%# Item.Zip %>" /><br />
                    </td>
                    <td><input name="dateOfPurchase" value="<%# Item.DateOfPurchase %>" type="date" /></td>
                    <td><input name="cost" value="<%# Item.Cost.ToString("c") %>" type="number" /></td>
                    <td>
                        <asp:Button runat="server" CommandName="update" Text="Update" />
                        <asp:Button runat="server" CommandName="cancel" Text="Cancel" />
                    </td>
                </tr>
            </EditItemTemplate>
        </asp:ListView>
    </form>
</asp:Content>