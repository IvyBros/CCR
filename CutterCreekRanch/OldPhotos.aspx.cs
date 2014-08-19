using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace CutterCreekRanch
{
    public class Thumbs
    {
        public string Name { get; set; }
        public string ImageURL { get; set; }
        public string ThumbURL { get; set; }
        public string Caption { get; set; }
        public DateTime Date { get; set; }
    }

    public partial class Photos : System.Web.UI.Page
    {
        public List<Thumbs> _thumbs = new List<Thumbs>();
        private HashSet<Tuple<string, string>> _imgThumb;
        private HashSet<string> _names;

        protected void Page_Load(object sender, EventArgs e)
        {
            bool debug = false;
            string imageFile;
            string thumbFile;
            var dir = Directory.GetFiles(MapPath("img/photos"));
            _imgThumb = new HashSet<Tuple<string, string>>();
            _names = new HashSet<string>();

            foreach (var fullPath in dir)
            {
                var file = fullPath.Substring(fullPath.LastIndexOf('\\') + 1);
                
                if (file.Contains("thumb"))
                {
                    
                    var chopped = file.Substring(6);

                    try
                    {//look for a matching larger file
                        imageFile = dir.First(x => x.Contains(chopped) && !x.Contains("thumb"));
                    }
                    catch
                    {
                        if (debug == true)
                            Response.Write(String.Format("<br>Found a thumb but no matching larger file for:{0}", file));
                        continue;
                    }
                    thumbFile = file;
                    imageFile = imageFile.Substring(imageFile.LastIndexOf('\\') + 1);
                    _imgThumb.Add(new Tuple<string, string> (thumbFile, imageFile));                    
                }
                else
                {//file does not contain 'thumb', maybe its an original size image file
                    try
                    {//look for an associated thumbFile
                        thumbFile = dir.First(x => x.Contains("thumb") && x.Contains(file));                        
                    }
                    catch
                    {//no associated thumbnail was found
                        if(debug == true)
                            Response.Write(String.Format("<br>no associated thumbnail image found for: {0}", file));
                        //TODO: Add additional processing to create a thumbnail image
                        continue;
                    }
                    thumbFile = thumbFile.Substring(thumbFile.LastIndexOf('\\') + 1);
                    imageFile = file;
                    _imgThumb.Add(new Tuple<string, string>(thumbFile, imageFile));
                    
                }
            }

            foreach (var entry in _imgThumb)
            {
                var name = entry.Item2.Split('.')[0];
                _names.Add(name);
                var date = File.GetCreationTime(MapPath("img/photos/" + entry.Item2));
                _thumbs.Add(new Thumbs
                {
                    ThumbURL = "img/photos/" + entry.Item1,
                    ImageURL = "img/photos/" + entry.Item2,
                    Name = name,
                    Date = date,
                    Caption = String.Format("{0}, {1}", name, date.ToShortDateString())
                });
            }   
        }

        public IEnumerable<string> GetDogs()
        {
            foreach (var name in _names)
                yield return name;
        }

        public IEnumerable<Thumbs> GetThumbsByDogName(string dogName)
        {
            foreach (var item in _thumbs)
            {
                if (item.Name == dogName)
                {
                    yield return item;
                }
            }
        }
    }
}