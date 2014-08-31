using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CutterCreekRanch
{
    public partial class Photos : System.Web.UI.Page
    {
        private Repository repo = new Repository();
        private int dogId;
        public int count = 0;
        public IEnumerable<Dog> dogs;
        public IEnumerable<Photo> photos;

        protected void Page_Load(object sender, EventArgs e)
        {//get photos for all dogs or just 1 specific dog

            MaintainScrollPositionOnPostBack = true;

            if (IsPostBack)
            {
                dogId = int.Parse(Request.Form["dogId"]);
                Response.Redirect(System.IO.Path.Combine("~/Photos/",dogId.ToString()));
            }

            else
            {
                dogId = RouteData.Values["id"] == null ? 0 : int.Parse(RouteData.Values["id"].ToString());
            }
        }

        public int GetCurrentDogId()
        {
            return dogId;
        }

        public IEnumerable<Dog> GetDogs()
        {
            return repo.Dogs;
        }

        public IEnumerable<Photo> GetPhotos()
        {
            return dogId == 0 ? repo.Photos : repo.Photos.Where(x => x.DogId == dogId);
        }
    }
}