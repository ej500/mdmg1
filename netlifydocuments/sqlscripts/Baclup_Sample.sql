


declare @Backup1 int; 
set @Backup1=(select max (FOLDERNAME) from FOLDER) 
DECLARE @d CHAR(10) = CONVERT(CHAR(8), GETDATE(), 112); 
declare @sqlBackup1 varchar(max) 
set @sqlBackup1= N' 
drop table if exists DL_Report_Aggregate5'+cast(@Backup1 as varchar (50)) +'_'+@d+' 
select * into DL_Report_Aggregate_5_'+cast(@Backup1  as varchar (50))+'_'+@d+'from DL_Report_Aggregate_5 
'
exec(@sqlBackup1) 
PRINT    @sqlBackup1 