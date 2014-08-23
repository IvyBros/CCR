namespace CutterCreekRanch.Models
{
    public class Photo
    {
        public int    Id          { get; private set; } //primary key
        public int    DogId       { get; set; }         //foriegn key
        public string URL         { get; set; }         //relative url
        public string ThumbURL    { get; set; }         //relative url
        public string CarouselURL { get; set; }         //relative url
        public string ProfileURL  { get; set; }         //relative URL
        public string Caption     { get; set; }         //optional captions
    }
    public enum PhotoType
    {
        Carousel   = 0,
        ProfilePic = 1,
        Thumbnail  = 2,
        FullSize   = 3
    }
}
