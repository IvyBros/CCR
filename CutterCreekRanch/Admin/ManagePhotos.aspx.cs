using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Web.ModelBinding;
using System.Web.UI;

namespace CutterCreekRanch.Admin
{
    public partial class ManagePhotos : System.Web.UI.Page
    {
        public int currentDogId = 0;
        public int count = 0;
        public Repository repo = new Repository();
        public Dictionary<int, string> DogNamesAndIds = new Dictionary<int, string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;  
          
            foreach(var item in repo.Dogs)
                DogNamesAndIds.Add(item.DogId, item.Name);
        }

        public IEnumerable<Photo> GetPhotos()
        {
            return repo.Photos.OrderBy(x => x.DogId);
        }

        public void UpdatePhoto(int id)
        {
            var myPhoto = repo.Photos.FirstOrDefault(x => x.Id == id);
            if (myPhoto != null)
            {
                var url = Request.Form["URL"];
                var thumbName = String.Format("thumb-{0}", url);
                var carName = String.Format("carousel-{0}", url);
                var profileName = String.Format("profile-{0}", url);

                if (url != null && url != myPhoto.URL)
                {
                    RenameFiles(myPhoto.URL, url);
                    RenameFiles(myPhoto.ThumbURL, thumbName);
                    RenameFiles(myPhoto.CarouselURL, carName);
                    RenameFiles(myPhoto.ProfileURL, profileName);
                }

                myPhoto.ThumbURL = thumbName;
                myPhoto.CarouselURL = carName;
                myPhoto.ProfileURL = profileName;

                if (TryUpdateModel(myPhoto, new FormValueProvider(ModelBindingExecutionContext)))
                {
                    repo.SavePhoto(myPhoto);
                }
            }
        }

        private void DeletePhotoFromFileSystem(string fName)
        {

            if (fName == null)
            {
                Response.Write("null reference<br>");
                return;   //nothing to do
            }

            var fullName = Path.Combine(Server.MapPath("~/img/photos/"), fName);

            if (!File.Exists(fullName))
            {
                Response.Write(String.Format("File Not Found: {0} <br>", fName));
                return;
            }

            try
            {
                File.Delete(fullName);
                Response.Write(String.Format("File deleted: {0} <br>", fName));
            }
            
            catch
            {//TODO:Add additional error handling here.
                throw;
            }
        }

        public void DeletePhoto(int id)
        {
            var myPhoto = repo.Photos.FirstOrDefault(x => x.Id == id);
            if (myPhoto != null)
            {//remove from file system
                DeletePhotoFromFileSystem(myPhoto.URL);
                DeletePhotoFromFileSystem(myPhoto.CarouselURL);
                DeletePhotoFromFileSystem(myPhoto.ThumbURL);
                if (!String.IsNullOrEmpty(myPhoto.ProfileURL))
                    DeletePhotoFromFileSystem(myPhoto.ProfileURL);
                //remove from db
                repo.DeletePhoto(myPhoto);
            }
        }
        
        protected void UploadButton_Click(object sender, EventArgs e)
        {//inserts photos into db
            if (file1.HasFiles)
            {
                var dogId = Request.Form["uploadDogId"];
                var allCaptions = Request.Form["uploadCaption"];
                var captions = allCaptions.Split(';');
                int capCount = 0;

                foreach (var uploadedfile in file1.PostedFiles)
                {//create a thumb and add to the database

                    var thumbnail = ResizeImage(uploadedfile.FileName, 250, 250);
                    var carousel = ResizeImage(uploadedfile.FileName, 580, 350);
                    var justName = Path.GetFileName(uploadedfile.FileName);
                    var thumbFileName = Path.Combine(Server.MapPath("~/img/Photos/"), 
                        String.Format("thumb-{0}", justName));
                    var carFileName = Path.Combine(Server.MapPath("~/img/Photos/"),
                        String.Format("carousel-{0}", justName));

                    var photo = new Photo
                    {
                        URL = justName,
                        Caption = !String.IsNullOrEmpty(allCaptions) && capCount < captions.Length 
                            ? captions[capCount] : captions[0] ?? null,
                        DogId = int.Parse(dogId),
                        ThumbURL = String.Format("thumb-{0}", justName),
                        CarouselURL = String.Format("carousel-{0}", justName)
                    };

                    capCount++;
                                        
                    try
                    {//save to the file system.
                        uploadedfile.SaveAs(Path.Combine(Server.MapPath("~/img/photos/"), justName));
                        thumbnail.Save(thumbFileName, ImageFormat.Jpeg);
                        carousel.Save(carFileName, ImageFormat.Jpeg);
                        Response.Write(String.Format("File uploaded successfully: {0}<br>", justName));
                        Response.Write("Thumbnail File created successfully<br>");
                        Response.Write("Carousel File created successfully<br>");
                        //save to db
                        repo.SavePhoto(photo);
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error:" + ex.Message);
                    }
                }
            }
        }

        private System.Drawing.Image ResizeImage(string fileName, int desiredMaxWidth, int desiredMaxHeight)
        {
            var original = new Bitmap(fileName, true);
            var width = original.Size.Width;
            var height = original.Size.Height;
            var widthRatio = (float)desiredMaxWidth / (float)width;
            var heightRatio= (float)desiredMaxHeight/ (float)height;
            var aspect = heightRatio < widthRatio ? heightRatio : widthRatio;
            var newWidth = (int)(width * aspect);
            var newHeight = (int)(height * aspect);

            var carousel = new Bitmap(newWidth, newHeight);
            var g = Graphics.FromImage((Image)carousel);
            g.SmoothingMode = SmoothingMode.AntiAlias;
            g.InterpolationMode = InterpolationMode.HighQualityBicubic;
            g.PixelOffsetMode = PixelOffsetMode.HighQuality;
            g.DrawImage(original, 0, 0, newWidth, newHeight);
            g.Dispose();
            original.Dispose();
            return (Image)carousel;
        }

        private static bool onError()
        {
            throw new Exception("Problem creating Thumbnail Image File");
        }

        private void RenameFiles(string old, string url)
        {
            var oldName = Path.Combine(Server.MapPath("~/img/photos/"), old);
            var newName = Path.Combine(Server.MapPath("~/img/photos/"), url);

            if (File.Exists(newName))
                throw new Exception("That file name already exists. Pick another.");
            if (!File.Exists(oldName))
            {
                throw new FileNotFoundException(String.Format("File Not Found: {0}", oldName));
            }
            try
            {
                File.Move(oldName, newName);
                Response.Write(String.Format("Renamed {0} to {1}<br>", old, url));
            }

            catch (Exception ex)
            {//TODO:Add additional processing here to pinpoint problem
                throw new Exception(ex.Message);
            }
        }
        protected string GetFileSize(string fileName)
        {
            if (fileName == null) return "?";
            var fullName = Path.Combine(Server.MapPath("~/img/photos/"), fileName);
            if(File.Exists(fullName))
            {
                var fAttr = new FileInfo(fullName);
                return (fAttr.Length / 1000).ToString();
            }
            return "?";
        }

        public bool IsProfilePic(int id, int dogId)
        {
            var dog = repo.GetDogByID(dogId);
            if (dog != null)
                return dog.ProfilePic == id ? true : false;
            return false;
        }
    }
}