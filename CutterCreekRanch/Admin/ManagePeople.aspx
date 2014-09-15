<%@ Page Language="C#" Title="Manage People" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManagePeople.aspx.cs" Inherits="CutterCreekRanch.Admin.ManagePeople" %>

<asp:Content ContentPlaceHolderID="main" runat="server">
    <form id="form1" runat="server">
        <asp:ListView ItemType="CutterCreekRanch.Models.Person" DataKeyNames="PersonId" SelectMethod="GetPersons" 
            UpdateMethod="UpdatePerson" DeleteMethod="DeletePerson" InsertMethod="InsertPerson" 
            InsertItemPosition="LastItem" EnableViewState="false" runat="server" ClientIDMode="Static">
            <LayoutTemplate>
                <table id="personsTable">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Actions</th>
                            <th>Additional</th>
                        </tr>        
                    </thead>
                    <tbody>
                        <tr runat="server" id="itemPlaceHolder" />
                    </tbody>
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Item.PersonId %></td>
                    <td><%# Item.Name %></td>
                    <td><a href="mailto:<%#Item.Email %>"><%# Item.Email %></a></td>
                    <td><%# Item.Phone %></td>
                    <td style="white-space:nowrap; text-align:center;">
                        <asp:Button CommandName="edit" Text="Edit" runat="server" />
                        <asp:Button CommandName="delete" Text="Delete" runat="server"/>
                    </td>
                    <td><a href="ViewPersonDetails.aspx?PersonId=<%#Item.PersonId %>">View Details</a></td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td><%# Item.PersonId %><input name="PersonId" type="hidden" value="<%# Item.PersonId %>" /></td>
                    <td><input name="Name" value="<%# Item.Name %>" class="name" /></td>
                    <td><input name="Email" value="<%# Item.Email %>" class="email" /></td>
                    <td><input name="Phone" value="<%# Item.Phone %>" class="phone" /></td>
                    <td style="white-space:nowrap;">
                        <asp:Button CommandName="update" Text="Update" runat="server" />
                        <asp:Button CommandName="cancel" Text="Cancel" runat="server" />
                    </td>
                </tr>
            </EditItemTemplate>
            <InsertItemTemplate>
                <tr>
                    <td>0</td>
                    <td>
                        <input name="PersonId" type="hidden" value="0" /> 
                        <input name="Name" placeholder="John Doe" class="name" />
                    </td>
                    <td> <input name="Email" placeholder="your@email.com" class="email" type="email" /></td>
                    <td> <input name="Phone" placeholder="(555) 555 - 5555" class="phone" type="number" /></td>
                    <td style="text-align:center;">
                        <asp:Button CommandName="Insert" Text="Add Person" runat="server" />
                    </td>
                    <td></td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
    </form>    
</asp:Content>
<asp:Content ContentPlaceHolderID="footer" runat="server">
    <script>
        //$(document).ready(function () {
        //    $('#personsTable').DataTable();            
        //});
    </script>
</asp:Content>
