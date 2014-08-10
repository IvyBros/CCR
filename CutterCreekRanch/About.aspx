<%@ Page Title="About Us" MasterPageFile="~/Site.Master" Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="CutterCreekRanch.About" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style>
        .about-photo{
            width:150px;
            margin:15px 20px 20px 20px;
            float:left;
        }
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <h2>About Us</h2>
    
    <img src="img/about1.jpg" title="Cutter Creek Ranch" class="floatRight roundBorder" style="width:30%;" />
    <p>
        At Cutter Creek Ranch, every dog here is a family member and gets treated
        with love and respect.  Our dogs are happy and healthy and enjoy the fresh country air.  They get plenty
        of excericse every day chasing frisbees, squirrels and the occasional loose chicken.  Along with regular veterinary 
        checkups and closely monitored diets, a steady dose of genuine affection keeps our dogs looking and feeling great.
        All our puppies are vaccinated at age appropriate times and they stay with their mother until at least 10 weeks of age.
    </p>
    <p>
        The border collie is argubaly the most intelligent breed of dog on the planet.  Their appetite for learning
        is undeniable. These delightful dogs are instantly ready and willing to take on any task with eagerness 
        and a strong desire to please.  They are faithful, loyal companions, bred for obedience and discipline. They have
        an instinctive herding ability and a tireless work ethic.
    </p>    
    <div style="margin:auto;">
        <h4>Happy, healthy, well-adjusted canine companions</h4>
    </div>
    <div>
        <img src="img/photos/pic.jpg" class="roundBorder img-responsive about-photo" />
        <img src="img/photos/pic.jpg" class="roundBorder img-responsive about-photo" />
        <img src="img/photos/pic.jpg" class="roundBorder img-responsive about-photo" />
    </div>
    <p style="padding:20px 0 0 0;">
        The early developmental stages of a puppy's life can have a dramatic and lasting impact on their personality.
        Thats why we take great care to provide structure, kindness and affection to each and every puppy here at Cutter
        Creek Ranch.  You can rest assured that we've given them the best start possible in life.     
    </p>
    <hr />
    <img src="img/pic1.jpg" class="roundBorder img-responsive" style="margin:40px 40px 20px 40px; width:90%; height:250px;" />
</asp:Content>