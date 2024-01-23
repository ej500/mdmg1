USE [DNN]
GO
/****** Object:  StoredProcedure [dbo].[aExcelimport]    Script Date: 19.03.2022 17:21:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[aExcelimport] AS
BEGIN
	
	SET NOCOUNT ON;

------------run this script first 
Use master
GO
EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO
EXEC sp_configure 'ad hoc distributed queries', 1
RECONFIGURE
GO


EXEC master . dbo. sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0' , N'AllowInProcess' , 1
GO

EXEC master . dbo. sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0' , N'DynamicParameters' , 1
GO

------------------run this aftewords


--SELECT * INTO  finaloutput2
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\temp\FinalOutPut.xls','SELECT * FROM [Sheet1$]')
---WHERE ISIN IS NOT NULL

--SELECT * INTO  CompanyPB1
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\temp\FinalOutPut.xls','SELECT * FROM [Sheet1$]')
--WHERE ID1NR IS NOT NULL

--SELECT * INTO  CompanyPB11
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\temp\FinalOutPut.xls','SELECT * FROM [Sheet1$]')
--WHERE ID1NR IS NOT NULL

--SELECT * INTO  CompanyPB111
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Import\CompanyPB1Adress.xls','SELECT * FROM [Sheet1$]')
--WHERE ID1NR IS NOT NULL

--SELECT * INTO  CompanyPB111
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Import\CompanyPB1Adress.xls','SELECT * FROM [Sheet1$]')
--WHERE ID1NR IS NOT NULL

--SELECT * INTO  T1
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Import\T1.xlsx','SELECT * FROM [Sheet1$]')
--WHERE ID1NR IS NOT NULL


--SELECT CustomerID, CompanyName
--   FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0',
--      'C:\Program Files\Microsoft Office\OFFICE11\SAMPLES\Northwind.mdb';
--      'admin';'',Customers);
--GO


--SELECT *
--   FROM OPENROWSET('Microsoft.Jet.OLEDB.4.0',
--      'C:\Import\CompanyPB1Adress.xls';'';

--GO



--Provider=Microsoft.ACE.OLEDB.12.0;Data Source=C:\myFolder\myAccessFile.accdb;
--Jet OLEDB:Database Password=MyDbPassword;

--Provider=Microsoft.ACE.OLEDB.12.0;Data Source=|DataDirectory|\myAccessFile.mdb;
--Persist Security Info=False;



--SELECT * FROM CompanyPB1

-----remeber to close excel first 
-----Use Scraper
--SELECT * INTO converted1 
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Administrator\Documents\Converted3.xls','SELECT * FROM [Sheet1$]')
--WHERE ISIN IS NOT NULL


END
