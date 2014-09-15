using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System.Web.UI.WebControls;

namespace CutterCreekRanch.Admin
{
    public partial class ManageOwners : System.Web.UI.Page
    {
        public Dictionary<int, string> dogsById = new Dictionary<int, string>();
        public Dictionary<int, string> personsById = new Dictionary<int, string>();
        private Repository repo = new Repository();

        protected void Page_Load(object sender, EventArgs e)
        {
            MaintainScrollPositionOnPostBack = true;

            foreach (var item in repo.Dogs)
                dogsById.Add(item.DogId, item.Name);

            foreach (var item in repo.Persons)
                personsById.Add(item.PersonId, item.Name);
        }

        public string GetPersonName(int personId)
        {
            return (personsById.ContainsKey(personId)) ? personsById[personId] : "Unknown";
        }

        public string GetDogName(int dogId)
        {
            return (dogsById.ContainsKey(dogId)) ? dogsById[dogId] : "Unknown";                
        }

        public IEnumerable<Owner> GetOwners()
        {
            return repo.Owners;
        }

        public void UpdateOwner(int ownerId)
        {
            var owner = repo.Owners.FirstOrDefault(x => x.OwnerId == ownerId);
            if(TryUpdateModel(owner, new FormValueProvider(ModelBindingExecutionContext)))
            {
                repo.SaveOwner(owner);
            }
        }

        public void DeleteOwner(int ownerId)
        {
            var owner = repo.Owners.FirstOrDefault(x => x.OwnerId == ownerId);
            if (owner != null)
            {
                repo.DeleteOwner(owner);
            }
        }

        public void InsertOwner()
        {
            var myOwner = new Owner();
            if(TryUpdateModel(myOwner, new FormValueProvider(ModelBindingExecutionContext)))
            {
                repo.SaveOwner(myOwner);
                return;
            }
        }
    }
}