using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;

using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CutterCreekRanch.Models.Repository;
using CutterCreekRanch.Models;

namespace CutterCreekRanch.img
{
    public partial class image : System.Web.UI.Page
    {
        protected Repository repo = new Repository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (RouteData.Values["id"] == null) throw new Exception("An error occured. You must provide an image id.");

            var photoId = RouteData.Values["id"] == null ? 1 : int.Parse(RouteData.Values["id"].ToString());
            var photoPath = Path.Combine("~/img/", repo.GetPhotoUrlById(photoId));            
            var path = Server.MapPath( photoPath == null ? "~/img/paw-pring.png" : photoPath );
            var objImage = new Bitmap(path);

            objImage.Save(Response.OutputStream, ImageFormat.Jpeg);
            objImage.Dispose();
        }
    }
}