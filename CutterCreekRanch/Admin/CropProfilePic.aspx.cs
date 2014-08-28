using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Drawing.Drawing2D;
using System.IO;
using SD = System.Drawing;


namespace CutterCreekRanch.Admin
{
    public partial class CropProfilePic : System.Web.UI.Page
    {
        private Repository repo = new Repository();
        protected int photoId;
        public Photo currentPhoto;

        protected void Page_Load(object sender, EventArgs e)
        {
            MaintainScrollPositionOnPostBack = true;

            photoId = int.Parse((string)RouteData.Values["id"]);
            currentPhoto = repo.GetPhotoById(photoId);
            var carPath = Path.Combine("~/img/photos/", currentPhoto.CarouselURL);
            preview.ImageUrl = carPath;
            target.ImageUrl = carPath;
            target.AlternateText = currentPhoto.Caption;            
        }

        public void btnCrop_Click(object src, EventArgs args)
        {
            if (String.IsNullOrEmpty(X.Value) || 
                String.IsNullOrEmpty(Y.Value) || 
                String.IsNullOrEmpty(W.Value) || 
                String.IsNullOrEmpty(H.Value) )
            {
                Response.Write("ERROR! x,y,w, or h undefined");
                return;
            }

            //get values from hidden fields
            int w = Convert.ToInt32(W.Value); 
            int h = Convert.ToInt32(H.Value); 
            int x = Convert.ToInt32(X.Value); 
            int y = Convert.ToInt32(Y.Value);

            var fullCarPath = Path.Combine(Server.MapPath("~/img/photos/"), currentPhoto.CarouselURL);

            var CropImage = Crop(fullCarPath, w, h, x, y); 
            using (var ms = new MemoryStream(CropImage, 0, CropImage.Length)) 
            { 
                var profilePictureFileName = String.Format("profile-{0}", currentPhoto.URL);
                var relativePath = Path.Combine("~/img/photos/", profilePictureFileName);
                var fullProfilePath = Server.MapPath(relativePath);
                ms.Write(CropImage, 0, CropImage.Length); 
                using (var CroppedImage = System.Drawing.Image.FromStream(ms, true)) 
                {
                    //save to file system
                    CroppedImage.Save(fullProfilePath, CroppedImage.RawFormat); 
                    //update image obj in database
                    currentPhoto.ProfileURL = profilePictureFileName;
                    repo.SavePhoto(currentPhoto);
                    //display result screen to user
                    pnlCrop.Visible = false; 
                    pnlCropped.Visible = true;
                    imgCropped.ImageUrl = relativePath;
                    Response.Write(String.Format("Profile Picture Created Successfully: <a href=\"/img/photos/{0}\">{0}</a><br />",
                        profilePictureFileName));
                } 
            }
        }

        static byte[] Crop(string Img, int Width, int Height, int X, int Y) 
        { 
            try 
            { 
                using (var OriginalImage = SD.Image.FromFile(Img)) 
                { 
                    using (var bmp = new SD.Bitmap(Width, Height)) 
                    { 
                        bmp.SetResolution(OriginalImage.HorizontalResolution, OriginalImage.VerticalResolution); 
                        using (var Graphic = SD.Graphics.FromImage(bmp)) 
                        { 
                            Graphic.SmoothingMode = SmoothingMode.AntiAlias; 
                            Graphic.InterpolationMode = InterpolationMode.HighQualityBicubic; 
                            Graphic.PixelOffsetMode = PixelOffsetMode.HighQuality; 
                            Graphic.DrawImage(OriginalImage, new SD.Rectangle(0, 0, Width, Height), X, Y, Width, Height, 
                                SD.GraphicsUnit.Pixel); 
                            var ms = new MemoryStream();
                            bmp.Save(ms, OriginalImage.RawFormat); 
                            return ms.GetBuffer();
                        }
                    }
                }
            }
            catch (Exception Ex) 
            { 
                throw (Ex); 
            }
        }
    }    
}