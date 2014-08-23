<%@ Page Language="C#" AutoEventWireup="true" EnableViewState="false" CodeBehind="ManagePhotos.aspx.cs" Inherits="CutterCreekRanch.Admin.ManagePhotos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Photos</title>
    <style>
        table, td, th{
            border:solid thin black; 
            border-collapse:collapse;
        }
        td, th{
            padding:10px;
        }
        .imageThumb{
            max-height:75px;
            max-width:75px;
        }
        .addPhoto{
            padding:20px;
            border:solid thin black;
        }
        .addPhoto label{
            font-weight:bold;
            margin-left:20px;
        }
        .addPhoto label:first-child{
            margin-left:0;
        }
        .addPhoto button{
            margin-left:20px;
        }
        table tr td label{
            font-weight:bold;
            padding:10px;
        }
    </style>
</head>
<body>
    <h1><a href="ManageDogs.aspx">Manage Dogs</a> | Manage Photos | <a href="ManagePeople.aspx">Manage People</a></h1>
    <form id="form1" runat="server" method="post" enctype="multipart/form-data">
        <h3>Add Photo:</h3>
        <table>
            <tr>
                <td>
                    <label>Select Dog:</label>
                    <select name="uploadDogId">
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
                UpdateMethod="UpdatePhoto" DeleteMethod="DeletePhoto" EnableViewState="false" runat="server">
            <LayoutTemplate>
                <table>
                    <tr>
                        <th>Image</th>
                        <th>Id</th>
                        <th>Dog</th>
                        <th>URL</th>
                        <th>Caption</th>
                        <th>
                            File Size<br />
                            <span style="font-weight:normal">Full/Carousel/Thumb</span>
                        </th>
                        <th>Profile Pic?</th>
                        <th colspan="2">Actions</th>
                    </tr>
                    <tr runat="server" id="itemPlaceHolder" />
                </table>
            </LayoutTemplate>
            <ItemTemplate>
                <tr>
                    <td><img src="/img/photos/<%# Item.ThumbURL %>" class="imageThumb" /></td>
                    <td><%# Item.Id %></td>
                    <td><%# DogNamesAndIds.Keys.Contains(Item.DogId) ? DogNamesAndIds[Item.DogId] ?? "None" : "None" %></td>
                    <td><%# Item.URL %></td>
                    <td><%# Item.Caption %></td>
                    <td style="text-align:center"><a href="/img/photos/<%# Item.URL %>"><%# GetFileSize(Item.URL) %></a>/
                        <a href="/img/photos/<%# Item.CarouselURL %>"><%# GetFileSize(Item.CarouselURL) %></a> /
                        <a href="/img/photos/<%# Item.ThumbURL %>"><%# GetFileSize(Item.ThumbURL) %></a>
                    </td>
                    <td><%# IsProfilePic(Item.Id, Item.DogId) ? "Yes" : "No" %></td>
                    <td><asp:Button CommandName="edit" Text="Edit" runat="server" ID="edit"/></td>
                    <td><asp:Button CommandName="delete" Text="Delete" runat="server" ID="delete"/></td>                    
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
                    </td>
                    <td>
                        <asp:Button ID="cancel" CommandName="cancel" Text="Cancel" runat="server" />
                    </td>
                </tr>
            </EditItemTemplate>
        </asp:ListView>
    
    </form>
</body>
</html>
