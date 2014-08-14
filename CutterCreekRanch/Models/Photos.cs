using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.ModelBinding;
//using System.Data.Entity;
//using System.Data.Sql;
using System.Text;
using System.ComponentModel.DataAnnotations.Schema;

namespace CutterCreekRanch.Models
{
    public class Photo
    {
        public int Id { get; private set; } //primary key
        public int DogId { get; set; }  //foriegn key
        public string URL { get; set; } //relative url
        public string Caption { get; set; } //optional captions
        public PhotoType TypeOfPhoto { get; set; }  //how this photos should be used.
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
