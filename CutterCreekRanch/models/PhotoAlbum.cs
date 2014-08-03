using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CutterCreekRanch.models
{
    public class PhotoAlbum
    {
        List<Photo> Photos { get; set; }
    }
    public class Photo
    {
        public string URL { get; set; }
        public string Caption { get; set; }
        public Photo Thumb { get; set; }
        public Photo FullSizeImage { get; set; }
        public List<Dog> Dogs { get; set; }
        public DateTime Date { get; set; }
    }
}
