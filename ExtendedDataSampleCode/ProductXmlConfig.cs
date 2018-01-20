using System;
using System.Xml.Linq;
using Microsoft.EntityFrameworkCore;

namespace ExtendedDataSampleCode
{
    public static class ProductXmlConfig
    {
        public static void ProductMapping(this ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<ProductXml>(entity =>
            {
                entity.ToTable("ProductXml");

                entity.HasKey(e => e.Id);
                entity.Property(e => e.Id).HasColumnName("Id");

                entity.Property(e => e.Name).HasColumnType("varchar(50)");

                entity.Property(e => e.Price).HasColumnType("money");


                entity.Property(c => c.Extended).HasColumnType("xml");
                entity.Ignore(c => c.XmlValueWrapper);

                entity.HasOne(d => d.StoreNavigation)
                    .WithMany(p => p.ProductXml)
                    .HasForeignKey(d => d.Store)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasConstraintName("FK_store_product_xml");
            });
        }
    }
}
