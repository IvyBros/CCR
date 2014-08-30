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
        protected string applicantEmail, _applicantName;
        protected bool debug = true;
        protected int id, dogId;
        protected SmtpClient mail = new SmtpClient();
        private Repository repo = new Repository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack && Request.Form["apply"] != null)
            {//client side validation should insure i have a name and an email address
                //read form values
                applicantEmail = GetFormValue("applicantEmail");
                if (String.IsNullOrEmpty(applicantEmail)) throw new Exception("How'd you manage that then?");
                _applicantName = GetFormValue("applicantName");
                dogId = String.IsNullOrEmpty(GetFormValue("whichDog")) ? 0 : int.Parse(GetFormValue("whichDog"));
                if (EmailApplicant())
                {//if we were able to deliver email to the applicant
                    AddPersonToDB();
                    EmailAdmin();
                }
                else
                {//alert user of failure and instruct to try again.
                    this.validationMessage.InnerText = 
                        string.Format( "We were unable to deliver to the e-mail address you provided: ({0}) Please try again", 
                        applicantEmail);
                    validationMessage.Style.Add("display", "normal");
                }
            }
            if (RouteData.Values["id"] != null)            
                id = int.Parse(RouteData.Values["id"].ToString());
        }

        private bool EmailApplicant()
        {
            var msg = new MailMessage(from:adminEmail, to:applicantEmail);
            var body = new StringBuilder();            
            var dogName = dogId != 0 ? repo.GetDogByID(dogId).Name : null;

            msg.Subject = "Your application with Cutter Creek Ranch";
            body.AppendLine(String.Format("Hello {0},", 
                _applicantName ?? String.Empty));
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
                if (debug == true)
                    WriteMailToConsole(msg);
                else mail.Send(msg);
                
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

                #region XML log (future feature)
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
                #endregion

                throw;
            }

            return true;
        }

        private void EmailAdmin()
        {
            var msg = new MailMessage(from:adminEmail, to:adminEmail);
            var body = new System.Text.StringBuilder();
            msg.Subject = String.Format("New Applicant - {0}", _applicantName ?? String.Empty);
            body.AppendLine("Someone submitted an application online.  Please see the details below.");
            foreach(var item in Request.Form)
            {//filter out empties, print key/value pairs
                string key = (string)item;
                if(!key.StartsWith("__") &&         //skip view state stuff
                   !key.EndsWith("apply") &&        //skip apply button
                   !key.EndsWith("whichDog") &&     //skip which dog (handled below)
                   !String.IsNullOrEmpty(Request.Form[key]))
                {//splitz
                    var split = key.Split('$');
                    body.Append(split[split.Length - 1]);
                    body.Append(" = ");
                    body.Append((string)Request.Form[key]);
                    body.Append(Environment.NewLine);
                }
            }
            body.AppendLine(dogId != 0 ? String.Format("Dog Name = {0}", repo.GetDogByID(dogId).Name) : String.Empty);
            msg.Body = body.ToString();
            try
            {
                if (debug == true)
                    WriteMailToConsole(msg);
                else 
                    mail.Send(msg);
            }
            catch
            {//log failure
                throw;
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
            //get form values
            var home   = GetFormValue("ownOrRent");
            var phone  = GetFormValue("applicantPhone");
            var petXp  = GetFormValue("petOwnershipExperience");
            var reason = GetFormValue("whyDoYouWantDog");            
            var age    = !String.IsNullOrEmpty(GetFormValue("applicantAge")) 
                ? int.Parse(GetFormValue("applicantAge")) : 0;
            var family = !String.IsNullOrEmpty(GetFormValue("numOfPeopleInHousehold")) 
                ? int.Parse(GetFormValue("numOfPeopleInHousehold")) : 0;
            var yard   = !String.IsNullOrEmpty(GetFormValue("yard")) 
                ? bool.Parse(GetFormValue("yard")) : false;

            HomeOwnershipTypes homeOwner;

            switch (home)
            {
                case "Own"  : homeOwner = HomeOwnershipTypes.Own;     break;
                case "Rent" : homeOwner = HomeOwnershipTypes.Rent;    break;
                case "Other": homeOwner = HomeOwnershipTypes.Other;   break;
                default     : homeOwner = HomeOwnershipTypes.Unknown; break;
            }

            //add this person our mailing list
            var person = new Person
            {
                Email = applicantEmail,
                Name = _applicantName,
                Phone = phone,
                HaveYard = yard,
                HomeOwner = homeOwner,
                PetOwnershipExperience = petXp,
                Reason = reason                
            };

            //add additional optional info
            if (dogId != 0)
                person.DogId = dogId;
            if (family != 0)
                person.NumInHousehold = family;
            if (age != 0)
                person.BirthYear = DateTime.Now.AddYears(-age);

            try
            {
                repo.SavePerson(person);
            }
            catch (Exception ex)
            {
                Response.Write(String.Format("An error occured trying to add this person to the database: {0}", ex.Message));
            }
        }
        public IEnumerable<Dog> GetForSaleDogs()
        {
            return repo.Dogs.Where(x => x.ForSale != ForSaleStatusCode.Sold && x.ForSale != ForSaleStatusCode.NotForSale);
        }

        private string GetFormValue(string key)
        {
            return Request.Form[Request.Form.AllKeys.FirstOrDefault(x => x.EndsWith(key))];
        }
    }
}