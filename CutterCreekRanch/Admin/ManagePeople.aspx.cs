using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.ModelBinding;

namespace CutterCreekRanch.Admin
{
    public partial class ManagePeople : System.Web.UI.Page
    {
        private Repository repo = new Repository();

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;
        }

        public IEnumerable<Person> GetPersons()
        {
            return repo.Persons;
        }

        public void UpdatePerson(int personId)
        {
            var myPerson = repo.Persons.FirstOrDefault(x => x.PersonId == personId);

            if (TryUpdateModel(myPerson, new FormValueProvider(ModelBindingExecutionContext)))
            {
                repo.SavePerson(myPerson);
            }
        }

        public void DeletePerson(int personId)
        {
            var myPerson = repo.Persons.FirstOrDefault(x => x.PersonId == personId);
            repo.DeletePerson(myPerson);
        }

        public string GetAge(DateTime BirthYear)
        {
            return ((DateTime.Now - BirthYear).Days / 365).ToString();
        }

        public void InsertPerson()
        {
            var myPerson = new Person();
            if (TryUpdateModel(myPerson, new FormValueProvider(ModelBindingExecutionContext)))
            {
                repo.SavePerson(myPerson);
                return;
            }
            
            myPerson.BirthYear = null;
            myPerson.DogId = null;
            myPerson.Email = null;
            myPerson.HaveYard = null;
            myPerson.HomeOwner = null;
            myPerson.NumInHousehold = null;
            myPerson.PetOwnershipExperience = null;
            myPerson.Reason = null;

            repo.SavePerson(myPerson);
        }
    }
}