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

        public IEnumerable<Person> Persons
        {
            get { return context.Persons; }
        }

        public IEnumerable<Owner> Owners
        {
            get { return context.Owners; }
        }

        public Person GetPersonById(int personId)
        {
            return context.Persons.Find(personId);
        }

        public Photo GetPhotoById(int Id)
        {
            return context.Photos.Find(Id);
        }

        public Dog GetDogByID(int DogId)
        {
            return context.Dogs.Find(DogId);
        }

        public Owner GetOwnerById(int ownerId)
        {
            return context.Owners.Find(ownerId);
        }

        public string GetPhotoUrlById(int Id)
        {
            var photo = GetPhotoById(Id);
            return photo == null ? "default.png" : photo.URL;
        }

        public string GetDogNameById(int DogId)
        {
            var dog = GetDogByID(DogId);
            return dog == null ? null : dog.Name;
        }

        public void SaveOwner(Owner owner)
        {
            if (owner.OwnerId == 0)
                context.Owners.Add(owner);
            else
            {
                var dbOwner = context.Owners.Find(owner.OwnerId);
                if (dbOwner != null)
                {
                    dbOwner.Address1 = owner.Address1;
                    dbOwner.Address2 = owner.Address2;
                    dbOwner.City = owner.City;
                    dbOwner.State = owner.State;
                    dbOwner.Zip = owner.Zip;
                    dbOwner.DogId = owner.DogId;
                    dbOwner.PersonId = owner.PersonId;
                    dbOwner.Cost = owner.Cost;
                    dbOwner.DateOfPurchase = owner.DateOfPurchase;
                }
            }
            context.SaveChanges();
        }

        public void SavePerson(Person person)
        {
            if (person.PersonId == 0)
                context.Persons.Add(person);
            else
            {
                var dbPerson = context.Persons.Find(person.PersonId);
                if(dbPerson != null)
                {
                    dbPerson.BirthYear = person.BirthYear;
                    dbPerson.DogId = person.DogId;
                    dbPerson.Email = person.Email;
                    dbPerson.HaveYard = person.HaveYard;
                    dbPerson.HomeOwner = person.HomeOwner;
                    dbPerson.Name = person.Name;
                    dbPerson.NumInHousehold = person.NumInHousehold;
                    dbPerson.PetOwnershipExperience = person.PetOwnershipExperience;
                    dbPerson.Phone = person.Phone;
                    dbPerson.Reason = person.Reason;
                }
            }
            context.SaveChanges();
        }

        public void SavePhoto(Photo photo)
        {
            if (photo.Id == 0)
                context.Photos.Add(photo);
            
            else
            {
                var dbPhoto = context.Photos.Find(photo.Id);
                if (dbPhoto != null)
                {
                    dbPhoto.URL = photo.URL;
                    dbPhoto.DogId = photo.DogId;
                    dbPhoto.Caption = photo.Caption;
                    dbPhoto.ThumbURL = photo.ThumbURL;
                    dbPhoto.CarouselURL = photo.CarouselURL;
                    dbPhoto.ProfileURL = photo.ProfileURL;
                }
            }
            context.SaveChanges();
        }

        public void SaveDog(Dog dog)
        {
            if (dog.DogId == 0)
                context.Dogs.Add(dog);
            
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

        public void DeleteOwner(Owner owner)
        {
            context.Owners.Remove(owner);
            context.SaveChanges();
        }

        public void DeletePerson(Person person)
        {
            context.Persons.Remove(person);
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