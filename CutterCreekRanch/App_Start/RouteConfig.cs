using System;
using System.Web.Routing;

namespace CutterCreekRanch.Routes
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var constraints = new RouteValueDictionary{ {"id",  "[0-9]*" } };
            var photoTypes  = new RouteValueDictionary{ {"img", "[0-9]*" } };
            var defaults    = new RouteValueDictionary{ {"id",  "1"      } };

            routes.MapPageRoute("default",          String.Empty,       "~/Home.aspx");
            routes.MapPageRoute("Home",             "Home",             "~/Home.aspx");
            routes.MapPageRoute("About",            "About",            "~/About.aspx");
            routes.MapPageRoute("Offerings",        "Offerings",        "~/Offerings.aspx");
            routes.MapPageRoute("Contact",          "Contact",          "~/Contact.aspx");
            routes.MapPageRoute("Photos",           "Photos/{id}",      "~/Photos.aspx",    false, null, constraints);
            routes.MapPageRoute("emptyPhotos",      "Photos",           "~/Photos.aspx");
            routes.MapPageRoute("Apply",            "Apply/{id}",       "~/Apply.aspx",     false, null, constraints);
            routes.MapPageRoute("emptyApply",       "Apply",            "~/Apply.aspx");
            routes.MapPageRoute("AllDogs",          "Dogs",             "~/AllDogs.aspx");
            routes.MapPageRoute("Dogs",             "Dogs/{id}",        "~/Dogs.aspx",      false, defaults, constraints);
            routes.MapPageRoute("Image",            "Image/{id}",       "~/img/image.aspx", false, defaults, constraints);
            routes.MapPageRoute("ImageType",        "Image/{id}/{img}", "~/img/image.aspx", false, defaults, constraints);
            routes.MapPageRoute("CropImage",        "Admin/Crop/{id}",  "~/Admin/CropProfilePic.aspx" , false, defaults, constraints);
        }
    }
}