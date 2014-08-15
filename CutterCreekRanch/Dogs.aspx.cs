using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.ModelBinding;
using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;

namespace CutterCreekRanch
{
    public partial class Dogs : System.Web.UI.Page
    {
        protected Repository repo = new Repository();
        public Dog Dog;
        public Dog Mother;
        public Dog Father;
        public int count;
        private int id;

        protected void Page_Load(object sender, EventArgs e)
        {
            id = RouteData.Values["id"] == null ? 1 : int.Parse(RouteData.Values["id"].ToString());
            Dog = repo.GetDogByID(id);
            if (Dog != null)
            {
                Mother = repo.GetDogByID(Dog.Mother);
                Father = repo.GetDogByID(Dog.Father);
            }
            else Response.Redirect("~/Dogs");
        }

        public IEnumerable<Photo> GetPicturesByDogId()
        {
            return repo.Photos.Where(x => x.DogId == id && x.Id != Dog.ProfilePic);
        }
    }
}