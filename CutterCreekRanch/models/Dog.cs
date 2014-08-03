using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CutterCreekRanch.models
{
    public class Dog
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public Gender Sex { get; set; }
        public Coloring Color { get; set; }
        public Dog Mother { get; set; }
        public Dog Father { get; set; }
        public Photo ProfilePic { get; set; }
        public DateTime Birthdate { get; set; }
        public PhotoAlbum Photos { get; set; }
    }

    public enum Gender { Male, Female }
    public enum Coloring { Standard, Brown, BlueMerle, RedMerle, Other}
}