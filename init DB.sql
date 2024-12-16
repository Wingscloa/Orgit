-- Create the Parent type
CREATE TYPE Parent AS (
    FirstName VARCHAR(64),
    LastName VARCHAR(64),
    PhoneNumber VARCHAR(16)
);

CREATE TABLE Permissions (
	PermissionId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL UNIQUE, 
	Poznamka varchar(255) NOT NULL UNIQUE
);

CREATE TABLE Roles (
	RoleId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL UNIQUE,
	Description varchar(255) NULL,
	PermissionId INTEGER REFERENCES Permissions(PermissionId) ON DELETE CASCADE
);

-- Users (SOFT DELETE PRI SMAZANI UCTU)
CREATE TABLE Users (
	UserId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserUID varchar(255) NOT NULL,
	FirstName varchar(64) NOT NULL,
	LastName varchar(64) NOT NULL,
	Nickname varchar(64) NULL,
	RoleId INTEGER REFERENCES Roles(RoleId) ON DELETE CASCADE,
	Email varchar(255) NOT NULL UNIQUE,
	-- Password varchar(24) NOT NULL,
	ProfileIcon BYTEA NULL,
	Deleted BOOLEAN NOT NULL DEFAULT FALSE,
	Parent1 Parent NULL,
	Parent2 Parent NULL
);

-- prává role
-- kazda role bude mit jiny permise
-- ukoly
-- TODO : Rozradit Ukoly na kolik veci si vzal (resit v aplikaci, uzivatel jen bude mit v DB ulozeny zda ho splnil,
-- pokavad smaze celou aplikaci, tak se mu resetne puvodni ukol, ktery bude plnit, jinak historie splnenych ukolu bude mit)
CREATE TABLE Quests (
	QuestsId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(255) NOT NULL UNIQUE,
	Icon varchar(512) NOT NULL,
	Description varchar(255) NULL
);

CREATE TABLE QuestsCompleted(
	QuestId INTEGER REFERENCES Quests(QuestsId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE
);

-- odznaky
-- TODO : Po splneni specifickeho ukolu, uzivatel zavola proceduru na DB, ktera bude brat UserId a BadgetId, pak se mu odemkne
CREATE TABLE Badgets (
	BadgetId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL UNIQUE,
	Description varchar(255) NOT NULL UNIQUE,
	Icon BYTEA NULL
);

CREATE TABLE UserBadgets (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	BadgetId INTEGER REFERENCES Badgets(BadgetId) ON DELETE CASCADE
);

-- schuzky/akce

CREATE TABLE Meeting (
	MeetingID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Velitel INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Zastupce INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Dosplej INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Name varchar(32) NOT NULL,
	Popis varchar(512) NOT NULL,
	DatumZac DATE NOT NULL,
	DatumKon DATE NOT NULL
);

CREATE TABLE Participant (
	ParticipantId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	MeetingID INTEGER REFERENCES Meeting(MeetingID) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Note varchar(512) NOT NULL
);

CREATE TABLE MeetingPoints (
	ParticipantId INTEGER REFERENCES Participant(ParticipantId),
	Points INTEGER NOT NULL,
	Nazev INTEGER NOT NULL
);

-- co si vzit (uzivatel bude moct ve vytvareni schuzky naklikat jaky bude predmety/veci potrebovat)

CREATE TABLE Things(
	ThingsId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Nazev varchar(64) NOT NULL,
	ICON BYTEA NULL
);

CREATE TABLE MeetingThings(
	ThingsId INTEGER REFERENCES Things(ThingsId) ON DELETE CASCADE,
	MeetingID INTEGER REFERENCES Meeting(MeetingID) ON DELETE CASCADE,
	Pocet INTEGER NULL
);

-- oddil

CREATE TABLE TroopsType(
	TypeId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Nazev varchar(54) NOT NULL
);

CREATE TABLE Troops(
	TroopsId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Nazev varchar(32) NOT NULL,
	Vudce INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Poznamka varchar(512) NOT NULL,
	Typ INTEGER REFERENCES TroopsType(TypeId) ON DELETE CASCADE,
	Adresa varchar(128) NOT NULL
);

-- nahlaseni chyb

CREATE TABLE ReportType(
	TypeId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Nazev varchar(32) NOT NULL
);

CREATE TABLE Reports(
	ReportID INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Uzivatel INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Types INTEGER REFERENCES ReportType(TypeId) ON DELETE CASCADE,
	Resolved BOOLEAN NOT NULL DEFAULT FALSE,
	Resolver INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Note varchar(512) NOT NULL
);

-- notifikace (vudce po vytvoreni akce/udalosti vsem odesle notifikaci dle DB resi server)
-- funguje na typ observe (https://refactoring.guru/design-patterns/observer)
-- + bude moct udelat notifikace

CREATE TABLE Notification(
	NotificationId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Nazev varchar(255) NOT NULL
);


------------------------- TESTOVACI DATA (NEUPLNY) -------------------------
-- Insert test data into Permissions
INSERT INTO Permissions (Name, Poznamka) VALUES
('Permission 1', 'Permission description 1'),
('Permission 2', 'Permission description 2'),
('Permission 3', 'Permission description 3'),
('Permission 4', 'Permission description 4'),
('Permission 5', 'Permission description 5');

-- Insert test data into Roles
INSERT INTO Roles (Name, Description, PermissionId) VALUES
('Admin', 'Administrator role', 1),
('User', 'Regular user role', 2),
('Manager', 'Manager role', 3),
('Editor', 'Editor role', 4),
('Viewer', 'Viewer role', 5);

-- Insert test data into Users
INSERT INTO Users (UserUID, FirstName, LastName, Nickname, RoleId, Email, ProfileIcon, Deleted, Parent1, Parent2) VALUES
('UID001', 'John', 'Doe', 'JD', 1, 'john.doe@example.com', NULL, FALSE, NULL, NULL),
('UID002', 'Jane', 'Smith', 'JS', 2, 'jane.smith@example.com', NULL, FALSE, NULL, NULL),
('UID003', 'Alice', 'Johnson', 'AJ', 3, 'alice.johnson@example.com', NULL, FALSE, NULL, NULL),
('UID004', 'Bob', 'Williams', 'BW', 4, 'bob.williams@example.com', NULL, FALSE, NULL, NULL),
('UID005', 'Charlie', 'Brown', 'CB', 5, 'charlie.brown@example.com', NULL, FALSE, NULL, NULL);

-- Insert test data into Quests
INSERT INTO Quests (Name, Icon, Description) VALUES
('Quest 1', 'icon1.png', 'Quest description 1'),
('Quest 2', 'icon2.png', 'Quest description 2'),
('Quest 3', 'icon3.png', 'Quest description 3'),
('Quest 4', 'icon4.png', 'Quest description 4'),
('Quest 5', 'icon5.png', 'Quest description 5');

-- Insert test data into QuestsCompleted
INSERT INTO QuestsCompleted (QuestId, UserId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insert test data into Badgets
INSERT INTO Badgets (Name, Description, Icon) VALUES
('Badge 1', 'Badge description 1', NULL),
('Badge 2', 'Badge description 2', NULL),
('Badge 3', 'Badge description 3', NULL),
('Badge 4', 'Badge description 4', NULL),
('Badge 5', 'Badge description 5', NULL);

-- Insert test data into UserBadgets
INSERT INTO UserBadgets (UserId, BadgetId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Insert test data into Meeting
INSERT INTO Meeting (Velitel, Zastupce, Dosplej, Name, Popis, DatumZac, DatumKon) VALUES
(1, 2, 3, 'Meeting 1', 'Meeting description 1', '2024-12-20', '2024-12-21'),
(2, 3, 4, 'Meeting 2', 'Meeting description 2', '2024-12-22', '2024-12-23'),
(3, 4, 5, 'Meeting 3', 'Meeting description 3', '2024-12-24', '2024-12-25'),
(4, 5, 1, 'Meeting 4', 'Meeting description 4', '2024-12-26', '2024-12-27'),
(5, 1, 2, 'Meeting 5', 'Meeting description 5', '2024-12-28', '2024-12-29');

-- Insert test data into Participant
INSERT INTO Participant (MeetingID, UserId, Note) VALUES
(1, 1, 'Participant 1 note'),
(2, 2, 'Participant 2 note'),
(3, 3, 'Participant 3 note'),
(4, 4, 'Participant 4 note'),
(5, 5, 'Participant 5 note');

-- Insert test data into MeetingPoints
INSERT INTO MeetingPoints (ParticipantId, Points, Nazev) VALUES
(1, 10, 1),
(2, 15, 2),
(3, 20, 3),
(4, 25, 4),
(5, 30, 5);

-- Insert test data into Things
INSERT INTO Things (Nazev, ICON) VALUES
('Thing 1', NULL),
('Thing 2', NULL),
('Thing 3', NULL),
('Thing 4', NULL),
('Thing 5', NULL);

-- Insert test data into MeetingThings
INSERT INTO MeetingThings (ThingsId, MeetingID, Pocet) VALUES
(1, 1, 5),
(2, 2, 4),
(3, 3, 3),
(4, 4, 2),
(5, 5, 1);

-- Insert test data into TroopsType
INSERT INTO TroopsType (Nazev) VALUES
('Type 1'),
('Type 2'),
('Type 3'),
('Type 4'),
('Type 5');

-- Insert test data into Troops
INSERT INTO Troops (Nazev, Vudce, Poznamka, Typ, Adresa) VALUES
('Troop 1', 1, 'Troop 1 description', 1, 'Address 1'),
('Troop 2', 2, 'Troop 2 description', 2, 'Address 2'),
('Troop 3', 3, 'Troop 3 description', 3, 'Address 3'),
('Troop 4', 4, 'Troop 4 description', 4, 'Address 4'),
('Troop 5', 5, 'Troop 5 description', 5, 'Address 5');

-- Insert test data into ReportType
INSERT INTO ReportType (Nazev) VALUES
('Error Type 1'),
('Error Type 2'),
('Error Type 3'),
('Error Type 4'),
('Error Type 5');

-- Insert test data into Reports
INSERT INTO Reports (Uzivatel, Types, Resolved, Resolver, Note) VALUES
(1, 1, FALSE, NULL, 'Report 1 description'),
(2, 2, TRUE, 3, 'Report 2 description'),
(3, 3, FALSE, NULL, 'Report 3 description'),
(4, 4, TRUE, 5, 'Report 4 description'),
(5, 5, FALSE, NULL, 'Report 5 description');

-- Insert test data into Notification
INSERT INTO Notification (Nazev) VALUES
('Notification 1'),
('Notification 2'),
('Notification 3'),
('Notification 4'),
('Notification 5');
