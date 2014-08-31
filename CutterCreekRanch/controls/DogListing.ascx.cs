using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CutterCreekRanch.controls
{
    public partial class DogListing : System.Web.UI.UserControl
    {
        public bool Unfiltered { get; set; }
        private Repository repo = new Repository();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {

                if (Request.Form["details"] != null)
                    Response.Redirect(String.Format("~/Dogs/{0}", Request.Form["details"]));
                if (Request.Form["apply"] != null)
                    Response.Redirect(String.Format("~/Apply/{0}",Request.Form["apply"]));
                if (Request.Form["photos"] != null)
                    Response.Redirect(String.Format("~/Photos/{0}", Request.Form["photos"]));
            }
        }

        public IEnumerable<Dog> GetDogs()
        {
            if (Unfiltered) return repo.Dogs.OrderBy(x => x.DogId);
            return repo.Dogs.Where(x => x.ForSale != ForSaleStatusCode.NotForSale).OrderBy(x=>x.ForSale);
        }

        public IEnumerable<Photo> GetThumbnailPhotosByDogId(int dogId)
        {
            return repo.Photos.Where(x => x.DogId == dogId);
        }

        public string GetDogNameById(int id)
        {
            var dog = repo.GetDogByID(id);
            return dog == null ? "Unknown" : dog.Name;
        }

    }
}