/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [Id]
      ,[Title]
      ,[Volumne]
      ,[Issue]
      ,[Publisher]
  FROM [ComicBooks].[dbo].[Books]
  
  
  create table products
  (
  product_id int identity (1,1) primary key,
  product_name nvarchar (255),
  price nvarchar (255),
  stock nvarchar (255)
  )
  
  create table reviews
  (
  review_id int identity (1,1) primary key,
  title nvarchar (255),
  review nvarchar (255),
  reviewer nvarchar (255),
  
  
  