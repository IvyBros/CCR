using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CutterCreekRanch.Models
{
    public class Photo
    {
        public int ID { get; set; }
        public string URL { get; set; }
        public string Caption { get; set; }
        public DateTime Date { get; set; }
        public PhotoType typeOfPhoto { get; set; }
    }
    public enum PhotoType
    {
        ProfilePic = 0,
        Thumbnail = 1,
        FullSize = 2,
        Cropped = 3,
        BlackAndWhite = 4
    }
}
