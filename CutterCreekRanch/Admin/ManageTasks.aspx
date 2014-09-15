<%@ Page Title="Tasks" MasterPageFile="~/Admin/Admin.Master" Language="C#" AutoEventWireup="true" CodeBehind="ManageTasks.aspx.cs" Inherits="CutterCreekRanch.Admin.ManageTasks" %>

<asp:Content ContentPlaceHolderID="main" runat="server">
    <form id="form1" runat="server">
        <h1>Tasks</h1>
        <hr />
        <div class="groupEmail">
            <h2>Create a Mass E-Mail:</h2>
            <label>From:</label>
            <select name="emailSender">
                <option value="admin">admin@ranch.cc</option>
                <option value="newsletter">newsletter@ranch.cc</option>
                <option value="special">special-offer@ranch.cc</option>
                <option value="dennis">dennis@ranch.cc</option>
                <option value="contact">contact@ranch.cc</option>
            </select>
            <br />
            <label>To:</label>
            <select name="emailRecipients">
                <option value="">Select Recipients...</option>
                <option value="everyone">Everyone</option>
                <option value="owners">Only Owners</option>
                <option value="people">Exclude Owners</option>
            </select>
            <br />
            <label>Subject:</label>
            <input name="emailSubject" placeholder="Cutter Creek Ranch Newsletter" style="width:390px;" />
            <br />
            <label>Body:</label><br />
            <textarea name="emailBody" placeholder="Type or paste email message here." style="width:500px;" rows="20"></textarea>
            <br />
            <label>Attachments:</label>
            <asp:FileUpload ID="emailAttachments" AllowMultiple="true" runat="server" />
            <button type="submit" name="action" value="email">Send</button>
            <button type="reset">Cancel</button>
        </div>
        <hr />
        <div class="socialMedia">
            <h2>Create a social media post:</h2>
            <h3>Choose which services you want to use:</h3>
            <input type="checkbox" checked="checked" name="socialMedia" value="facebook" />  <label>Facebook</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="twitter" />   <label>Twitter</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="instagram"/>  <label>Instagram</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="flickr" />    <label>Flickr</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="googlePlus"/> <label>Google+</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="blogSpot" />  <label>BlogSpot</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="tapiture" />  <label>Tapiture</label><br />
            <h3>Choose a photo:</h3>
            <asp:FileUpload ID="socialMediaPicture" runat="server" />
            <h3>Type a short message:</h3>
            <textarea style="width:500px;" rows="3" placeholder="Type your message here" name="socialMediaMsg"></textarea><br />
            <button name="action" value="socialMediaPost" type="submit">Post</button>
            <button type="reset">Cancel</button>
        </div>
    </form>
</asp:Content>