<%@ Page Language="C#" Title="Manage Photos" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" EnableViewState="false" CodeBehind="ManagePhotos.aspx.cs" Inherits="CutterCreekRanch.Admin.ManagePhotos" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        #inner-table table{
            border:none;
        }
        .centerTxt{
            text-align:center;
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="main" runat="server">
    <form id="form1" runat="server" method="post" enctype="multipart/form-data">
        <h3>Add Photo:</h3>
        <!--TODO: add a slider feature that will allow slipping to extra dogs if the number of dogs exceeds one row in length-->
        <table>
            <tr>
                <td>
                    <label>Select Dog:</label>
                    <select name="uploadDogId">
                        <option></option>
                        <%foreach (var item in DogNamesAndIds)
                          { %>
                            <option value="<%= item.Key %>"><%= item.Value %></option>
                        <%} %>
                    </select>
                </td>
                <td>
                    <label>Choose File(s):</label>
                    <asp:FileUpload ID="file1" runat="server" AllowMultiple="true" />
                    <br />
                    <br />
                    <label>Add Caption(s):</label>
                    <input style="width:220px;" name="uploadCaption" placeholder="caption 1; caption 2; caption 3;..." id="caption" title="When uploading multiple files, you can add the same caption to each picture by simply supplying one caption, however if you wish to supply a unique caption for each one, simply seperate each caption  by adding a semicolon(;) at the end of each.  Take care to place captions in the proper order as corresponds to the picture upload order.  If you don't get them right you can always edit them later." />
                </td>
                <td>
                    <asp:Button ID="UploadButton" runat="server" Text="Upload" OnClick="UploadButton_Click" />
                </td>
            </tr>
        </table>
        <br />
        <asp:ListView ItemType="CutterCreekRanch.Models.Photo" DataKeyNames="Id" SelectMethod="GetPhotos" 
                UpdateMethod="UpdatePhoto" DeleteMethod="DeletePhoto" EnableViewState="false" runat="server" ClientIDMode="Static">
            <LayoutTemplate>
                <table id="photosTable">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Id</th>
                            <th>Dog</th>
                            <th>URL</th>
                            <th>Caption</th>
                            <td>Original</td>
                            <td>Carousel</td>
                            <td>Thumbnail</td>
                            <td>Profile Pic</td>
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
                    <td><img src="/img/photos/<%# Item.ThumbURL %>" class="imageThumb" /></td>
                    <td><%# Item.Id %></td>
                    <td><%# DogNamesAndIds.Keys.Contains(Item.DogId) ? DogNamesAndIds[Item.DogId] ?? "None" : "None" %></td>
                    <td><%# Item.URL %></td>
                    <td><%# Item.Caption %></td>
                    <td class="centerTxt"><a href="/img/photos/<%# Item.URL %>"><%# GetFileSize(Item.URL) %></a></td>
                    <td class="centerTxt"><a href="/img/photos/<%# Item.CarouselURL %>"><%# GetFileSize(Item.CarouselURL) %></a></td>
                    <td class="centerTxt"><a href="/img/photos/<%# Item.ThumbURL %>"><%# GetFileSize(Item.ThumbURL) %></a></td>
                    <td><%# 
                        !String.IsNullOrEmpty(Item.ProfileURL) 
                        ? String.Format("<a href=\"/img/photos/{0}\">{1}</a>",Item.ProfileURL, GetFileSize(Item.ProfileURL)) 
                        : String.Format("<a href=\"Crop/{0}\">Create</a>", Item.Id) %>
                    </td>
                    <td>
                        <asp:Button CommandName="edit" Text="Edit" runat="server" ID="edit"/>
                        <asp:Button CommandName="delete" Text="Delete" runat="server" ID="delete"/>
                    </td>
                </tr>
            </ItemTemplate>
            <EditItemTemplate>
                <tr>
                    <td><a href="/img/photos/<%# Item.URL %>"><img src="/img/photos/<%# Item.ThumbURL %>" class="imageThumb" /></a></td>
                    <td><%# Item.Id %></td>
                    <td><input type="hidden" name="id" value="<%#Item.Id %>" />
                        <select name="DogId">
                            <%foreach (var dog in DogNamesAndIds) 
                              {//build the dropdown,%>
                            <%# currentDogId = Item.DogId %>
                                <option <%
                                    if (currentDogId == dog.Key) 
                                        Response.Write("selected=\"selected\""); 
                                    %> value="<%=dog.Key %>"><%=dog.Value %></option>
                            <%} %>
                        </select>
                    </td>
                    <td><input name="URL"     value="<%# Item.URL %>" title="Change at your own risk!" /></td>
                    <td><input name="caption" value="<%# Item.Caption %>" /></td>
                    <td style="text-align:center"><a href="/img/photos/<%# Item.URL %>"><%# GetFileSize(Item.URL) %></a>/
                        <a href="/img/photos/<%# Item.CarouselURL %>"><%# GetFileSize(Item.CarouselURL) %></a> /
                        <a href="/img/photos/<%# Item.ThumbURL %>"><%# GetFileSize(Item.ThumbURL) %></a>
                    </td>
                    </td>
                    <td><%# IsProfilePic(Item.Id, Item.DogId) ? "Yes" : "No" %></td>
                    <td>
                        <asp:Button ID="update" CommandName="update" Text="Update" runat="server" /> 
                        <asp:Button ID="cancel" CommandName="cancel" Text="Cancel" runat="server" />
                    </td>
                </tr>
            </EditItemTemplate>
        </asp:ListView>
    </form>
</asp:Content>
<asp:Content ContentPlaceHolderID="footer" runat="server">
    <script>
        $(document).ready(function () {
            $('#photosTable').DataTable();
        });
    </script>
</asp:Content>