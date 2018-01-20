using System;
using System.Collections.Generic;
using System.Text;

namespace ExtendedDataSampleCode
{
    public class Store
    {
        public Store()
        {
            ProductXml = new HashSet<ProductXml>();
        }

        public int Id { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }

        public virtual ICollection<ProductXml> ProductXml { get; set; }
    }
}
