<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavLinks.ascx.cs" Inherits="CutterCreekRanch.controls.NavLinks" %>

<nav class="raised" role="navigation" id="navigation">
    <ul>
        <li <%= GetActiveClass("Contact") %>><a href="/Contact">Contact</a></li>
        <li <%= GetActiveClass("Photos") %>><a href="/Photos">Photos</a></li>
        <li <%= GetActiveClass("Offerings") %>><a href="/Offerings">Offers</a></li>
        <li <%= GetActiveClass("About") %>><a href="/About">About</a></li>
        <li <%= GetHomeClass() %>><a href="/">Home</a></li>
    </ul>
</nav>