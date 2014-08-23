using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CutterCreekRanch.Models
{
    public class Person
    {
        public int PersonId { get; private set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public int Phone { get; set; }
        public int DogId { get; set; }
        public int NumInHousehold { get; set; }
        public bool HaveYard { get; set; }
        public string PetOwnershipExperience { get; set; }
        public string Reason { get; set; }
        public DateTime BirthYear { get; set; }
        public HomeOwnershipTypes HomeOwner { get; set; }
    }

    public enum HomeOwnershipTypes
    {
        Own = 0,
        Rent = 1,
        Other = 2
    }
}