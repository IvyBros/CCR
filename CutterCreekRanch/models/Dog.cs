using System;

namespace CutterCreekRanch.Models
{
    public class Dog
    {
        public int DogId { get; set; }
        public int Mother { get; set; }
        public int Father { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Color { get; set; }
        public string VideoUrl { get; set; }
        public string CertificateURL { get; set; }
        public int? ProfilePic { get; set; }
        public decimal Price { get; set; }
        public Gender? Sex { get; set; }
        public ForSaleStatusCode? ForSale { get; set; }
        public DateTime Birthdate { get; set; }
    }
    
    public enum Gender { Male = 0, Female = 1 }
    public enum ForSaleStatusCode 
    { 
        ForSale = 0, 
        NotForSale = 1, 
        Sold = 2, 
        Discounted = 3, 
        Adoption = 4, 
        FreeToGoodHome = 5
    }
    public enum Coloring { Standard, Brown, BlueMerle, RedMerle, Other}
}