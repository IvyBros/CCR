using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CutterCreekRanch
{
    public partial class Dogs : System.Web.UI.Page
    {
        protected Repository repo = new Repository();
        public Dog Dog;
        public Dog Mother;
        public Dog Father;
        public int count;
        public int numberOfPhotos;
        private int id;

        protected void Page_Load(object sender, EventArgs e)
        {
            MaintainScrollPositionOnPostBack = true;
            if (IsPostBack)
            {
                if(Request.Form["apply"] != null)
                {
                    var applyId = Request.Form["apply"];
                    Response.Redirect(String.Format("~/Apply/{0}", applyId));
                }
            }

            id = RouteData.Values["id"] == null ? 1 : int.Parse(RouteData.Values["id"].ToString());
            Dog = repo.GetDogByID(id);
            if (Dog != null)
            {
                Mother = repo.GetDogByID(Dog.Mother);
                Father = repo.GetDogByID(Dog.Father);
                numberOfPhotos = repo.Photos.Where(x => x.DogId == Dog.DogId).Count();
                numberOfPhotos = numberOfPhotos != 0 ? numberOfPhotos : 1;
            }
            else Response.Redirect("~/Dogs");
        }

        public IEnumerable<Photo> GetPicturesByDogId()
        {
            var photos = repo.Photos.Where(x => x.DogId == id);
            return photos.Count() > 0 ? photos : repo.Photos.Where(x=>x.Id == 105);
        }

        public IEnumerable<Dog> GetRelationships()
        {
            var children = Dog.Sex == CutterCreekRanch.Models.Gender.Male
                ? repo.Dogs.Where(x => x.Father == Dog.DogId)
                : repo.Dogs.Where(x => x.Mother == Dog.DogId);

            return children;
        }
    }
}