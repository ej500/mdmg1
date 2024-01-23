USE [Acc1]
GO

/****** Object:  Table [dbo].[Document4]    Script Date: 2/15/2015 9:10:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--DROP TABLE PROJECT 

--- Project is the enrollment table in the turorial......
Et kurs 
   En student 
       Mange karakterer  (Fag)

Et selskap 
    Et Prosjekt
         Mange prosjekt medlemmer 



--Company or Parentpage   Scaffold   EN student kan ha mange kurs    (et company)
Student
CREATE TABLE [dbo].[Project] (
    [ProjectID]      INT  IDENTITY (1, 1) Primary key  NOT NULL, 
    [ProjectName]       NVARCHAR (50) NULL,
    [ProjectComment]      NVARCHAR (50) NULL,
    [ProjectStartDate] DATETIME      NULL
)

---Course    do not scaffold    ---- Et kurs kan ha mange studenter…..  Et prosjekt kan ha mange contacts (medlemmer
CREATE TABLE [dbo].[Companies] (
    [CompanyID] INT           IDENTITY (1, 1) Primary Key NOT NULL,
    [CompanyName]    NVARCHAR (50) NULL,
    [CompanyDescription]  NVARCHAR (50)      NULL,
    
)
----Enrollment     scaffold          ----- et kurs har mange studenter som får karakterer I mange kurs 
CREATE TABLE [dbo].[Contact] (
    [ContactID] INT IDENTITY (1, 1) Primary Key NOT NULL,
    [ContactName]        DECIMAL(3, 2) NULL,
    [CompanyID]     INT NOT NULL,
	[ProjectID]    INT NOT NULL,
	CONSTRAINT [fk_dbo.Contact_dbo.Companies.CompanyID] FOREIGN KEY (CompanyID) REFERENCES Companies (CompanyID),
	CONSTRAINT [fk_dbo.Contact_dbo.Project.ProjectID] FOREIGN KEY (ProjectID) REFERENCES Project (ProjectID)
		)


)







---Student ---scaffold this
Create Table Contacts (
ContactsID INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
FullName nvarchar (255),
Email nvarchar(255)
)

---Course   (Parent Page) 
Create Table Company(
CompanyID INT IDENTITY (1,1) not null primary key,
CompanyName Nvarchar (255) null,
CompanyHomepage NvarChar (255) null
) 

---enrollment    scaffold this
Create Table Projects (
ProjectId int identity (1,1) not null Primary Key,
ProjectName nvarchar (255) not null,
ProjectComment nvarchar (255),
CompanyID INT  NOT NULL,
ContactsID INT,
CONSTRAINT [fk_dbo.Projects_dbo.Company.CompanyID] FOREIGN KEY (CompanyID) REFERENCES Company (CompanyID),
CONSTRAINT [fk_dbo.Projects_dbo.Contacts.ContactsID] FOREIGN KEY (ContactsID) REFERENCES Contacts (ContactsID)
) 
---
ALTER TABLE Projects DROP CONSTRAINT [fk_dbo.Projects_dbo.Contacts.ContactsID]
ALTER TABLE Projects ADD CONSTRAINT [fk_dbo.Projects_dbo.Contacts.ContactsID] Foreign Key (ContactsID) references Contacts(ContactsID)
ALter table Projects add  type nvarchar (255) (ProjectComment)

--drop table project 

--alter table document4 add PRIMARY KEY (ID)
--alter table document4 DROP PRIMARY KEY 
--ALTER TABLE Document4 ADD CONSTRAINT pk_documentID PRIMARY KEY (Id,Project)
--ALTER TABLE Document4 DROP CONSTRAINT pk_Document4_ID
 
--ALTER TABLE  Document4 add Project_ID INT
-- Alter tabLE Document4 add FOREIGN KEY (Project_ID) REFERENCES  Project(Documents) 
-- Alter table Document4 add constraint fk_projectDocument FOREIGN KEY (ID) REFERENCES Project(Documents)


CREATE TABLE [dbo].[Document11](
	[D_ID] [int] IDENTITY(1,1) NOT NULL primary key,
	[DocumentName] [nvarchar](120) NULL,
	[CompanyName] [nvarchar](255) NULL,
	[DocDescription] [nvarchar](2000) NULL,
	[DocumentURL] [nvarchar](3000) NULL,
	[PublishedDate] [date] NULL,
	[LastUpdateDate] [date] NULL,
	[MainWriter] [nvarchar](255) NULL,
	[ProjectName] [nvarchar](255) NULL,
	[ProjectLeader] [nvarchar](255) NULL,
	[AccesLevel] [nvarchar](255) NULL,
	[EditUrl] [nvarchar](3000) NULL,
	[SubmissionId] [nvarchar](255) NULL,
	[Commment] [nvarchar](3000) NULL,
	[UniqeID] [nvarchar](3000) NULL,
)