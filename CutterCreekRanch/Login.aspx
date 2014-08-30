<%@ Page MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CutterCreekRanch.Login" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        label{
            width:100px;
        }
        .wrapper{
            border:solid thin black;
            width:40%;
            padding:20px;
        }
        .wrapper button{
            margin-top:20px;
            text-align:center;
        }
        .wrapper button:first-child{
            margin-left:80px;
        }
        .details{
            
        }
    </style>
</asp:Content>
<asp:Content ContentPlaceHolderID="MainContent" runat="server">
    <form id="form1" runat="server">
        <div class="wrapper">
            <div>
                <div style="margin-bottom:10px;"><label>Username:</label><input name="user" /> </div>
                <div><label>Password:</label><input name="pass" type="password" /></div>
            </div>
            <div>
                <button name="action" value="login"  type="submit">Login</button>
                <button name="action" value="logout" type="submit">Logout</button>
            </div>
        </div>
    </form>
</asp:Content>