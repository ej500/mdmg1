USE [Adhoc]
GO
/****** Object:  StoredProcedure [dbo].[AcceleratorFileImport]    Script Date: 2/12/2015 8:41:04 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================



Alter PROCEDURE [dbo].[Adhoc1]
--exec AcceleratorFileImport
AS
BEGIN

	SET NOCOUNT ON;
--exec master..xp_cmdshell 'C:\Websites\Accelerator\PSAcceleratorsys32.bat'

begin try 
drop table Adhoc
end try 
begin catch
end catch     

--- --If every thing goes into one column you have to make the first row with headers in excel first into adhocv1 copy and paste or delete with stringmanipulation
 
--Step 1 
select * into AdhocHeader
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Egil\Documents\AdhocHeader.xls','SELECT * FROM [Adhoc$]')

--This is an example on how to write out table coulmn name from table heading and print it to  txt,csv or sql script to create a table 
--- It also include example on how to print out and execute the script from sql   

--Step 2
---------- Create table AdhocStateMent (Query1 nvarchar (max))... you may have to include total path name in script as the script will be executed thorugha bat or powershell command  
---Alter table AdhocStateMent add c1 nvarchar (max),c2 nvarchar (max), c3 nvarchar (max), c4 nvarchar (max), c5 nvarchar (max), c nvarchar (max) 
--drop table AdhocEdit

truncate table AdhocStatement 
insert into AdhocStatement(Query1) SELECT name FROM syscolumns WHERE id=OBJECT_ID('Adhoc') 
update AdhocStatement  set c1 = Query1
update AdhocStatement  set c2 = 'Create Table Adhoc.dbo.AdhocEdit ( ID INT IDENTITY  (1,1) PRIMARY KEY , '
update AdhocStatement SET C1 =(C2 + REPLACE(C1,',',' Nvarchar (MAX),'))+' '+'Nvarchar (MAX))'
select c1 from AdhocStatement
             ---
             ---- You can print it to a sql scrip and prgramatically execute it. PS you need to do it as a funtion since it include a parameter
            declare @AdhocStatement varchar(8000)
            SELECT @AdhocStatement = 'bcp "select Query1 from [Adhoc].[dbo].[AdhocStatement] " queryout C:\Users\Egil\Documents\AdhocStatement.sql -c -t, -T -S W7nC'
            exec master..xp_cmdshell @AdhocStatement
            exec master..xp_cmdshell 'C:\Users\Egil\Documents\AdhocStatement.sql'

--Step 3 

---some examples 
     --- without parameter
          update AdhocStatement set Query1 = 'update adhoc.dbo.adhocheader set query  = select * from adhoc.dbo.adhoc;' 
     ---With Parameter
          update AdhocStatement set Query1 = 'update adhoc.dbo.adhocheader set query  = c.'+ Query1 + ' from adhoc.dbo.adhocheader;'  
--- Than you can print the script and save it as sql before you execute it.

----Try them succesivt


--select * into Adhoc
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Egil\Documents\Adhoc.xls','SELECT * FROM [Adhoc$]')

--select * into Adhoc
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Egil\Documents\Adhoc.xls','SELECT * FROM [Adhoc$]')


--select * into Adhoc
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Egil\Documents\Adhoc.xls','SELECT * FROM [Adhoc]')


--select * into Adhoc
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Egil\Documents\Adhoc.xlsx','SELECT * FROM [Adhoc$]')

--select * into Adhoc
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Egil\Documents\Adhoc.xlsx','SELECT * FROM [Adhoc]')

--select * into Adhoc
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Users\Egil\Documents\Adhoc.csv','SELECT * FROM [Adhoc$]')


----------------------------------------------------------------------   Bulk import-------
--exec master..xp_cmdshell 'C:\RizklabImport\OutwitOutput\Lse\adhoc.bat'

--begin try 
--drop table AdhocEdit
--end try 
--begin catch
--end catch 
--C:\Users\Egil\Documents\
--select * into Adhocedit from openrowset(Bulk N'C:\\Users\\Egil\\Documents\\adhoc.html',Single_clob) as Contents
--update Adhocedit set Bulkcolumn = REPLACE(Bulkcolumn,dbo.udf_GetStringBetween2Strings (BulkColumn, 'Retail Bonds', 'Long Name'),'') 
--update Adhocedit set Bulkcolumn = REPLACE(Bulkcolumn,'Retail Bonds','')
--select * from Adhocedit 

declare @Adhoc varchar(8000)
set @Adhoc = 'bcp "select Bulkcolumn from [Adhoc].[dbo].[adhoc] " queryout C:\Users\Egil\Documents\Adhoc.txt -c -t, -T -S W7nC'
exec master..xp_cmdshell @Adhoc

--truncate table Adhocv15v1  
--Bulk insert Adhocv1 from  'C:\\RizklabImport\\OutwitOutput\\Lse\\Lse175.txt' 
--with 
--(
--FIELDTERMINATOR = ',',
--ROWTERMINATOR = '\n'
--)

--select * into Adhoc from adhocv1


--begin try 
--insert into Adhoc
--([LONG NAME],ISIN ,TIDM ,SEDOL ,[ISSUE DATE] ,[MATURITY DATE] ,[COUPON VALUE] ,[COUPON TYPE] ,SEGMENT ,SECTOR ,
--[CODE CONVENTION CALCULATE ACCRUAL] ,[MINIMUM DENOMINATION],[DENOMINATION CURRENCY],[TRADING CURRENCY] ,[TYPE] ,[FLAT YIELD] ,[PAYMENT COUPON DATE],[PERIOD OF COUPON],[EX COUPON DATE],[DATE OF INDEX INFLATION]
--,[UNIT OF QUOTATION])

--select 
--[LONG NAME],ISIN ,TIDM ,SEDOL ,[ISSUE DATE] ,[MATURITY DATE] ,[COUPON VALUE] ,[COUPON TYPE] ,SEGMENT ,SECTOR ,
--[CODE CONVENTION CALCULATE ACCRUAL] ,[MINIMUM DENOMINATION],[DENOMINATION CURRENCY],[TRADING CURRENCY] ,[TYPE] ,[FLAT YIELD] ,[PAYMENT COUPON DATE],[PERIOD OF COUPON],[EX COUPON DATE],[DATE OF INDEX INFLATION]
--,[UNIT OF QUOTATION] from Adhocv1 where [LONG NAME] not like '%LONG NAME%' and ISIN not in (select isin from Lse175v2)

--truncate table Adhocv1 
--end try 
--begin catch
--end catch 






--begin try 
--INSERT INTO ACCELERATORfILES (EditLink,SubmissionID,DocumentName,Url,UniqeID) SELECT EditLink,SubmissionID,DocumentName,Url,UniqeID
-- FROM AcceleratorFilesedit
-- end try 
-- begin catch
-- end catch

--;WITH CTE (SubmissionID, DuplicateCount)
--AS
--(
--SELECT SubmissionID,
--ROW_NUMBER() OVER(PARTITION BY SubmissionID ORDER BY SubmissionID) AS DuplicateCount
--FROM ACCELERATORfILES
--)
--DELETE
--FROM CTE
--WHERE DuplicateCount > 1

----SELECT * FROM DOCUMENT4
--Insert into Document4 (DocumentName,DocumentURL,[EditUrl],UniqeID) select DocumentName,Url,[EDITLINK],UniqeID from AcceleratorFiles 

--;WITH CTE (URL, DuplicateCount)
--AS
--(
--SELECT DocumentURL,
--ROW_NUMBER() OVER(PARTITION BY DocumentURL ORDER BY DocumentURL) AS DuplicateCount
--FROM Document4
--)
--DELETE
--FROM CTE
--WHERE DuplicateCount > 1

END
