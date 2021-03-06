/****** Object:  Table [dbo].[Documents]    Script Date: 03/08/2011 15:09:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Documents]') AND type in (N'U'))
DROP TABLE [dbo].[Documents]
GO
/****** Object:  XmlSchemaCollection [dbo].[LinqToSqlXmlCollection]    Script Date: 03/08/2011 15:09:41 ******/
IF  EXISTS (SELECT * FROM sys.xml_schema_collections c, sys.schemas s WHERE c.schema_id = s.schema_id AND (quotename(s.name) + '.' + quotename(c.name)) = N'[dbo].[LinqToSqlXmlCollection]')
DROP XML SCHEMA COLLECTION  [dbo].[LinqToSqlXmlCollection]
GO
/****** Object:  XmlSchemaCollection [dbo].[DocumentCollection]    Script Date: 03/08/2011 15:09:41 ******/
IF  EXISTS (SELECT * FROM sys.xml_schema_collections c, sys.schemas s WHERE c.schema_id = s.schema_id AND (quotename(s.name) + '.' + quotename(c.name)) = N'[dbo].[DocumentCollection]')
DROP XML SCHEMA COLLECTION  [dbo].[DocumentCollection]
GO
/****** Object:  XmlSchemaCollection [dbo].[DocumentCollection]    Script Date: 03/08/2011 15:09:41 ******/
IF NOT EXISTS (SELECT * FROM sys.xml_schema_collections c, sys.schemas s WHERE c.schema_id = s.schema_id AND (quotename(s.name) + '.' + quotename(c.name)) = N'[dbo].[DocumentCollection]')
CREATE XML SCHEMA COLLECTION [dbo].[DocumentCollection] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="urn:LinqToSqlXml" targetNamespace="urn:LinqToSqlXml"><xsd:element name="arr"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:choice minOccurs="0" maxOccurs="unbounded"><xsd:element ref="t:int" /><xsd:element ref="t:dec" /><xsd:element ref="t:bool" /><xsd:element ref="t:dt" /><xsd:element ref="t:ts" /><xsd:element ref="t:bin" /><xsd:element ref="t:str" /><xsd:element ref="t:arr" /><xsd:element ref="t:obj" /></xsd:choice></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="bin" type="xsd:base64Binary" /><xsd:element name="bool" type="xsd:boolean" /><xsd:element name="dec" type="xsd:decimal" /><xsd:element name="dt" type="xsd:dateTime" /><xsd:element name="int" type="xsd:integer" /><xsd:element name="obj"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any processContents="lax" maxOccurs="unbounded" /></xsd:sequence></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="str" type="xsd:string" /><xsd:element name="ts" type="xsd:duration" /></xsd:schema>'
GO
/****** Object:  XmlSchemaCollection [dbo].[LinqToSqlXmlCollection]    Script Date: 03/08/2011 15:09:41 ******/
IF NOT EXISTS (SELECT * FROM sys.xml_schema_collections c, sys.schemas s WHERE c.schema_id = s.schema_id AND (quotename(s.name) + '.' + quotename(c.name)) = N'[dbo].[LinqToSqlXmlCollection]')
CREATE XML SCHEMA COLLECTION [dbo].[LinqToSqlXmlCollection] AS N'<xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:t="urn:LinqToSqlXml" targetNamespace="urn:LinqToSqlXml"><xsd:attribute name="type" type="xsd:string" /><xsd:element name="bool" type="xsd:boolean" /><xsd:element name="dec" type="xsd:decimal" /><xsd:element name="document"><xsd:complexType mixed="true"><xsd:complexContent mixed="true"><xsd:restriction base="xsd:anyType"><xsd:sequence><xsd:any processContents="lax" maxOccurs="unbounded" /></xsd:sequence><xsd:attribute ref="t:type" /></xsd:restriction></xsd:complexContent></xsd:complexType></xsd:element><xsd:element name="dt" type="xsd:dateTime" /><xsd:element name="int" type="xsd:integer" /><xsd:element name="str" type="xsd:string" /></xsd:schema>'
GO
/****** Object:  Table [dbo].[Documents]    Script Date: 03/08/2011 15:09:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Documents]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Documents](
	[Id] [uniqueidentifier] NOT NULL,
	[DbName] [nvarchar](50) COLLATE Finnish_Swedish_CI_AS NOT NULL,
	[CollectionName] [nvarchar](50) COLLATE Finnish_Swedish_CI_AS NOT NULL,
	[XmlIndex] [xml](CONTENT [dbo].[LinqToSqlXmlCollection]) NOT NULL,
	[JsonData] [varchar](max) COLLATE Finnish_Swedish_CI_AS NOT NULL,
 CONSTRAINT [PK_Documents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Documents]') AND name = N'IX_Documents')
CREATE NONCLUSTERED INDEX [IX_Documents] ON [dbo].[Documents] 
(
	[CollectionName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Documents]') AND name = N'Primary')
CREATE PRIMARY XML INDEX [Primary] ON [dbo].[Documents] 
(
	[XmlIndex]
)WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Documents]') AND name = N'XML_IX_Documents')
CREATE XML INDEX [XML_IX_Documents] ON [dbo].[Documents] 
(
	[XmlIndex]
)
USING XML INDEX [Primary] FOR VALUE WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Documents]') AND name = N'XML_IX_Documents_1')
CREATE XML INDEX [XML_IX_Documents_1] ON [dbo].[Documents] 
(
	[XmlIndex]
)
USING XML INDEX [Primary] FOR PATH WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Documents]') AND name = N'XML_IX_Documents_2')
CREATE XML INDEX [XML_IX_Documents_2] ON [dbo].[Documents] 
(
	[XmlIndex]
)
USING XML INDEX [Primary] FOR PROPERTY WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON)
GO
