USE [DmArea]
GO
/****** Object:  StoredProcedure [dbo].[aExcelimport]    Script Date: 19.03.2022 20:56:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER  PROCEDURE [dbo].[aExcelimport] 
	
AS
BEGIN
		SET NOCOUNT ON;


------------run this script first 
--Use master
--GO
--EXEC sp_configure 'show advanced options', 1
--RECONFIGURE
--GO
--EXEC sp_configure 'ad hoc distributed queries', 1
--RECONFIGURE
--GO

--EXEC master . dbo. sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0' , N'AllowInProcess' , 1
--GO

--EXEC master . dbo. sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0' , N'DynamicParameters' , 1
--GO

------------------run this aftewords

USE master;  
GO  
EXEC sp_configure 'show advanced option'

USE master;  
GO  
EXEC sp_configure 'show advanced option', '1';  
RECONFIGURE WITH OVERRIDE;   

EXEC sp_configure 'xp_cmdshell', 1;  
GO  
RECONFIGURE;

xp_cmdshell 'copy c:\temp\temp2 c:\temp\temp3';  

xp_cmdshell 'dir "c:\images" /s/b>c:\sql\path.txt';  

xp_cmdshell 'dir "c:\images" /s/b>\temp\temp3\path.txt';  

----- BCP bulkimport from CSV 
use ExportToExcel
create table images(path varchar(80))
xp_cmdshell 'bcp ExportToExcel.dbo.images IN c:\temp\temp3\path.txt -c -T'
select * from ExportToExcel.dbo.images

---ok copy from folder
xp_cmdshell 'powershell -command "copy-item "c:\temp\temp3" -Destination "c:\temp\temp2" -Recurse'



---The next example is to run a PowerShell script using xp_cmdshell. First, we will create a script named script.ps1 with the following content:

---File_name: script.ps1
copy-item "C:\sql\source" -Destination "C:\sql\destination" –Recurse

---To call a PowerShell script in xp_cmdshell, use the following sentences:

xp_cmdshell 'powershell -command "C:\\Temp\\Temp2\\scriptsql.ps1"'
xp_cmdshell and SQL Server PowerShell


---SQL PowerShell (SQLPS).
 ---The following example will show how to show database information in an html file using xp_cmdshell. The following example shows how to do it.



xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\/FinalOutputCSVV.csv | select -Skip 2 Set-Content C:\Temp\Temp\202001\DL_Report3.csv"' 

use ExportToExcel
insert into test4
xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\FinalOutputCSVV.csv"'


---Fails 
--xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\FinalOutputCSVV.csv | select Skip 2 Set-Content C:\Temp\Temp2\Output1.csv"'

---Get-Content C:\Temp\FinalOutputCSVV.csv | select -Skip 1 Set-Content C:\Temp\Temp2\Output.csv 

--- Testet Ok  
xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\FinalOutputCSVV.csv | Set-Content C:\Temp\Temp2\Output.csv"'




Get-Content C:\Temp\FinalOutputCSVV.csv" | Set-Content C:\Temp\Temp2\Output.csv


use ExportToExcel



SELECT * INTO  CompanyPB1
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\CompanyPB1Adress.xls','SELECT * FROM [Sheet1$]')
WHERE ID1NR IS NOT NULL

--SELECT * INTO  CompanyPB11
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;HDR=YES;Database=C:\Import\CompanyPB1Adress.xls','SELECT * FROM [Sheet1$]')
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










