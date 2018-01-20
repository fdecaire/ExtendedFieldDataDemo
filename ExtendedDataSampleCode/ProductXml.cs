using System.Xml.Linq;

namespace ExtendedDataSampleCode
{
    public class ProductXml
    {
        public XElement XmlValueWrapper
        {
            get { return XElement.Parse(Extended); }
            set { Extended = value.ToString(); }
        }

        public int Id { get; set; }
        public int Store { get; set; }
        public string Name { get; set; } 
        public decimal? Price { get; set; }
        public string Extended { get; set; }

        public virtual Store StoreNavigation { get; set; }
    }
}
