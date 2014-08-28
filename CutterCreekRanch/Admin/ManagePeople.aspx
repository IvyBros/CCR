<%@ Page Language="C#" Title="Manage People" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManagePeople.aspx.cs" Inherits="CutterCreekRanch.Admin.ManagePeople" %>

<asp:Content ContentPlaceHolderID="main" runat="server">
    <form id="form1" runat="server">
        <h1><a href="ManageDogs.aspx">Manage Dogs</a> | <a href="ManagePhotos.aspx">Manage Photos</a> | Manage People</h1>

        <asp:ListView ItemType="CutterCreekRanch.Models.Person" DataKeyNames="PersonId" SelectMethod="GetPersons" 
            UpdateMethod="UpdatePerson" DeleteMethod="DeletePerson" InsertMethod="InsertPerson" 
            InsertItemPosition="LastItem" EnableViewState="false" runat="server" >
            <LayoutTemplate>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Actions</th>
                    </tr>        
                    <tr runat="server" id="itemPlaceHolder" />
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><%# Item.PersonId %></td>
                    <td><%# Item.Name %></td>
                    <td><%# Item.Email %></td>
                    <td><%# Item.Phone %></td>
                    <%--<td><%# Item.DogId %></td>
                    <td><%# Item.BirthYear == null ? "Unknown" : (DateTime.Now - Item.BirthYear).ToString() %></td>--%>
                    <td style="white-space:nowrap; text-align:center;">
                        <asp:Button CommandName="edit" Text="Edit" runat="server" />
                        <asp:Button CommandName="delete" Text="Delete" runat="server"/>
                    </td>
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
                    <td>+<input name="PersonId" type="hidden" value="0" /></td>
                    <td> <input name="Name" placeholder="John Doe" class="name" required="required" /></td>
                    <td> <input name="Email" placeholder="your@email.com" class="email" type="email" required="required" /></td>
                    <td> <input name="Phone" placeholder="(555) 555 - 5555" class="phone" type="number" /></td>
                    <td style="text-align:center;">
                        <asp:Button CommandName="Insert" Text="Add Person" runat="server" />
                    </td>
                </tr>
            </InsertItemTemplate>
        </asp:ListView>
    </form>    
</asp:Content>
