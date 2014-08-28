using System;
using System.ComponentModel.DataAnnotations;

namespace CutterCreekRanch.Models
{
    public class Person
    {
        [Required]
        public int PersonId { get; private set; }
        [Required]
        public string Name { get; set; }
        [Required]
        public string Email { get; set; }

        public string Phone { get; set; }
        public int? DogId { get; set; }
        public int? NumInHousehold { get; set; }
        public bool? HaveYard { get; set; }
        public string PetOwnershipExperience { get; set; }
        public string Reason { get; set; }
        public DateTime? BirthYear { get; set; }
        public HomeOwnershipTypes? HomeOwner { get; set; }
    }

    public enum HomeOwnershipTypes
    {
        Own = 0,
        Rent = 1,
        Other = 2,
        Unknown = 3
    }
}