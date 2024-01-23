
select @@servername
select DB_nAME()

EXEC sp_configure 'Ad Hoc Distributed Queries', 1; --To enable to execute OPENROWSET. 
RECONFIGURE; 


SELECT yyyymm, Invoice_URL FROM DL_Report where YYYYMM>201903 AND YYYYMM <201910 

select CONVERT(CHAR(8), GETDATE(), 112)

declare @Backup1 int; 
set @Backup1=(select max (YYYYMM) from DL_Report_Aggregate_5) 
DECLARE @d CHAR(10) = CONVERT(CHAR(8), GETDATE(), 112); 
declare @sqlBackup1 varchar(max) 
set @sqlBackup1= N' 
drop table if exists DL_Report_Aggregate5'+cast(@Backup1 as varchar (50)) +'_'+@d+' 
select * into DL_Report_Aggregate_5_'+cast(@Backup1  as varchar (50))+'_'+@d+'from DL_Report_Aggregate_5 
'
--exec(@sqlBackup1) 
PRINT    @sqlBackup1 

---drop table if exists folder 
--DROP table folder

create table folder 
(id int , foldername varchar (100), Insert_Folder varchar (50),Product varchar(50), End_Date VARCHAR (50)) 

insert into folder ( id,foldername,Insert_Folder, Product,End_Date) 
values 
(1,'201906','Inserted','Per Security',' 201905') 
,(2,'201907','Inserted','Per Security','201906') 
,(3,'201908','Inserted','Per Security','201907') 
,(4,'201909','Inserted','Per Security','201908') 
,(5,'201910','Inserted','Per Security','201909') 
,(6,'201911','Inserted','Per Security','201910') 
,(7,'201912','Inserted','Per Security','201911') 
,(8,'202001','Inserted','Per Security','201912') 
,(9,'202002','Inserted','Per Security','202001') 
,(10,'202003','Inserted','Per Security','202002') 
,(11,'202004','Inserted','Per Security','202003') 
,(12,'202005','Inserted','Per Security','202004') 
,(13,'202006','Inserted','Per Security','202005') 
,(14,'202007','Inserted','Per Security','202006') 
,(15,'202008','Inserted','Per Security','202007') 
,(16,'202009','Inserted','Per Security','202008') 
,(17,'202010','Inserted','Per Security','202009') 
,(18,'202011','Inserted','Per Security','202010') 
,(19,'202012','Inserted','Per Security','202011') 
,(21,'202101','y','Per Security','202012') 
--,(22,'20210','y','Per Security','202012') 
--,(23,'202101','Not Available','Per Security','20201) 

---SELECT * FROM folder  
--select MAX (YYYYMM) from DL_Report 
--select * from DL_Report where YYYYMM LIKE '202010' 

 DECLARE @Content1 as varchar(100); 
 DECLARE @Content1B as VARCHAR (500); 
---DECLARE @Content1C as datetime; 
 DECLARE @CCursor as CURSOR; 
 SET @CCursor = CURSOR FOR 
 SELECT ID, foldername from folder where Insert_Folder ='Y'; 
 OPEN @CCursor; 
 FETCH NEXT FROM @CCursor INTO @Contentl,@Content1B; 

 WHILE @@FETCH_STATUS  = 0 
 BEGIN 

 DECLARE @sql varchar(500) 
 DECLARE @folder varchar (500) 
 set @folder =@Content1b 
--   set @folder ='201906' 


---SELECT * FROM FOLDER 

set @sql = N'select * from folder where foldername ='+ @folder +'' 
Declare @folder11 NVARCHAR(250)='C:\Temp\\Temp2\'+@folder+'\' -----Select file to manipulate from this folder 
 --Declare @folder11 NVARCHAR(250)='C:\Common\\VerificationRP\\Invoices\'+@folder+'\' 

 --print @folder11
 
 Declare @filename11 NVARCHAR(MAX)='DL_Report.csv' 
 Declare @cmd11a varchar (max)= 
'xp_cmdshell "powershell.exe -noprofile -command "Get-Content -Path '+@folder11+@filename11 + 
'| Select-String "Line#*"| SelecT-Object -ExpandProperty "LineNumber" | Out-File '+@Folder11+'SkipUntil.txt'''; 
 --EXEC (@cmd11a) 
 print @cmd11a

--  the print  from the above Get Content and output Output to other file  
xp_cmdshell 'powershell.exe -noprofile -command "Get-Content -Path C:\Temp\\Temp2\201906\DL_Report.csv| Select-String "Line#*"| SelecT-Object -ExpandProperty "LineNumber" | Out-File C:\Temp\\Temp2\201906\SkipUntil.txt'
----------

---- Replace not wanted chars 
--xp_cmdshell 'powershell.exe -noprofile -command "(Get-Content C:\Temp\Temp\202001/DL_Report.csv -Raw) -replace ".000", 
 --""-replace "%","" -replace "=","" |Out-File C:\Temp\Temp\202001\L_Report.csv" 

 Declare @filename12 NVARCHAR(MAX)='DL_Report.csv' 
 Declare @cmd12a varchar (max)= 
'xp_cmdshell "powershell.exe -noprofile -command "(Get-Content -Path '+@folder11+@filename12 + 
' -Raw) -replace "".000"","""" -replace ""%"", """"-replace ""="","""" |Out-File '+@Folder11+'DL_Report1.CSV'''; 
EXEC (@cmd12a) 

-------Delete rows containing based on similar to the like syntax in  sql something may be wrong with this one --------------- 
--xp_cmdshell 'powershell.exe -noprofile -command "Select-String 
----"Market Volatility*" , "Sub-Total Current Model:*" "C:\Temp\Temp\202001\DL_Report1.csv" -notmatch 
----|%{$_.Line}|set-content "C:\Temp\Temp\202001\DL_Report2.csv"' 

 Declare @filename13 NVARCHAR(MAX)='DL_Report1.csv' 
 Declare @cmd13a varchar (max)= 
'xp_cmdshell "powershell.exe -noprofile -command "Select-String ""Market Volatility*"", ""Sub-Total Current Model:*"" ""' + 
@folder11+@filename13 +'''''-notmatch | % {$_.Line} | set-content'+@Folder11+'DL_Report2.CSV"'; 
 EXEC (@cmd13a) 

 -----------, ""Line*"" 

----Delete the x first lines in the file 
--xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\Temp\Temp\202001/DL_Report2.csv | select -Skip 2 |Set-Content C:\Temp\Temp\202001\DL_Report3.csv"' 

 declare @sq15 varchar (max) 
 Declare @filename15 varchar(250) ='SkipUntil.txt' 
 set @sq15 =N' 
 drop table if exists DL_ReportSkipUntil_Nr 
 CREATE TABLE DL_ReportSkipUntil_Nr 
(skip_first int) 
 BULK INSERT DL_ReportSkipUntil_Nr 
 FROM 
 '''+@folder11+@filename15+ ''''+' 
 WITH( 
 FIRSTROW=1 
,FIELDTERMINATOR = "," 
,ROWTERMINATOR  = "0x0a" 
);
'
--PRINT (@sql1) 
 EXEC(@sq15) 


 Declare @filename16c NVARCHAR(MAX)='DL_Report2.csv' 
 Declare @cmd15c varchar (max)= 
'xp_cmdshell "powershell.exe -noprofile -command "(gc'+@folder11+@filename16c +')"'; 
 EXEC (@cmd15c) 

 Declare @filename16 NVARCHAR(MAX)='DL_Report2.csv' 
 Declare @cmd16a varchar (max)= 
'xp_cmdshe "powershell.exe -noprofile -command "(gc '+@folder11+@filename16 +')|? {-not[String]::IsNullOrWhiteSpace($_)}|set-content'+ 
@Folder11+'DL_Report4.csv"'; 
 EXEC (@cmd16a) 


---xp_cmdshell 'powershell.exe -noprofile -command "Get-Content C:\TempTemp202001/DL_Report4.csv" 


 drop table if exists DL_Report0 

--declare @folder1 varchar (max) = 
 
 ----- Bulk insert     --- create file first---- 

 declare @sql1 varchar (max) 
 Declare @filename1 varchar (250) ='DL_Report4.csv' 
 set @sql1 =N'CREATE TABLE DL_Report0 
([Line] [nvarchar)(50) NOT NULL,[Quantity] [nvarchar)(50) NOT NULL,[Description] [nvarcha(300) NOT NULL,[Data_Category] [nvarchar)(50) NOT NULL, 
[Asset Type] [nvarchar)(50) NULL,[FeeType] [nvarchar)(50) NOT NULL,[RequestType] [nvarchar](50) NOT NULL,[Variable] [nvarchar](max) NULL, 
[Start_Date] [varchar)(250) NULL,[End_Date] [nvarchar)(50) NOT NULL,[List_Price] varchar (MAX) NULL,[Amount] VARCHAR (MAX) NULL,[Pre_Optimization Total_Amount] 
[float] NULL,[Optimization_Factor] varchar(250) NULL ,[Optimization_Discount_Amount] [float] NULL,[Net_Amount][float] NULL) 
 BULK INSERT DL_Report0 
 FROM 
 "' +@folder11+@filename1+''' 
 WITH( 
 FIRSTROW=2 
,FIELDTERMINATOR = "," 
,ROWTERMINATOR  = "0x0a" 
 ); 
 '
--PRINT (@sql 
 EXEC(@sql1) 

 END



 --select * from dl_Report0 where start_date like '11/01/2020' 
 --DELETE FROM dl_Report0 where line like 'Invoice%' 
 --DELETE FROM dl_Report0 WHERE Description like '%Derivative Data & Analytics%' and Net_Amount = 0 

 

 --drop table if exists [dbo].[DL_Report] 
CREATE TABLE [dbo].[DL_Report]
		 ([id] [int] NULL,[Line##] [varchar](50) NULL,[Quantity] [int] NULL,[Description] [varchar](300) NULL, 
        [Data Category] [varchar](50) NULL,[Asset Type] [varchar](50) NULL,[Feetype] [varchar](50) NULL,[Request Type] [varchar](50) NULL, 
        [Variable] [varchar](50) NULL,[Start Date] [date] NULL,[End Date] [date] NULL,[List Price] [float] NULL, [Amount] [float] NULL, 
        [Pre-Optimization Total Amount] [float] NULL,[Optimization Factor] [varchar](50) NULL,[Optimization Discount Amount] [varchar](50) NULL, 
        [Net Amount] [float] NULL,[PTIMIZATION_FACTOR_E] [varchar](50) NULL,[YEAR_E] [varchar](50) NULL,[MONTH_E] [varchar](50) NULL, 
        [DAY_E] [varchar](50) NULL,[DAY_LAST_E] [varchar](50) NULL,[YYYYMM] [varchar](50) NULL, 
        Business_Day_Month int,Qty_Unique int,Qty_Unique_Prev int, Qty_Unique_3M int,Qty_Unique_6M int,Qty_Unique_12M int, 
        Qty_D int,Qty_D_Prev int, Qty_D_3M int,Qty_D_6M int,Qty_D_12M int, 
        [USD_Amount_Prev] [float] NULL,[Amount_3M] [float] NULL,[Amount_6M] [float] NULL,[Amount_12M] [float] NULL, 
        [Qty_Prev] [int] NULL, [Qty_3M] [int] NULL,  [Qty_6M] [int] NULL, [Qty_12M] [int] NULL, 
        [Start Date_Prev] [date] NULL,[Start Date_3M] [date] NULL,[Start Date_6M] [date] NULL,[Start Date_12M] [date] NULL, 
 Qty_Unique_Inv int,Qty_Access int,Qty_Access_Bulk int,Qty_Access_D int,Qty_Access_Bulk_D int,Qty_Maintained int, 
 Description_2 varchar (300),Assetpe varchar(300), DL2 varchar (300), Invoice_URL VARCHAR (800) , [End Date_Next] date, 
 YYYYMM_Next_Month varchar (50) , 
---NOK_Amount float ,NOK_Amount_Prev float,Nok_Amount_3M float , Nok_Amount_6M FLOAT ,Nok_Amount_12M FLOAT, 
 NOK_Amount_Inc_Tax  float ,NOK_Amount_Prev_Inc_Tax float,Nok_Amount_3M_Inc_Tax float , Nok_Amount_6M_Inc_Tax FLOAT ,Nok_Amount_12M_Inc_Tax FLOAT 
 )
        ON [PRIMARY] 

		select * from DL_Report

truncate table [dbo].[DL_Report] 






