---------------------------------------------------------------------------------
-- store, used by all examples

CREATE TABLE [dbo].[Store](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[Zip] [varchar](50) NULL,
 CONSTRAINT [PK_Store] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

---------------------------------------------------------------------------------
-- sample 1, fixed fields


CREATE TABLE [dbo].[ProductExtended](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Store] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Price] [money] NULL,
	[Text1] [varchar](20) NULL,
	[Text2] [varchar](20) NULL,
	[Text3] [varchar](20) NULL,
	[Text4] [varchar](20) NULL,
	[Bit1] [bit] NULL,
	[Bit2] [bit] NULL,
	[Bit3] [bit] NULL,
	[Bit4] [bit] NULL,
	[Int1] [int] NULL,
	[Int2] [int] NULL,
	[Int3] [int] NULL,
	[Int4] [int] NULL,
	[Money1] [money] NULL,
	[Money2] [money] NULL,
	[Money3] [money] NULL,
	[Money4] [money] NULL
 CONSTRAINT [PK_Product_extended] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ProductExtended]  WITH CHECK ADD  CONSTRAINT [FK_store_product_extended] FOREIGN KEY([Store])
REFERENCES [dbo].[Store] ([Id])
GO

ALTER TABLE [dbo].[ProductExtended] CHECK CONSTRAINT [FK_store_product_extended]
GO


CREATE TABLE [dbo].[MetaDataExtended](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[FieldName] [varchar](20) NULL,
	[Label] [varchar](50) NULL
 CONSTRAINT [PK_MetaDataExtended] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

---------------------------------------------------------------------------------
-- sample 2, xml

CREATE TABLE [dbo].[ProductXml](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Store] [int] NOT NULL,
	[Name] [varchar](50) NULL,
	[Price] [money] NULL,
	[Extended] [xml] NULL,
 CONSTRAINT [PK_Product_xml] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ProductXml]  WITH CHECK ADD  CONSTRAINT [FK_store_product_xml] FOREIGN KEY([Store])
REFERENCES [dbo].[Store] ([Id])
GO

ALTER TABLE [dbo].[ProductXml] CHECK CONSTRAINT [FK_store_product_xml]
GO

---------------------------------------------------------------------------------
-- sample 3, extended data table

CREATE TABLE [dbo].[MetaDataDictionary](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [varchar](50) NOT NULL,
	[Label] [varchar](50) NULL,
	[DataType] [varchar](20) NULL
 CONSTRAINT [PK_MetaDataDictionary] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[ExtendedData](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MetaDataDictionaryId] [int] NOT NULL,
	[RecordId][int] NOT NULL,
	[Value] [varchar](50) NULL,
	[Created] [DateTime] NULL,
	[Updated] [DateTime] NULL
 CONSTRAINT [PK_ExtendedData] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ExtendedData]  WITH CHECK ADD  CONSTRAINT [FK_ExtendedData_MetaDataDictionary] FOREIGN KEY([MetaDataDictionaryId])
REFERENCES [dbo].[MetaDataDictionary] ([Id])
GO

ALTER TABLE [dbo].[ExtendedData] CHECK CONSTRAINT [FK_ExtendedData_MetaDataDictionary]
GO

ALTER TABLE ExtendedData ADD CONSTRAINT DF_ExtendedDataCreateDate DEFAULT GETDATE() FOR Created
GO

CREATE TRIGGER tgr_ExtendedDataUpdate ON ExtendedData
FOR UPDATE AS
BEGIN
  UPDATE ExtendedData
  SET Updated = GETDATE()
  FROM ExtendedData e
  INNER JOIN INSERTED i ON e.Id = i.Id
END

---------- data populating

-- delete all data first

delete from ProductExtended
DBCC CHECKIDENT ('[ProductExtended]', RESEED, 0);

delete from MetaDataExtended
DBCC CHECKIDENT ('[MetaDataExtended]', RESEED, 0);

delete from productXml
DBCC CHECKIDENT ('[productXml]', RESEED, 0);

delete from ExtendedData
DBCC CHECKIDENT ('[ExtendedData]', RESEED, 0);

delete from MetaDataDictionary
DBCC CHECKIDENT ('[MetaDataDictionary]', RESEED, 0);

delete from store
DBCC CHECKIDENT ('[store]', RESEED, 0);

-- populate store data

insert into store (name) values ('ToysNStuff')
insert into store (name) values ('FoodBasket')
insert into store (name) values ('FurniturePlus')

---------------------------------------------------------------------------------
-- sample 1, fixed fields

insert into ProductExtended(Store,Name,price) values (1,'Doll',5.99)
insert into ProductExtended (Store,Name,price) values (1,'Tonka Truck',18.99)
insert into ProductExtended (Store,Name,price) values (1,'Nerf Gun',12.19)
insert into ProductExtended (Store,Name,price) values (2,'Bread',2.39)
insert into ProductExtended (Store,Name,price) values (1,'Cake Mix',4.59)
insert into ProductExtended (Store,Name,price) values (3,'Couch',235.97)
insert into ProductExtended (Store,Name,price) values (3,'Bed',340.99)
insert into ProductExtended (Store,Name,price) values (3,'Table',87.99)
insert into ProductExtended (Store,Name,price) values (3,'Chair',45.99)

insert into MetaDataExtended (TableName,FieldName,Label) values ('ProductExtended','Money1','SalePrice')
insert into MetaDataExtended (TableName,FieldName,Label) values ('ProductExtended','Bit1','SoldOut')
update ProductExtended set Money1=3.35 where id=1
update ProductExtended set Bit1=1 where id=2


---------------------------------------------------------------------------------
-- sample 2, xml

insert into productXml (Store,Name,price) values (1,'Doll',5.99)
insert into productXml (Store,Name,price) values (1,'Tonka Truck',18.99)
insert into productXml (Store,Name,price) values (1,'Nerf Gun',12.19)
insert into productXml (Store,Name,price) values (2,'Bread',2.39)
insert into productXml (Store,Name,price) values (1,'Cake Mix',4.59)
insert into productXml (Store,Name,price) values (3,'Couch',235.97)
insert into productXml (Store,Name,price) values (3,'Bed',340.99)
insert into productXml (Store,Name,price) values (3,'Table',87.99)
insert into productXml (Store,Name,price) values (3,'Chair',45.99)

-- sample xml select query
SELECT
	Extended.value('(/ExtendedXml/SalePrice)[1]', 'nvarchar(max)') as 'SalePrice',
	Extended.value('(/ExtendedXml/OutOfStock)[1]', 'nvarchar(max)') as 'OutOfStock', 
	Extended.value('(/ExtendedXml/ExtendedData/Key)[1]', 'nvarchar(max)') as 'Key',
	Extended.value('(/ExtendedXml/ExtendedData/Value)[1]', 'nvarchar(max)') as 'Value'
FROM 
	ProductXml


---------------------------------------------------------------------------------
-- sample 3, extended data table

insert into MetaDataDictionary (TableName,Label,DataType) values ('Product','SalePrice','float')
insert into MetaDataDictionary (TableName,Label,DataType) values ('Product','SoldOut','bit')
insert into MetaDataDictionary (TableName,Label,DataType) values ('Store','WeekdayOpenTime','DateTime')
insert into MetaDataDictionary (TableName,Label,DataType) values ('Store','WeekdayClosedTime','DateTime')

insert into ExtendedData (MetaDataDictionaryId,recordid,value) values (1,1,'3.35')
insert into ExtendedData (MetaDataDictionaryId,recordid,value) values (1,2,'12.34')
insert into ExtendedData (MetaDataDictionaryId,recordid,value) values (2,2,'0')
update ExtendedData set value='1' where id=3

-- sample extended table select queries
SELECT 
	p.*,m.label,e.Value
FROM 
	Product p,
	MetaDataDictionary m,
	ExtendedData e
WHERE
	m.TableName='Product' AND
	e.MetaDataDictionaryId = m.Id AND
	e.RecordId = p.Id

SELECT
	p.*,
	(SELECT e.value FROM ExtendedData e WHERE e.RecordId = p.Id AND e.MetaDataDictionaryId=1) AS 'SalePrice',
	(SELECT e.value FROM ExtendedData e WHERE e.RecordId = p.Id AND e.MetaDataDictionaryId=2) AS 'SoldOut'
FROM	
	Product p


