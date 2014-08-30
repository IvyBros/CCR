using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;

namespace CutterCreekRanch
{
    public partial class Photos : System.Web.UI.Page
    {
        protected int id;
        private Repository repo = new Repository();
        public IEnumerable<Dog> dogs;
        public IEnumerable<Photo> photos;
        public int count = 0;

        protected void Page_Load(object sender, EventArgs e)
        {//get photos for all dogs or just 1 specific dog
            id = RouteData.Values["id"] == null ? 0 : int.Parse(RouteData.Values["id"].ToString());
            dogs = repo.Dogs;
            if (id == 0)
            {//ignore this case for now
                photos = repo.Photos;
            }
            else
            {
                //dogs = repo.Dogs.Where(x => x.DogId == id);
                photos = repo.Photos.Where(x => x.DogId == id);
            }
        }

        public IEnumerable<Dog> GetDogs()
        {
            return dogs;
        }

        public IEnumerable<Photo> GetPhotos()
        {
            return photos;
        }
    }
}