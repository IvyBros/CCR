<%@ Page Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageOwners.aspx.cs" Inherits="CutterCreekRanch.Admin.ManageOwners" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        table {
            margin-top:20px;
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
                        <%# Item.Address2 %><br />
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
            <%--<EditItemTemplate>
                <tr>
                    <td><%# Item.OwnerId %></td>
                </tr>
            </EditItemTemplate>--%>
        </asp:ListView>
    </form>
</asp:Content>
<asp:Content ContentPlaceHolderID="footer" runat="server">
    <script>

    </script>
</asp:Content>