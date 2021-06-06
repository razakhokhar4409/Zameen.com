


Create table [User](
	[Name] Varchar(255),
	[Email] Varchar(255),
	PhoneNumber Varchar(11),
	[Password] Varchar(255),
	UserName Varchar(255) Primary key not null,
);
select * from [User]


Create table Payment(
	Id int identity (1,1) Primary key,
	CardNumber Varchar(16),
	SecurityPin varchar(3),
	ExpiryDate date,
	UserName Varchar(255),
	Foreign key (UserName) References [User](UserName)  
);
select * from PropertyAd


insert into Payment values('123','987',getdate(),'kunwar12')
insert into Payment values('1234567890123456','967',getdate(),'kunwar12')
insert into Payment values('1234567890123456','967',getdate(),'haris123')
insert into Payment values('1234567812345678','123',getdate(),'hag1')


Create table [Location](
	Id int identity(1,1) Primary Key,
	Country Varchar(255),
	City Varchar(255),
	StreetNo Varchar(255),
	[Block] Char,
	Society Varchar(255),
	UserName Varchar(255),
	Foreign key (UserName) References [User](UserName)  
);
ALTER TABLE [Location]
ALTER COLUMN [Block] varchar(1);


insert into [Location] values ('Pakistan','Lahore','15','d','WapdaTown','kunwar12')
select * from [Location]


Create table RealEstateAgent(
	Id int identity(1,1) Primary Key,
	NameOfRealEstate Varchar(255),
	Nic Varchar(13),
	UserName varchar(255),
	Foreign key (UserName) References [User](UserName) 
);

create view getAgent 
as
select a.NameOfRealEstate,a.Nic,b.Email,b.Name,b.Password,b.PhoneNumber,b.UserName
from RealEstateAgent as a join [User] as b on a.UserName=b.UserName

create view getUser
as
select * from [User] where [User].UserName not in (select UserName from RealEstateAgent)


select * from [Appdet]



Create table PropertyAd(
	Id int identity(1,1) Primary Key,
	PropertyNumber int,
	Address Varchar(255),
	Area Int, --kanals
	Type Varchar(255),
	Price varchar(50),
	Kind Varchar(255),
	Description varchar(255),
	Bookmark int,
	Feature bit,
	UserName Varchar(255),
	Foreign key (UserName) References [User](UserName)   
);
Select * from PropertyAd
insert into PropertyAd values(1,'34-d Wapda Town',1,'Resdencial','20000000','Sale','All set',0,0,'kunwar12')
insert into PropertyAd values(2,'34-d Wapda Town',1,'Resdencial','20000000','Sale','All set',0,0,'haris123')
insert into PropertyAd values(1,'34-d Garden Town',1,'Resdencial','20000000','Sale','All set',0,0,'haris123')
insert into PropertyAd values(1,'34-d Ichra Town',1,'Commercial','20000000','Sale','All set',0,0,'haris123')
insert into PropertyAd values(1,'34-d faisal Town',1,'Resdencial','20000000','Sale','All set',0,0,'haris123')
insert into PropertyAd values(1,'34-d valancia Town',1,'Resdencial','20000000','Sale','All set',0,0,'haris123')

select * from PropertyAd order by Feature desc
update [PropertyAd] set  Feature = 1 where PropertyNumber=1 and Address='34-d Garden Town'
select * from bookmarks

Create table Bookmarks(
	PropertyAdId int,
	UserName Varchar(255),
	Foreign key (UserName) References [User](UserName),  
	Foreign key (PropertyAdId) References PropertyAd(Id)
);
insert into Bookmarks values(2,'kunwar12')
insert into Bookmarks values(1,'haris123')
insert into Bookmarks values(5,'kunwar12')

select * from Bookmarks

Create table Plaza (
	Id int identity(1,1) Primary Key,
	NoOfFloors int,
	PropertyAdId int,
	Foreign key (PropertyAdId) references PropertyAd(Id)
);
insert into Plaza values(5,4)


ALTER TABLE Plaza
ADD CONSTRAINT FK__Plaza__PropertyA__47DBAE45
Foreign key (PropertyAdId) references PropertyAd(Id) on delete cascade

ALTER TABLE Plaza
DROP CONSTRAINT FK__Plaza__PropertyA__47DBAE45;

SELECT
  CONSTRAINT_NAME   -- <<-- the one you want! 
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
  Table_name = 'Bookmarks';

  ALTER TABLE Bookmarks
DROP CONSTRAINT FK__Bookmarks__Prope__44FF419A;

ALTER TABLE Bookmarks
ADD CONSTRAINT FK__Bookmarks__Prope__44FF419A
Foreign key (UserName) References [User](UserName) on delete cascade

Create table House(
	Id int identity(1,1) Primary Key,
	NoOfBedrooms int,
	NoOfWashrooms int,
	Furnished bit,
	PropertyAdId int,
	Foreign key (PropertyAdId) references PropertyAd(Id)
);
insert into House values(3,3,1,3)
insert into House values(2,2,0,5)
select * from House


Create table Apartment(
	Id int identity(1,1) Primary Key,
	Floor int,
	HouseId int,
	Foreign key (HouseId) references House(Id)
);
insert into Apartment values(2,2)

Create table Trend(
	Id int identity(1,1) Primary Key,
	SearchedKeyword Varchar(255),
	TimesSearched int
);
select * from Payment

select top 5 * from Trend order by TimesSearched desc
insert into Trend values('wapda town',0)
update Trend set TimesSearched=1 where SearchedKeyword='wapda town'
delete from Trend where SearchedKeyword='garden town'

create table Blog(
	Id int identity(1,1) Primary Key,
	Name Varchar(255),
	Description Varchar(255)
);
Insert into Blog values('Zameen Blog','Blog for all Property Sellers and Buyers')

Create table Article(
	Id int identity(1,1) Primary Key,
	Name Varchar(255),
	MainBody Varchar(5000),
	DateOdPublish Date,
	UserName Varchar(255),
	BlogId int,
	Foreign key (UserName) References [User](UserName),
	Foreign key (BlogId) References Blog(Id)
);

select * from Article
Insert into Article values('Dha best place','It is worth living in Dha',GETDATE(),'kunwar12',1);






create VIEW [Appdet]
as
select c.Id,c.Address,c.Area,c.Bookmark,c.Description,c.Feature,c.Kind,c.Price,c.PropertyNumber,c.Type,b.Floor,a.Furnished,a.NoOfBedrooms,a.NoOfWashrooms,c.UserName
from House as a join Apartment as b on a.Id=b.HouseId join PropertyAd as c on a.PropertyAdId=c.Id

select * from Appdet

select * from housedet

create view [housedet]
as
select c.Id,c.Address,c.Area,c.Bookmark,c.Description,c.Feature,c.Kind,c.Price,c.PropertyNumber,c.Type,a.Furnished,a.NoOfBedrooms,a.NoOfWashrooms,c.UserName
from House as a join PropertyAd as c on a.PropertyAdId=c.Id
where c.id not in(select Id
				  from Appdet)




create view [plazadet]
as
select b.Id,b.Address,b.Area,b.Bookmark,b.Description,b.Feature,b.Kind,b.Price,b.PropertyNumber,b.Type,a.NoOfFloors,b.UserName
from Plaza as a join PropertyAd as b on a.PropertyAdId=b.Id

select * from plazadet

create view [propdet]
as
select *
from PropertyAd as a 
where Id not in(select Id from plazadet) and Id not in (select Id from Appdet) and Id not in (select Id from housedet) 


select * from [propdet] where [propdet].Id IN (select PropertyAdID from Bookmarks where UserName = 'kunwar12')

select * from Apartment
select * from House
select * from PropertyAd

declare @s varchar(255)='WAPDA town'
select * from [propdet] where [Address] LIKE '%'+@s+'%'