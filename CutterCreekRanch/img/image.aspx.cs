using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace CutterCreekRanch.img
{
    public partial class image : System.Web.UI.Page
    {
        protected Repository repo = new Repository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (RouteData.Values["id"] == null) 
                throw new Exception("You must provide an image id.");

            var photoId = RouteData.Values["id"] != null ? int.Parse((string)RouteData.Values["id"]) : 1;
            var photo = repo.GetPhotoById(photoId);

            if (photo == null)
                photo = repo.GetPhotoById(7);

            var img = RouteData.Values["img"] != null ? (PhotoType)int.Parse((string)RouteData.Values["img"]) : PhotoType.FullSize;
            string fullPath, fileName;
            
            switch (img)
            {
                case PhotoType.Carousel   : fileName = photo.CarouselURL ?? photo.URL ?? "default.png"; break;
                case PhotoType.ProfilePic : fileName = photo.ProfileURL  ?? photo.CarouselURL ?? photo.URL         ?? photo.ThumbURL ?? "default.png"; break;
                case PhotoType.Thumbnail  : fileName = photo.ThumbURL    ?? photo.ProfileURL  ?? photo.CarouselURL ?? photo.URL      ?? "default.png"; break;
                default                   : fileName = photo.URL         ?? photo.CarouselURL ?? photo.ProfileURL  ?? photo.ThumbURL ?? "default.png"; break;
            }
            
            fullPath = Server.MapPath(Path.Combine("~/img/photos/", fileName));
            if (File.Exists(fullPath))
            {
                var objImage = new Bitmap(fullPath);
                objImage.Save(Response.OutputStream, ImageFormat.Jpeg);
                objImage.Dispose();
            }
        }
    }
}