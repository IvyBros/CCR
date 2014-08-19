<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DogNav.ascx.cs" Inherits="CutterCreekRanch.controls.DogNav" %>
<span id="dogNav">
    <% if(prevDogId > 0) 
       { %>
            <span class="prev"><a href="/Dogs/<%: prevDogId %>"><span class="glyphicon glyphicon-chevron-left"></span> Prev </a></span>
    <% } %>
    <span class="view-all"><a href="/Dogs">View All</a></span><% 
       if(nextDogId > 0) { %><span class="next">
        <a href="/Dogs/<%: nextDogId %>">Next <span class="glyphicon glyphicon-chevron-right"></span></a></span>
    <% } %>
</span>