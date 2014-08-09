using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;

namespace CutterCreekRanch.controls
{
    public partial class DogListing : System.Web.UI.UserControl
    {
        private Repository repo = new Repository();

        public IEnumerable<Dog> GetDogs()
        {
            return repo.Dogs.Where(x=>x.DogId != 7 && x.ForSale != ForSaleStatusCode.NotForSale).OrderBy(x=>x.ForSale);
        }

        public string GetDogNameById(int id)
        {
            var dog = repo.GetDogByID(id);
            return dog == null ? "Unknown" : dog.Name;
        }
    }
}