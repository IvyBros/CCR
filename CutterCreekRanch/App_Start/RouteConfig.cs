﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Routing;

namespace CutterCreekRanch.Routes
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.MapPageRoute("default", String.Empty, "~/Home.aspx");
            routes.MapPageRoute("Home", "Home", "~/Home.aspx");
            routes.MapPageRoute("About", "About", "~/About.aspx");
            routes.MapPageRoute("Offerings", "Offerings", "~/Offerings.aspx");
            routes.MapPageRoute("Photos", "Photos", "~/Photos.aspx");
            routes.MapPageRoute("Contact", "Contact", "~/Contact.aspx");
        }
    }
}