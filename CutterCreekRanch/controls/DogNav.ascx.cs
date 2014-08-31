using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System;
using System.Linq;

namespace CutterCreekRanch.controls
{
    public partial class DogNav : System.Web.UI.UserControl
    {//TODO:this works and is pretty damn fast, but it seems like a hack.  maybe theres a more elegant solution
        private Repository repo = new Repository();
        private int currentDogId;

        public int nextDogId { get; set; }
        public int prevDogId { get; set; }
        public bool FilterNotForSale { get; set; }
        
        protected void Page_Load(object sender, EventArgs e)
        {
            var url = Request.RawUrl;
            var index = url.LastIndexOf('/');
            if (index > 0)
            {
                var str = url.Substring(index + 1);
                currentDogId = int.Parse(str);
            }
            else currentDogId = 1;

            prevDogId = GetPrevDogId(currentDogId);
            nextDogId = GetNextDogId(currentDogId);
        }

        public int GetNextDogId(int currentId)
        {
            var next = new Dog();
            if (FilterNotForSale)
                next = repo.Dogs.FirstOrDefault(x => x.DogId > currentDogId && x.ForSale != ForSaleStatusCode.NotForSale);
            else next = repo.Dogs.FirstOrDefault(x => x.DogId > currentDogId);
            return next == null ? 0 : next.DogId;

        }

        public int GetPrevDogId(int currentId)
        {
            var prev = new Dog();
            if (currentId <= 0) return 0;
            if (FilterNotForSale)
            {
                prev = repo.Dogs.FirstOrDefault(x => x.DogId == currentDogId - 1 && 
                    x.ForSale != ForSaleStatusCode.NotForSale);
            }
            else prev = repo.Dogs.FirstOrDefault( x=> x.DogId == currentId - 1 );
            return prev != null ? prev.DogId : GetPrevDogId(currentId - 1);
        }
    }
}