using System;
using System.Web.Routing;

namespace CutterCreekRanch
{    
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            Routes.RouteConfig.RegisterRoutes(RouteTable.Routes);
        }
    }
}