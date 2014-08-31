using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.ModelBinding;

namespace CutterCreekRanch.Admin
{
    public partial class Default : System.Web.UI.Page
    {
        private Repository repo = new Repository();
        protected Dictionary<int, string> dogNamesToIds = new Dictionary<int,string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;
            foreach (var item in repo.Dogs)
                dogNamesToIds.Add(item.DogId, item.Name);
        }

        public string GetName(int dogId)
        {
            if (dogNamesToIds == null || dogId == 0) 
                return "Unknown";
            return dogNamesToIds.ContainsKey(dogId) ? dogNamesToIds[dogId] : "Unknown";
        }

        public IEnumerable<Dog> GetDogs()
        {
            return repo.Dogs;
        }

        public void UpdateDog(int DogId)
        {
            var myDog = repo.Dogs.FirstOrDefault(x => x.DogId == DogId);
            if (myDog != null)
            {
                if(TryUpdateModel(myDog, new FormValueProvider(ModelBindingExecutionContext)))
                {
                    repo.SaveDog(myDog);

                    var photoID = myDog.ProfilePic;
                    if (photoID == null || photoID == 0) return;
                    var myPhoto = repo.GetPhotoById((int)photoID);
                    if (myPhoto == null) return;
                    myPhoto.DogId = myDog.DogId;
                    repo.SavePhoto(myPhoto);
                }
            }
        }

        public void DeleteDog(int DogId)
        {
            var myDog = repo.Dogs.FirstOrDefault(x => x.DogId == DogId);
            if (myDog != null)
            {
                repo.DeleteDog(myDog);
            }
        }

        public void InsertDog()
        {
            var myDog = new Dog();

            if (TryUpdateModel(myDog, new FormValueProvider(ModelBindingExecutionContext)))
            {
                repo.SaveDog(myDog);
                return;
            }
            
            var Name = Request.Form["Name"];
            var Sex = Request.Form["Sex"];

            if (String.IsNullOrEmpty(Name))
            {
                DisplayAddError("Name"); 
                return;
            }
            if (String.IsNullOrEmpty(Sex))
            {
                DisplayAddError("Sex"); 
                return;
            }

            var ForSale = Request.Form["ForSale"];
            var Mother = !String.IsNullOrEmpty(Request.Form["Mother"])
                ? int.Parse(Request.Form["Mother"]) : 0;
            var Father = !String.IsNullOrEmpty(Request.Form["Father"])
                ? int.Parse(Request.Form["Father"]) : 0;
            var Description = !String.IsNullOrEmpty(Request.Form["Description"])
                ? Request.Form["Description"] : "Please add a description for this dog.";
            var Color = !String.IsNullOrEmpty(Request.Form["Color"])
                ? Request.Form["Color"] : "Please add color information for this dog";
            var Price = !String.IsNullOrEmpty(Request.Form["Price"])
                ? Decimal.Parse(Request.Form["Price"]) : 0m;
            var BirthDate = !String.IsNullOrEmpty(Request.Form["BirthDate"])
                ? DateTime.Parse(Request.Form["BirthDate"]) : DateTime.Parse("01/01/2001");
            var ProfilePic = !String.IsNullOrEmpty(Request.Form["ProfilePic"])
                ? int.Parse(Request.Form["ProfilePic"]) : 0;

            myDog.Name = Name;
            myDog.Mother = Mother;
            myDog.Father = Father;
            myDog.Description = Description;
            myDog.Color = Color;
            myDog.Price = Price;
            myDog.Birthdate = BirthDate;
            myDog.ProfilePic = ProfilePic;

            repo.SaveDog(myDog);
        }
        public void DisplayAddError(string missingRequiredField)
        {
            Response.Write(String.Format("Cannot add dog to database.  Missing required field: {0}<br>", missingRequiredField));
            return;
        }
    }
}