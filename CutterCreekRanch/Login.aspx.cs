﻿using System;
using System.Web.Security;

namespace CutterCreekRanch
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                var user = Request["user"];
                var pass = Request["pass"];
                var acts = Request["action"];
                
                if (acts == "login" && user == "admin" && pass == "Ivy123!")
                {
                    FormsAuthentication.SetAuthCookie(user, true);
                    Response.Redirect(FormsAuthentication.GetRedirectUrl("admin", true));
                }
                else FormsAuthentication.SignOut();                

                Response.Redirect(Request.Path);
            }
        }

        protected string GetUser()
        {
            return Context.User.Identity.Name;
        }

        protected bool GetRequestStatus()
        {
            return Request.IsAuthenticated;
        }
    }
}