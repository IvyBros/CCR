using System;
using System.Collections.Generic;

namespace CutterCreekRanch.Models.Repository
{
    public class Repository
    {
        private EFDbContext context = new EFDbContext();

        public IEnumerable<Photo> Photos
        {
            get { return context.Photos; }
        }

        public IEnumerable<Dog> Dogs
        {
            get { return context.Dogs; }
        }

        public Photo GetPhotoById(int Id)
        {
            return context.Photos.Find(Id);
        }

        public string GetPhotoUrlById(int Id)
        {
            var photo = GetPhotoById(Id);
            return photo == null ? "default.png" : photo.URL;
        }

        public Dog GetDogByID(int DogId)
        {
            return context.Dogs.Find(DogId);
        }

        public string GetDogNameById(int DogId)
        {
            var dog = GetDogByID(DogId);
            return dog == null ? null : dog.Name;
        }

        public void SavePhoto(Photo photo)
        {
            if (photo.Id == 0)
            {
                context.Photos.Add(photo);
            }
            else
            {
                var dbPhoto = context.Photos.Find(photo.Id);
                if (dbPhoto != null)
                {
                    dbPhoto.DogId = photo.DogId;
                    dbPhoto.Caption = photo.Caption;
                    dbPhoto.TypeOfPhoto = photo.TypeOfPhoto;
                    dbPhoto.URL = photo.URL;
                }
            }
            context.SaveChanges();
        }

        public void SaveDog(Dog dog)
        {
            if (dog.DogId == 0)
            {
                //dog.Birthdate = (System.DateTime)dog.Birthdate;
                context.Dogs.Add(dog);
            }
            else
            {
                var dbDog = context.Dogs.Find(dog.DogId);
                if (dbDog != null)
                {
                    dbDog.Name = dog.Name;
                    dbDog.Mother = dog.Mother;
                    dbDog.Father = dog.Father;
                    dbDog.ForSale = dog.ForSale;
                    dbDog.Description = dog.Description;
                    dbDog.Birthdate = dog.Birthdate;
                    dbDog.Color = dog.Color;
                    dbDog.Price = dog.Price;
                    dbDog.Sex = dog.Sex;
                    dbDog.ProfilePic = dog.ProfilePic;
                    dbDog.VideoUrl = dog.VideoUrl;
                }
            }
            context.SaveChanges();
        }

        public void DeletePhoto(Photo photo)
        {
            context.Photos.Remove(photo);
            context.SaveChanges();
        }

        public void DeleteDog(Dog dog)
        {
            context.Dogs.Remove(dog);
            context.SaveChanges();
        }
    }
}