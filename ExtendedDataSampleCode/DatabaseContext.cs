using Microsoft.EntityFrameworkCore;

namespace ExtendedDataSampleCode
{
    public partial class DatabaseContext : DbContext
    {
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(@"Server={YOURSQLSERVERNAME};Database=DemoData;Trusted_Connection=True;");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.StoreMapping();
            modelBuilder.ProductMapping();
        }

        public virtual DbSet<ProductXml> ProductXmls { get; set; }
        public virtual DbSet<Store> Stores { get; set; }
    }
}
