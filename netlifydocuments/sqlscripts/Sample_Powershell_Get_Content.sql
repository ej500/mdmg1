USE [ExportToExcel]
GO
/****** Object:  StoredProcedure [dbo].[Sample_Bulk_Insert_From_CSV]    Script Date: 20.03.2022 16:55:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[Sample_Powershell_Get_Content] 
	
AS
BEGIN

	SET NOCOUNT ON;

---	USE master;  
--GO  
--EXEC sp_configure 'show advanced option'

--USE master;  
--GO  
--EXEC sp_configure 'show advanced option', '1';  
--RECONFIGURE WITH OVERRIDE;   

--EXEC sp_configure 'xp_cmdshell', 1;  
--GO  
--RECONFIGURE;

--xp_cmdshell 'copy c:\temp\temp2 c:\temp\temp3'  

--xp_cmdshell 'dir "c:\images" /s/b>c:\sql\path.txt';  

--xp_cmdshell 'dir "c:\images" /s/b>\temp\temp3\path.txt';  

----- BCP bulkimport from CSV 


--create table images(path varchar(80))
--xp_cmdshell 'bcp ExportToExcel.dbo.images IN c:\temp\temp3\path.txt -c -T'
--select * from ExportToExcel.dbo.images

---ok copy all content in folder from folder
--xp_cmdshell 'powershell -command "copy-item "c:\temp\temp4" -Destination "c:\temp\temp5" -Recurse'


---The next example is to run a PowerShell script using xp_cmdshell. First, we will create a script named script.ps1 with the following content:

---File_name: script.ps1

---To call a PowerShell script in xp_cmdshell, use the following sentences:

--xp_cmdshell 'powershell -command "C:\\Temp\\Temp2\\scriptsql.ps1"'
--xp_cmdshell and SQL Server PowerShell


---SQL PowerShell (SQLPS).
 
 ---- Ok 
--xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\FinalOutputCSVV.csv"'
--xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\/FinalOutputCSVV.csv  | select -Skip 1 | Set-Content C:\Temp\Temp4\DL_Report3.csv"' 
--xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\/FinalOutputCSVV.csv | select -Skip 1| Set-Content C:\Temp\Temp2\Output21.csv"'
--xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\FinalOutputCSVV.csv | Set-Content C:\Temp\Temp2\Output.csv"'
-------ok----- 



END
