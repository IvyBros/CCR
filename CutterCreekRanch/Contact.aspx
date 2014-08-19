<%@ Page Language="C#" Title="Contact Us" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="CutterCreekRanch.Contact" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style>
        .contact-panel{
            padding:30px;
        }
        table, th, td{
            border:solid thin #DDD;
            border-collapse:collapse;
        }
        table{
            border-radius:10px;
        }
        th, td{
            padding:30px;
        }
        td label{
            
        }
        td:last-child{
            max-width:300px;
        }
        td:first-child{
            white-space:nowrap;
        }
        li{
            padding:10px;
            margin-left:-10px;
        }
        li a{
            color:blue;
        }
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <form id="form1" runat="server">
        <h1>Contact Us</h1>
        <p style="padding-bottom:20px;">
            Thank you for your interest in Cutter Creek Ranch.  We look forward to hearing from you.  E-Mail is the best way
            to get in touch with us.  You can also call or text.  If you call and no one
            answers, leave a message and we will get back to you as soon as possible.  For news, pictures, border collie care tips and
            information on new litters, etc. follow us on social media.
        </p>
        <div style="float:right; margin:30px;" class="gly">
            <div style="border:solid thin black; width:350px; height:300px; margin-bottom:30px; overflow-x:hidden; overflow-y:hidden;">
                <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d860040.3309201467!2d-96.083771!3d32.64526989999998!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x864941eea77a3ce3%3A0x98e3e842900bc26d!2s5950+County+Road+128%2C+Wills+Point%2C+TX+75169!5e0!3m2!1sen!2sus!4v1407848396295" width="350" height="300" frameborder="0" style="overflow:hidden;" ></iframe>
            </div>
            <label>Nearby Hotels and Attractions:</label>
            <ul>
                <li><a href="1">Holiday Inn</a>, Terrel (15 miles)</li>
                <li><a href="1">Hotel Intercontenintal</a>, Dallas (50 miles)</li>
                <li><a href="1">Comfort Inn and Suites</a>, Terrel, (15 miles)</li>
                <li><a href="1">First Monday Trade Days</a>, Canton (20 miles)</li>
                <li><a href="1">Fort Worth Stock Yards</a>, (80 miles)</li>
            </ul>
            <label>Submit Application:</label>
            <br />
            <button class="btn btn-default" name="apply" style="color:blue; background-color:#ddd;margin:10px;" type="submit">Apply Online Now</button>
        </div>
        <div class="panel panel-default contact-panel">
            <table class="contact-table">
                <tr>
                    <td style="border-top-left-radius:4px"><label>Phone 1:</label></td>
                    <td style="border-top-right-radius:4px"> ( 555 )  555 - 5555</td>
                </tr>
                <tr>
                    <td><label>Phone 2:</label></td>
                    <td> ( 777 )  777 - 7777</td>
                </tr>
                <tr>
                    <td><label>Email:</label></td>
                    <td><a href="mailto:contact@ranch.cc">contact@ranch.cc</a></td>
                </tr>
                <tr>
                    <td><label>Facebook:</label></td>
                    <td><a href="http://facebook.com/ranch.cc">http://facebook.com/ranch.cc</a></td>
                </tr>
                <tr>
                    <td><label>Twitter:</label></td>
                    <td>#ranch.cc</td>
                </tr>
                <tr>
                    <td><label>Instagram</label></td>
                    <td>#ranch.cc</td>
                </tr>
                <tr>
                    <td  style="border-bottom-left-radius:4px"><label>Address:</label></td>
                    <td  style="border-bottom-right-radius:4px">
                        Cutter Creek Ranch<br>
                        5950 County Road 128<br />
                        Wills Point, TX 75169
                    </td>
                </tr>
            </table>
        </div>
    </form>
</asp:Content>