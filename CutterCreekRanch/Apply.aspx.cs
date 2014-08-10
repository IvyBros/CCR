using System;
using System.Linq;
using System.Collections.Generic;
using System.Net.Mail;
using CutterCreekRanch.Models.Repository;
using CutterCreekRanch.Models;
using System.Text;

namespace CutterCreekRanch
{
    public partial class Apply : System.Web.UI.Page
    {
        protected string adminEmail = "contact@ranch.cc";
        protected string applicantEmail;
        protected SmtpClient mail = new SmtpClient();
        private Repository repo = new Repository();
        protected bool debug = true;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack && Request.Form["apply"] != null)
            {//client side validation should insure i have a name and an email address
                applicantEmail = Request.Form[Request.Form.AllKeys.First(x => x.EndsWith("applicantEmail"))];
                if (EmailApplicant())
                {//if we were able to deliver email to the applicant
                    AddPersonToDB();
                    EmailAdmin();
                }
                else
                {//alert user of failure and instruct to try again.
                    this.validationMessage.InnerText = string.Format( "We were unable to deliver to the e-mail address you provided. ({0}) Please try again", Request.Form["email"]);
                    validationMessage.Style.Add("display", "normal");
                }
            }
        }

        private bool EmailApplicant()
        {
            var msg = new MailMessage(from:adminEmail, to:applicantEmail);
            var body = new StringBuilder();
            var dogName = Request.Form[Request.Form.AllKeys.FirstOrDefault(x=>x.EndsWith("whichDog"))] ?? String.Empty;
            msg.Subject = "Your application with Cutter Creek Ranch";
            body.AppendLine(String.Format("Hello {0},", 
                Request.Form[Request.Form.AllKeys.FirstOrDefault(x=>x.EndsWith("applicantName"))] ?? String.Empty));
            body.AppendLine();
            body.AppendLine(String.Format("Thank you for your interest in {0}.  We will review your application shortly and get back to you soon.  Usually we reply within 24 hours.  Your patience is appreciated.  We look forward to speaking with you further regarding this opportunity.", 
                String.IsNullOrEmpty(dogName) ? "Cutter Creek" : dogName));
            body.AppendLine();
            body.AppendLine("Kind Regards,");
            body.AppendLine();
            body.Append("The Cutter Creek Ranch Team");
            msg.Body = body.ToString();

            try
            {
                //mail.Send(msg);
                if (debug == true)
                {//for debugging
                    WriteMailToConsole(msg);
                }
            }

            catch(SmtpFailedRecipientsException)
            {
                return false;
            }
                
            catch(SmtpFailedRecipientException)
            {
                return false;
            }

            catch
            {//TODO:add item to log
                //var log = File.AppendText("~/logs/log.xml");
                ////create xml and event
                ////var logDoc = new XDocument();
                //var logEvent = new XElement("Event");
                ////create and add attributes to event
                //var evtDate = new XAttribute("Date", DateTime.Now);
                //var evtType = new XAttribute("Type", "Mail Sending Error");
                //logEvent.Add(evtDate);
                //logEvent.Add(evtType);
                ////add child nodes to event
                //var detail = new XElement("Detail");
                //var recipient = new XElement("Recipient");
                //var email = new XElement("EMailAddress", Request.Form["email"] ?? String.Empty);
                //var name = new XElement("Name", Request.Form["name"] ?? String.Empty);
                //recipient.Add(email);
                //recipient.Add(name);
                //detail.Add(recipient);
                //var ex = new XElement("Exception");
                //logDoc.Add(logEvent);
                
                throw;
            }

            return true;
        }

        private void EmailAdmin()
        {
            var msg = new MailMessage(from:adminEmail, to:adminEmail);
            var body = new System.Text.StringBuilder();
            msg.Subject = String.Format("New Applicant - {0}", Request.Form[Request.Form.AllKeys.First(x=> x.EndsWith("applicantName"))] ?? String.Empty);
            body.AppendLine("Someone submitted an application online.  Please see the details below.");
            foreach(var item in Request.Form)
            {
                string key = (string)item;
                if(!key.StartsWith("__") && !key.EndsWith("apply"))
                {//filter out viewstate
                    var split = key.Split('$');
                    body.Append(split[split.Length - 1]);
                    body.Append(" = ");
                    body.Append((string)Request.Form[key]);
                    body.Append(Environment.NewLine);
                }
            }
            msg.Body = body.ToString();
            try
            {
                //mail.Send(msg);
                if(debug == true)
                    WriteMailToConsole(msg);
            }
            catch
            {//log failure
                
            }
        }

        private void WriteMailToConsole(MailMessage msg)
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

        protected void AddPersonToDB()
        {
            //add this person our mailing list
        }
        public IEnumerable<string> GetForSaleDogNames()
        {
            return repo.Dogs.Where(x => x.ForSale != ForSaleStatusCode.Sold && x.ForSale != ForSaleStatusCode.NotForSale).Select(x => x.Name);
        }
    }
}