using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CutterCreekRanch.controls
{
    public partial class NavLinks : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //
        }
        //quick and dirty...look for a more elegant solution.
        protected string GetActiveClass(string url)
        {
            if (Context.Request.Path == "/") return String.Empty;
            return Context.Request.Path.Contains(url) ? " class=\"active\"" : String.Empty;            
        }
        protected string GetHomeClass()
        {
            return Context.Request.Path == "/" || Context.Request.Path.Contains("Home") ? " class=active" : String.Empty;
        }
    }
}