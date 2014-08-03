<%@ Page Title="Offerings" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="Offerings.aspx.cs" Inherits="CutterCreekRanch.Services" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style>
        .dog{
            padding:2px;
        }
        .profilePic{
            width:250px;
            height:250px;
            border:solid thin black;
            box-shadow:5px 5px 5px #000;
            border-radius:5px;
            margin:20px;
            float:left;
        }
        .profileInfo{
            position:relative;
            top:20px;
        }
        .profileInfo ul{
            list-style-type:none;
        }
        .profileInfo ul label{
            width:100px;
            text-align:right;
            padding-right:10px;
        }
        .morePhotos{
            margin-right:20px;
            border-radius:5px;
            box-shadow:5px 5px 5px #000;
            float:right;
            width:75px;
            border:solid thin black;
        }
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    K so the plan is to build an "admin" section of the site.  The content of this page will be dynamically generated
    from input managed and created by the admin. (i'm thinking dad)  I'd like to see a list of pups for sale here
    with as much information about them as we can capture, for instance, date of birth, coloring/classification, sex,
    parents, profile picture, additional picture(s), a short description of their personality, etc. See an example below:
    <hr />
    <h1>Future Best Friends</h1>
    <CCR:DogListing runat="server" />
</asp:Content>
