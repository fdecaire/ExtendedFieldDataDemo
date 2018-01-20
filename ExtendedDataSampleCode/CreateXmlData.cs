using System.IO;
using System.Xml;
using System.Xml.Serialization;

namespace ExtendedDataSampleCode
{
    public static class CreateXmlData
    {
        public static string Serialize(this ExtendedXml xml)
        {
            var xmlSerializer = new XmlSerializer(typeof(ExtendedXml));

            var settings = new XmlWriterSettings
            {
                NewLineHandling = NewLineHandling.Entitize,
                IndentChars = "\t",
                Indent = true
            };

            using (var stringWriter = new StringWriter())
            {
                var writer = XmlWriter.Create(stringWriter, settings);
                xmlSerializer.Serialize(writer, xml);

                return stringWriter.GetStringBuilder().ToString();
            }
        }
    }
}
