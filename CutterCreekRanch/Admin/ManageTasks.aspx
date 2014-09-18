<%@ Page Title="Tasks" MasterPageFile="~/Admin/Admin.Master" Language="C#" AutoEventWireup="true" CodeBehind="ManageTasks.aspx.cs" Inherits="CutterCreekRanch.Admin.ManageTasks" %>

<asp:Content ContentPlaceHolderID="main" runat="server">
    <form id="form1" runat="server">
        <h1>Tasks</h1>
        <hr />
        <div class="groupEmail">
            <h2>Create a Mass E-Mail:</h2>
            <label>From:</label>
            <select name="emailSender" id="from">
                <option value="admin">admin@ranch.cc</option>
                <option value="newsletter">newsletter@ranch.cc</option>
                <option value="special">special-offer@ranch.cc</option>
                <option value="dennis">dennis@ranch.cc</option>
                <option value="contact">contact@ranch.cc</option>
            </select>
            <br />
            <label>To:</label>
            <select name="emailRecipients" id="to">
                <option value="">Select Recipients...</option>
                <option value="everyone">Everyone</option>
                <option value="owners">Only Owners</option>
                <option value="people">Exclude Owners</option>
            </select>
            <br />
            <label>Subject:</label>
            <input name="emailSubject" placeholder="Cutter Creek Ranch Newsletter" style="width:390px;" id="sub" />
            <br />
            <label>Body:</label><br />
            <textarea name="emailBody" placeholder="Type or paste email message here." style="width:500px;" rows="20" id="bdy">
            </textarea>
            <br />
            <label>Attachments:</label>
            <asp:FileUpload ID="emailAttachments" AllowMultiple="true" runat="server" />
            <button type="submit" name="action" value="email" id="sendBtn">Send</button>
            <button type="reset">Cancel</button>
        </div>
        <hr />
        <div class="socialMedia">
            <h2>Create a social media post:</h2>
            <h3>Choose which services you want to use:</h3>
            <input type="checkbox" checked="checked" name="socialMedia" value="facebook" id="srv1" />  <label>Facebook</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="twitter" id="srv2" />   <label>Twitter</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="instagram" id="srv3"/>  <label>Instagram</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="flickr" id="srv4" />    <label>Flickr</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="googlePlus" id="srv5"/> <label>Google+</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="blogSpot" id="srv6" />  <label>BlogSpot</label><br />
            <input type="checkbox" checked="checked" name="socialMedia" value="tapiture" id="srv7" />  <label>Tapiture</label><br />
            <h3>Choose a photo:</h3>
            <asp:FileUpload ID="socialMediaPicture" runat="server" />
            <h3>Type a short message:</h3>
            <textarea style="width:500px;" rows="3" placeholder="Type your message here" name="socialMediaMsg" id="msg"></textarea><br />
            <button name="action" value="socialMediaPost" type="submit" id="postBtn">Post</button>
            <button type="reset">Cancel</button>
        </div>
    </form>
</asp:Content>
<asp:Content ContentPlaceHolderID="footer" runat="server">
    <script>
        $(document).ready(function () {
            
            function Validate($selector) {
                if ($selector.val() == '') {
                    $selector.css('border', 'solid thin red');
                    $selector.focus(function () {
                        $selector.css('border', 'solid thin black');
                    });
                }
            }

            $('#sendBtn').click(function (evt) {

                var $to   = $('#to');                
                var $sub  = $('#sub');
                var $bdy  = $('#bdy');                

                if ($to.val() == '' || $sub.val() == '' || $bdy.val() == '')
                    evt.preventDefault();

                else if (evt.isDefaultPrevented())
                    $('#form1').submit();
                
                Validate($to);
                Validate($sub);
                Validate($bdy);
            });

            $('#postBtn').click(function (evt) {

                var $msg = $('#msg');
                var checked = 0;

                for (var i = 1; i <= 7; i++) 
                    if (document.getElementById('srv' + i).checked)
                        checked++;                

                if ($msg.val() == '' || checked === 0)
                    evt.preventDefault();

                else if (evt.isDefaultPrevented())
                    $('#form1').submit();

                Validate($msg);
            });
        });
    </script>
</asp:Content>