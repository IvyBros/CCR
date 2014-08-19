using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System.Web.ModelBinding;
using System.Web.UI.HtmlControls;
using System.IO;

namespace CutterCreekRanch.Admin
{
    public partial class ManagePhotos : System.Web.UI.Page
    {
        public Repository repo = new Repository();
        public int currentDogId = 0;
        public int count = 0;
        public Dictionary<int, string> DogNamesAndIds = new Dictionary<int, string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            foreach(var item in repo.Dogs)
                DogNamesAndIds.Add(item.DogId, item.Name);

            Page.MaintainScrollPositionOnPostBack = true;            
        }

        public IEnumerable<Photo> GetPhotos()
        {
            return repo.Photos;
        }

        public void UpdatePhoto(int id)
        {
            var myPhoto = repo.Photos.FirstOrDefault(x => x.Id == id);
            if (myPhoto != null && TryUpdateModel(myPhoto, new FormValueProvider(ModelBindingExecutionContext)))
            {
                repo.SavePhoto(myPhoto);
            }
        }

        public void DeletePhoto(int id)
        {
            var myPhoto = repo.Photos.FirstOrDefault(x => x.Id == id);
            if (myPhoto != null)
            {
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
                int count = 0;

                foreach (var uploadedfile in file1.PostedFiles)
                {

                    //create a new photo object
                    var photo = new Photo 
                    { 
                        URL = Path.GetFileName(uploadedfile.FileName), 
                        TypeOfPhoto = PhotoType.FullSize,
                        Caption = allCaptions != null ? captions[count] ?? captions[0] : null,
                        DogId = int.Parse(dogId)
                    };
                    count++;
                    //add to db
                    repo.SavePhoto(photo);

                    //TODO: create a thumbnail version?
                    
                    //save it to the file system.
                    try
                    {
                        uploadedfile.SaveAs(Path.Combine(Server.MapPath("~/img/photos/"), 
                            Path.GetFileName(uploadedfile.FileName)));
                        Response.Write("File uploaded successfully<br>");
                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error:" + ex.Message);
                    }
                }
            }
        }
    }
}