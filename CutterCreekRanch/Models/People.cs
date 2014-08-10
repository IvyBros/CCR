using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CutterCreekRanch.Models
{
    public class People
    {
        public int? Age { get; set; }
        public int? NumInHousehold { get; set; }
        public bool HaveYard { get; set; }
        public string Name { get; set; }
        public string EMail { get; set; }
        public string Phone { get; set; }
        public string PetOwnershipExperience { get; set; }
        public string WhyWanted { get; set; }
        public DateTime AddedDate { get; set; }
        public HomeOwnershipTypes OwnOrRent { get; set; }
    }
    public enum HomeOwnershipTypes
    {
        Own = 0,
        Rent = 1,
        Other = 2
    }
}