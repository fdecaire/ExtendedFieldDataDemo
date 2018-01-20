namespace ExtendedDataSampleCode
{
    public class ExtendedXml
    {
        public decimal SalePrice { get; set; }
        public bool OutOfStock { get; set; }
        public DataRecord ExtendedData = new DataRecord();
    }

    public class DataRecord
    {
        public string Key { get; set; }
        public string Value { get; set; }
    }
}
