<%@ Page Language="C#" Title="Home" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Home.aspx.cs" Inherits="CutterCreekRanch.Home" %>

<asp:content ContentPlaceHolderID="MainContent" runat="server">
    <!--carousel-->
    <div id="carousel-photography" class="carousel slide" data-ride="carousel" >
        <ol class="carousel-indicators">
            <li data-target="#carousel-photography" data-slide-to="0" class="active"></li>
            <li data-target="#carousel-photography" data-slide-to="1"></li>
            <li data-target="#carousel-photography" data-slide-to="2"></li>
            <li data-target="#carousel-photography" data-slide-to="3"></li>
            <li data-target="#carousel-photography" data-slide-to="4"></li>
            <li data-target="#carousel-photography" data-slide-to="5"></li>
            <li data-target="#carousel-photography" data-slide-to="6"></li>
            <li data-target="#carousel-photography" data-slide-to="7"></li>
            <li data-target="#carousel-photography" data-slide-to="8"></li>
            <li data-target="#carousel-photography" data-slide-to="9"></li>
        </ol>
        <div class="carousel-inner">
            <div class="item active">
                <img src="img/c1.jpg" class="img-responsive caroselPics" title="Puppies!" alt="Puppies!" />
            </div>
            <div class="item">
                <img src="img/c2.jpg" class="img-responsive caroselPics" title="Happy Dogs" alt="Happy Dogs" />
            </div>
            <div class="item">
                <img src="img/c3.jpg" class="img-responsive caroselPics" title="Cuteness" alt="Cuteness" />
            </div>
            <div class="item">
                <img src="img/c4.jpg" class="img-responsive caroselPics" title="Border Collie <3" alt="Border Collie <3" />
            </div>
            <div class="item">
                <img src="img/c5.jpg" class="img-responsive caroselPics" title="" alt="" />
            </div>
            <div class="item">
                <img src="img/c6.jpg" class="img-responsive caroselPics" title="" alt="" />
            </div>
            <div class="item">
                <img src="img/c7.jpg" class="img-responsive caroselPics" title="" alt="" />
            </div>
            <div class="item">
                <img src="img/c8.jpg" class="img-responsive caroselPics" title="" alt="" />
            </div>
            <div class="item">
                <img src="img/c9.jpg" class="img-responsive caroselPics" title="" alt="" />
            </div>
            <div class="item">
                <img src="img/c10.jpg" class="img-responsive caroselPics" title="" alt="" />
            </div>
        </div>
        <a class="left carousel-control" href="#carousel-photography" data-slide="prev">
            <span class="glyphicon glyphicon-chevron-left"></span>
        </a>
        <a class="right carousel-control" href="#carousel-photography" data-slide="next">
            <span class="glyphicon glyphicon-chevron-right"></span>
        </a>
    </div>
    <!--//end carousel-->    
    <h1>Experience Tradition</h1>
    <p>
        Cutter Creek is a family owned and operated working farm in the black-prairie lands of east Texas.  
        Down here we take pleasure in focusing on the simple things in life.  We grow our own organic produce, raise 
        farm fresh eggs, and preserve our heritage.  We also share our lives with our beloved border collies.
        Our canine companions work right along side us whether we're tending the garden or feeding the livestock.
    </p>
    <p>
        If you're looking to purchase one of our prize winning pups or if you're just a fan of the breed,
        feel free to browse our website, join our mailing list or follow us on facebook, twitter, and instagram.
        We love sharing pictures and videos of border collies and its a great way to hear about upcoming offerings.        
        
    </p>
    <h2 style="margin-top:30px;">Learn More</h2>
    <img src="img/merlin-frisbee.jpg" class="main-menu-pics roundBorder" title="Champion Dogs" />
    <img src="img/sadie1.jpg" class="main-menu-pics roundBorder" title="Ancient Bloodlines" />
    <img src="img/bella-merlin-frisbee.jpg" class="main-menu-pics roundBorder" title="Knowledgable Breeders"/>
    <nav id="main-menu" style="margin-top:10px;">
        <ul>
            <li><a href="About">About</a></li>
            <li><a href="Offerings">Offers</a></li>
            <li><a href="Photos">Photos</a></li>
            <li><a href="Contact">Contact</a></li>
        </ul>
    </nav>
    <p style="margin-top:40px;">
        Thank you for your interest in our website.  At Cutter Creek, we are passionate about border collies and we look 
        forward to sharing that passion with you.  Whether you're looking for a new best friend or just have a question about
        puppy care, we are happy to help, so please don't hesitate to contact us. We wish you and your herd all the joy 
        and happiness that a lifetime filled with canine companionship can bring.
    </p>
</asp:content>
