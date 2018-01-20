using System;
using System.Linq;
using Newtonsoft.Json;

namespace ExtendedDataSampleCode
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var db = new DatabaseContext())
            {
                var extendedXml = new ExtendedXml
                {
                    SalePrice = 3.99m,
                    OutOfStock = false,
                    ExtendedData = new DataRecord
                    {
                        Key = "QuantityInWarehouse",
                        Value = "5"
                    }
                };

                var productXml = new ProductXml
                {
                    Store = 1,
                    Name = "Stuffed Animal",
                    Price = 5.95m,
                    Extended = extendedXml.Serialize()
                };

                db.ProductXmls.Add(productXml);
                db.SaveChanges();
            }
        }
    }
}
