using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Net.Mail;
using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System.Web.UI.WebControls;

namespace CutterCreekRanch.Admin
{
    public partial class ManageTasks : System.Web.UI.Page
    {
        protected Repository repo = new Repository();
        protected Dictionary<int, string> emailsIndexedByPersonId = new Dictionary<int,string>();
        protected List<int> ownerIds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var action = Request.Form["action"];
                
                if(action == "email")
                {
                    if (MassEmail())
                        Response.Write("Mass Email Sent Successfully");
                    else
                        Response.Write("Error sending mass email.");
                }
                if (action == "socialMediaPost")
                {
                    if (SocialMediaPost())
                        Response.Write("Message Successfully posted to all services");
                    else
                        Response.Write("Error trying to post social media message");
                }
            }
        }

        protected bool MassEmail ()
        {
            var emailSender      = String.Format("{0}@ranch.cc", Request.Form["emailSender"]);
            var emailRecipients  = Request.Form["emailRecipients"];
            var emailSubject     = Request.Form["emailSubject"];
            var emailBody        = Request.Form["emailBody"];            

            if (String.IsNullOrEmpty(emailRecipients)
                || String.IsNullOrEmpty(emailSubject)
                || String.IsNullOrEmpty(emailBody))
                return false;

            var mail = new SmtpClient();
            var emailAddresses = new List<String>();

            foreach (var person in repo.Persons)                
                emailsIndexedByPersonId.Add(person.PersonId, person.Email);

            ownerIds = repo.Owners.Select(x => x.PersonId).ToList();

            switch(emailRecipients)
            {
                case "everyone":
                    emailAddresses = emailsIndexedByPersonId.Values.ToList();                    
                    break;
                case "owners":
                    foreach(var id in ownerIds)                    
                        if (emailsIndexedByPersonId.ContainsKey(id))
                            emailAddresses.Add(emailsIndexedByPersonId[id]);                    
                    break;
                case "people":
                    foreach(var personId in emailsIndexedByPersonId)
                        if(!ownerIds.Contains(personId.Key))
                            emailAddresses.Add(personId.Value);
                    break;
            }

            foreach (var email in emailAddresses)
            {//create msg and add any attachments
                var msg = new MailMessage(from: emailSender, to: email, subject: emailSubject, body: emailBody);
                if (emailAttachments.HasFiles)
                    foreach (var item in emailAttachments.PostedFiles)
                        msg.Attachments.Add(new Attachment(item.FileName));
                try
                {//attempt to deliver mail message
                    DebugPrintMailMsg(msg);
                    //mail.Send(msg);
                }
                catch
                {//TODO:Add additional error handling here
                    return false;
                }
            }            
            return true;
        }

        protected void DebugPrintMailMsg(MailMessage msg)
        {
            Response.Write("<pre>");
            Response.Write(msg);
            Response.Write(Environment.NewLine);
            Response.Write("To:" + msg.To);
            Response.Write(Environment.NewLine);
            Response.Write("From:" + msg.From);
            Response.Write(Environment.NewLine);
            Response.Write("Subject:" + msg.Subject);
            Response.Write(Environment.NewLine);
            Response.Write("Body:" + msg.Body);
            Response.Write("</pre>");
        }

        protected bool SocialMediaPost()
        {            
            var msg = Request.Form["socialMediaMsg"];
            var splitMe = Request.Form["socialMedia"];

            if (String.IsNullOrEmpty(msg) || String.IsNullOrEmpty(splitMe))
                return false;

            String filename;
            var services = splitMe.Split(',');
            
            if (socialMediaPicture.HasFile)
                filename = socialMediaPicture.FileName;

            foreach(var item in services)
            {//login to each service                
                var token = GetAuthToken(item);
                if (MakePost(item, token) == false)
                    return false;
            }
            return true;
        }

        protected object GetAuthToken(string serviceName)
        {//login using user credentials, gain permissions if necessary, get an authentication token for use in making posts
            Response.Write(String.Format("Getting Authentication token for {0}...", serviceName));
            return true;
        }

        protected bool MakePost(string serviceName, object token)
        {//post to service using authentication token
            switch (serviceName)
            { 
                case "facebook":
                    Response.Write("processing facebook...<br>");
                    break;
                case "twitter":
                    Response.Write("processing twitter...<br>");
                    break;
                case "googlePlus" :
                    Response.Write("processing googlePlus...<br>");
                    break;
                case "instagram":
                    Response.Write("processing instagram...<br>");
                    break;
                case "flickr":
                    Response.Write("processing flickr...<br>");
                    break;
                case "blogSpot":
                    Response.Write("processing blogSpot...<br>");
                    break;
                case "tapiture":
                    Response.Write("processing tapiture...<br>");
                    break;
            }
            return true;
        }
    }
}