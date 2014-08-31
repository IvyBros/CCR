using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Linq;

namespace CutterCreekRanch.Admin
{
    public partial class ViewPersonDetails : System.Web.UI.Page
    {
        private Repository repo = new Repository();
        public Person person;
        public Dog dog;
        protected void Page_Load(object sender, EventArgs e)
        {
            var personId = int.Parse(Request["PersonId"]);
            person = repo.Persons.First(x => x.PersonId == personId);
            if (person.DogId != null || person.DogId != 0)
                dog = repo.Dogs.FirstOrDefault(x => x.DogId == person.DogId);
        }
    }
}