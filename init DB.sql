CREATE TABLE Users (
	UserId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	FirstName varchar(64) NOT NULL,
	LastName varchar(64) NOT NULL,
	Nickname varchar(64) NULL,
	Email varchar(255) NOT NULL UNIQUE,
	Password varchar(255) NOT NULL
)

'Password zatím bez hashe až v produkci'

DROP TABLE Users CASCADE;

INSERT INTO Users (FirstName,LastName,Nickname,Email,Password) VALUES
	('Filip','Éder','MeowMajitel_','8filipino@gmail.com','99tablet'),
	('Lukáš','Buriánek','ZIP','nevim@gmail.com','99notebook'),
	('Churaq','Cyril','Baroko','Baroko@renesance','99placebo')


CREATE TABLE Permissions (
	PermissionId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL UNIQUE,
	Perms int NOT NULL UNIQUE
)

INSERT INTO Permissions (Name,Perms) VALUES
	('ADMIN',1),
	('WRITER',2),
	('READER',3)

CREATE TABLE Roles (
	RoleId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL UNIQUE,
	Description varchar(255) NULL
)

INSERT INTO Roles (Name,Description) VALUES
	()

CREATE TABLE Authorizations (
	RoleId INTEGER REFERENCES Roles(RoleId) ON DELETE CASCADE,
	PermissionId INTEGER REFERENCES Permissions(PermissionId) ON DELETE CASCADE
)

CREATE TABLE Quests (
	QuestsId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(255) NOT NULL UNIQUE,
	Icon varchar(512) NOT NULL,
	Description varchar(255) NULL
)

DROP TABLE Quests CASCADE;

INSERT INTO Quests (Name,Icon,Description) VALUES
	('Maská nebo placká?','TestIcon.png','Skoč slalom vpřed'),
	('Je to perník a je to teplý perník','TestIcon.png','Upeč perník za pomocí jedlé sody,mastek a benzínu'),
	('Zmizte než začne nuklearní holokaust, holoto','TestIcon.png','Zaměř pár afroameričanu uranovou pumou LITTLE BOY'),
	('Co pro někoho je odpad, to je pro druhý poklad','TestIcon.png','Zařvi na člověká bez domová "I FEEL LIKE MICHAEL JACKSON" a moonwalkuj'),
	('V noci krásne hvězdy do vody naprší, běda hochu, na nějž ty oči zasrší','TestIcon.png','Za jeden den oslov 20 holek a 20 kluku'),
	('LINKIN PARK SESSION','TestIcon.png','Shlédni 5 koncertů LINKIN PARK s Chester Bennington'),
	('KDO NENÍ ČTENÁŘ JE SNÁŘ','TestIcon.png','Přečti si proměný od Kafky'),
	('RING OF LORD','TestIcon.png','Buď majitel 5ti různých symbolických prstenů'),
	('Profesionální Feťák','TestIcon.png','Vytetuj si skautskou lilii na čelo')
	

	
CREATE TABLE CompletedQuests (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	QuestsId INTEGER REFERENCES Quests(QuestsId) ON DELETE CASCADE
)

INSERT INTO CompletedQuests (UserId,QuestsId) VALUES
	(1,1),
	(1,2),
	(1,3),
	(1,4),
	(1,5),
	(2,3),
	(2,2),
	(3,1);


CREATE TABLE Badgets (
	BadgetId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL UNIQUE,
	Description varchar(255) NOT NULL UNIQUE,
	Icon varchar(512) NOT NULL
)

DROP TABLE Badgets CASCADE;

INSERT INTO Badgets (Name,Icon,Description) VALUES
	('Začátek','TestIcon.png','Poprvé si sáhnul na hlavní menu'),
	('Skautik','TestIcon.png','Co na mě klikáš??'),
	('První úkol','TestIcon.png','Vše má svůj začátek!'),
	('Jsem plný','TestIcon.png','Už vím o tobě vše'),
	('Za Desatero Horami','TestIcon.png','10 achievmentů ,10 úkolů, 10 akcí, 10 schůzek, co po mně ještě chce?');


CREATE TABLE UserBadgets (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	BadgetId INTEGER REFERENCES Badgets(BadgetId) ON DELETE CASCADE
)

CREATE TABLE Participant (
	ParticipantId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	TypeOfEvent varchar(32) NOT NULL,
	Name varchar(255) NOT NULL,
	DateStart date NOT NULL,	 
	Description varchar(255) NOT NULL
)

CREATE TABLE ScoringParticipant (
	ParticipantId INTEGER REFERENCES Participant(ParticipantId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Points INTEGER NOT NULL,
	Reason varchar(255) NULL
)

CREATE TABLE Things (
	ThingId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) UNIQUE NOT NULL UNIQUE,
	Description varchar(255) NULL
)

CREATE TABLE WhatTake (
	WhatTakeId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ParticipantId INTEGER REFERENCES Participant(ParticipantId) ON DELETE CASCADE,
	ThingId INTEGER REFERENCES Things(ThingId) ON DELETE CASCADE,
	Count INTEGER NOT NULL
)

CREATE TABLE TookIT (
	ParticipantId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	WhatTakeId INTEGER REFERENCES WhatTake(WhatTakeId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Splnil INTEGER NOT NULL
)