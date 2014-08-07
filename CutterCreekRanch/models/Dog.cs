using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CutterCreekRanch.Models
{
    public class Dog
    {
        public int DogId { get; set; }
        public int Mother { get; set; }
        public int Father { get; set; }
        public ForSaleStatusCode ForSale { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public Gender Sex { get; set; }
        public string Color { get; set; }
        public string ProfilePic { get; set; }
        public decimal Price { get; set; }
        public DateTime Birthdate { get; set; }
        public List<string> Photos { get; set; }
        //public List<Photo> Photos { get; set; }
    }
    
    public enum Gender { Male = 0, Female = 1 }
    public enum ForSaleStatusCode { ForSale = 0, NotForSale = 1, Sold = 2}
    public enum Coloring { Standard, Brown, BlueMerle, RedMerle, Other}
}