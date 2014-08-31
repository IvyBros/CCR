using System;

namespace CutterCreekRanch
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack && Request.Form["apply"] != null)
                Response.Redirect("Apply.aspx");
        }
    }
}