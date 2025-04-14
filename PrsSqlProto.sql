/*CREATE DATABASE PRSproto;
USE PRSproto;

CREATE TABLE [User] (
	ID			int PRIMARY KEY IDENTITY(1,1), 
	Username	varchar(20) 	NOT NULL	UNIQUE,
	Password	varchar(20)		NOT NULL,
	FirstName	varchar(20)		NOT NULL,
	PhoneNumber varchar(12)		NULL		CHECK (PhoneNumber IS NULL OR PhoneNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
	Email		varchar(75)		NULL		CHECK (Email is NULL OR Email LIKE '%,@%.%'),
	Reviewer	bit DEFAULT 0,				--0 is false
	Admin		bit	DEFAULT 0				--0 is false
	);
		
GO
*/
CREATE TABLE Vendor (
	ID			int PRIMARY KEY IDENTITY(1,1),
	Code		varchar(10)		NOT NULL,
	Name		varchar(255)	NOT NULL,
	Address		varchar(255)	NOT NULL,
	City		varchar(255)	NOT NULL,
	State		varchar(2)		NOT NULL,
	Zip			varchar(5)		NOT NULL,
	PhoneNumber varchar(12)		NOT NULL	CHECK (PhoneNumber IS NULL OR PhoneNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
	Email		varchar(100)	NOT NULL	CHECK (Email is NULL OR Email LIKE '%,@%.%')
	);

GO

CREATE TABLE Product (
	ID			int PRIMARY KEY IDENTITY(1,1),
	VendorID	int				NOT NULL REFERENCES Vendor(ID), 
	PartNumber	varchar(50)		NOT NULL,
	Name		varchar(150)	NOT NULL,
	Price		decimal(10,2)	NOT NULL,
	Unit		varchar(255)	NULL,
	PhotoPath	varchar(255)	NULL
	);

GO

CREATE TABLE Request (
	ID					int PRIMARY KEY IDENTITY(1,1),
	UserID				int				NOT NULL, 
	RequestNumber		varchar(20)		NOT NULL,
	Description			varchar(20)		NOT NULL,
	Justification		varchar(255)	NOT NULL,
	DateNeeded			date			NOT NULL,
	DeliveryMode		varchar(25)		NOT NULL,
	Status				varchar(20)		NOT NULL	DEFAULT 'NEW' ,
	Total				decimal(10,2)	NOT NULL	DEFAULT 0.0 ,
	SubmittedDate		datetime		NOT NULL,
	ReasonForRejection	varchar(100)	NULL
	);

GO

CREATE TABLE LineItem (
	ID				int			NOT NULL,	
	RequestID		int			NOT NULL REFERENCES Request(ID),
	ProductID		int			NOT NULL REFERENCES Product(ID),
	Quantity		int			NOT NULL
	);

GO

ALTER TABLE [User]
ADD CONSTRAINT uname UNIQUE (Username)

ALTER TABLE LineItem
ADD CONSTRAINT req_pdt UNIQUE (RequestID, ProductID)

ALTER TABLE Product
ADD CONSTRAINT vendor_part UNIQUE (VendorID, PartNumber)

ALTER TABLE Vendor
ADD CONSTRAINT vcode UNIQUE (Code);

ALTER TABLE [Request] 
ADD CONSTRAINT [requesttouser] FOREIGN KEY ([UserID]) REFERENCES [User]([ID])
