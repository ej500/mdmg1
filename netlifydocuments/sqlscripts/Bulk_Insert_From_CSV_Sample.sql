
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE Sample_Bulk_Insert_From_CSV 
	
AS
BEGIN

	SET NOCOUNT ON;

	/*****  Bulk insert  sample  -----
   create file first in folder   C:\Temp\\Temp2\201906\    DL2.csv----
   open excel and save as CSV UTF8 name it DL2.csv
   Add the follwing  
   in excel  

	AAA	BBB	
	TTT	QQQ
	DFD	SSDSF
	SDSDS SDSD
	
	-- save the file C:\Temp\\Temp2\201906\DL22.csv 
	
	*****/

--  DROP TABLE #DL2
  Create Table  #DL2 (AAA VARCHAR(200), BBB VARCHAR (200))

 BULK INSERT #DL2 
 FROM 
 "C:\Temp\\Temp2\201906\DL2.csv" 
 WITH( 
 FIRSTROW=1 
,FIELDTERMINATOR = ';' 
,ROWTERMINATOR  = '0x0a' 
 ); 

select * from #DL2


-------------- Dynamic Bulk insert Sample ---
--//***** Create file named dl2.csv  in C:\Temp\Temp2\201906\ folder   be aware can' use temp tabel in dynamic sql **//

 ---drop table DL2 
 DECLARE @sqlb varchar(500) 
 DECLARE @folderb varchar (500) 
 set @folderb ='201906' 


set @sqlb = N'select * from folder where foldername ='+ @folderb +'' 
Declare @folder11b NVARCHAR(250)='C:\Temp\\Temp2\'+@folderb+'\' -----Select file to manipulate from this folder 

 declare @sql1 varchar (max) 
 Declare @filename1 varchar (250) ='DL2.csv' 
 set @sql1 =N'CREATE TABLE DL2 
(
AAA VARCHAR(200)
,BBB VARCHAR (200)
) 
 BULK INSERT DL2  
 FROM 
 "' +@folder11b+@filename1+'" 
 WITH( 
 FIRSTROW=2 
,FIELDTERMINATOR = '';'' 
,ROWTERMINATOR  = ''0x0a'' 
 ); 
 '
--PRINT (@sql1) 
 EXEC(@sql1) 


END
GO
