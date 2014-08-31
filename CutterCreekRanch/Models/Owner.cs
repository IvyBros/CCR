using System;

namespace CutterCreekRanch.Models
{
    public class Owner
    {
        public int OwnerId { get; set; }
        public int PersonId { get; set; }
        public int DogId { get; set; }
        public string Address1 { get; set; }
        public string Address2 { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public int Zip { get; set; }
        public DateTime DateOfPurchase { get; set; }
        public decimal Cost { get; set; }
    }
}