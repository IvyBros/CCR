using System.Data.Entity;

namespace CutterCreekRanch.Models.Repository
{
    public class EFDbContext : DbContext
    {
        public DbSet<Dog> Dogs { get; set; }
        public DbSet<Photo> Photos { get; set; }
        public DbSet<Person> Persons { get; set; }
        public DbSet<Owner> Owners { get; set; }
    }
}