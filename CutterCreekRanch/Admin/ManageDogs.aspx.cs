﻿using CutterCreekRanch.Models;
using CutterCreekRanch.Models.Repository;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Web.ModelBinding;

namespace CutterCreekRanch.Admin
{
    public partial class Default : System.Web.UI.Page
    {
        private Repository repo = new Repository();

        protected void Page_Load(object sender, EventArgs e)
        {
            Page.MaintainScrollPositionOnPostBack = true;
        }

        public IEnumerable<Dog> GetDogs()
        {
            return repo.Dogs;
        }

        public void UpdateDog(int DogId)
        {
            var myDog = repo.Dogs.FirstOrDefault(x => x.DogId == DogId);
            if (myDog != null && TryUpdateModel(myDog, new FormValueProvider(ModelBindingExecutionContext)))
            {
                repo.SaveDog(myDog);
            }
        }

        public void DeleteDog(int DogId)
        {
            var myDog = repo.Dogs.FirstOrDefault(x => x.DogId == DogId);
            if (myDog != null)
            {
                repo.DeleteDog(myDog);
            }
        }

        public void InsertDog()
        {
            var myDog = new Dog();
            if (TryUpdateModel(myDog, new FormValueProvider(ModelBindingExecutionContext)))
            {
                //myDog.Birthdate = DateTime.Parse(myDog.Birthdate);
                repo.SaveDog(myDog);
            }
        }
    }
}