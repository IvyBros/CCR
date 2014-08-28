<%@ Page Language="C#" Title="Apply" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Apply.aspx.cs" Inherits="CutterCreekRanch.Apply" %>
<asp:Content runat="server" ContentPlaceHolderID="head">
    <style>
        .applicantContactInfo {
            padding:10px;
            list-style-type:none;
        }
        .applicantContactInfo li{
            padding:5px;
        }
        .applicantContactInfo label{
            padding-right:20px;
            text-align:right;
            width:80px;
        }
        #MainContent_applicantPhone{
            max-width:100px;
        }
        input[placeholder], textarea[placeholder]{
            color:#888;
        }
        #MainContent_applicantAge, #MainContent_numOfPeopleInHousehold{
            max-width:30px;
        }
        .applicantQuestions{
            list-style-type:none;
            padding:10px;
            vertical-align:text-top;
        }
        .applicantQuestions li{
            padding:5px;
        }
        .applicantQuestions label{
            margin-right:20px;
            width:300px;
        }
        .applicationButtons{
            margin-left:50px; 
            padding:10px;
            position:relative;
            top:-120px;
            left:440px;
        }
        .applicationButtons button{
            padding:10px;
            background-color:#CCC;
            margin-right:10px;
        }
        .validationMessage{
            display:none;
            color:red;
        }
    </style>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <form id="form1" runat="server">
        <h1>Apply</h1>
        <p>
            At Cutter Creek Ranch we love our pups and take the care and safety of our dogs seriously. Anyone interested in 
            purchasing one of our dogs must submit an application and receive approval.  Its free to apply. Supply is
            always limited so if you're interested, let us know.  Simply submitting an application does not constitute a 
            binding legal agreement of any type expressed or implied.  We respect your privacy and we will never sell or
            give your personal information to anyone else for any reason, ever.
        </p>
        <h4>Complete the form below for consideration</h4>
        <img src="~/img/submit.jpg" class="roundBorder floatRight img-responsive" style="height:150px; width:300px; margin-right:150px;" />
        <div>
            <ul class="applicantContactInfo">
                <li><label>Name: </label>   <input runat="server" name="name"  id="applicantName"  placeholder="John Doe" required="required" /></li>
                <li><label>E-Mail: </label> <input runat="server" name="email" id="applicantEmail" placeholder="johnny-D@gmail.com" type="email" required="required"/></li>
                <li><label>Phone: </label>  <input runat="server" name="phone" id="applicantPhone" placeholder="(555)555-5555" type="tel" /></li>
                <li><label>Age: </label>    <input runat="server" name="age"   id="applicantAge"   placeholder="35" type="number" /> </li>
            </ul>
            <ul class="applicantQuestions">
                <li>
                    <label>Please describe your previous pet ownership experience as well as other pets currently in your home if any:</label>
                    <textarea runat="server" id="petOwnershipExperience" rows="4" cols="60" placeholder="I've owned dogs all my life and currently have a female border collie as well as 2 cats."></textarea>
                </li>
                <li>
                    <label>Why do you want a dog from Cutter Creek Ranch?</label>
                    <textarea runat="server" id="whyDoYouWantDog" rows="2" cols="60" placeholder="I love border collies and I want a new best friend."></textarea>
                </li>
                <li>
                    <label>Are you interested in a particular dog?</label>
                    <select name="whichDog">
                        <option />
                        <asp:Repeater SelectMethod="GetForSaleDogs" runat="server" ItemType="CutterCreekRanch.Models.Dog">
                            <ItemTemplate>
                                <option <%# Item.DogId == id ? "selected=\"selected\"" : String.Empty %>><%# Item.Name %></option>
                            </ItemTemplate>
                        </asp:Repeater>
                    </select>                
                </li>
                <li>
                    <label>Do you own or rent your current residence?</label>
                    <select runat="server" name="ownOrRent" id="ownOrRent">
                        <option/>
                        <option>Rent</option>
                        <option>Own</option>
                        <option>Other</option>
                    </select>
                </li>
                <li>
                    <label>How many people including yourself live at your current residence? </label> 
                    <input runat="server" name="household" id="numOfPeopleInHousehold" placeholder="4" type="number" />
                </li>
                <li>
                    <label>Does your current residence have a yard?</label>
                    <input type="radio" name="yard" value="true" runat="server" />Yes
                    <input type="radio" name="yard" value="false" runat="server" />No
                </li>
            </ul>
            <div class="applicationButtons">
                <button type="submit" class="btn btn-default" name="apply">Submit</button>
            </div>
        </div>
        <div class="validationMessage" name="validationMessage" id="validationMessage" runat="server"/>
    </form>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="footerScripts">
    <!--empty-->
</asp:Content>