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
	-- Email varchar(255) NOT NULL UNIQUE,
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
-- Testovací data pro Permissions
INSERT INTO Permissions (Name, Poznamka) VALUES 
('Admin', 'Přístup k administraci'),
('Editor', 'Může upravovat obsah'),
('Viewer', 'Pouze prohlížení'),
('Manager', 'Správa týmů'),
('Support', 'Podpora uživatelů');

-- Testovací data pro Roles
INSERT INTO Roles (Name, Description, PermissionId) VALUES 
('Administrator', 'Má přístup k veškerým funkcím', 1),
('Content Editor', 'Spravuje obsah aplikace', 2),
('Viewer', 'Pouze čte obsah', 3),
('Team Manager', 'Spravuje týmové záležitosti', 4),
('Support Agent', 'Řeší problémy uživatelů', 5);

-- Testovací data pro Users
INSERT INTO Users (FirstName, LastName, Nickname, RoleId, Email, Password, Deleted, Parent1, Parent2, ProfileIcon) VALUES
('Jan', 'Novák', 'JNovak', 1, 'jan.novak@example.com', 'password123', FALSE, ROW('Petr', 'Novák', '123456789'), NULL, E'\\xFFD8FFDB'),
('Petra', 'Svobodová', 'PSvoboda', 2, 'petra.svobodova@example.com', 'password456', FALSE, NULL, NULL, E'\\xFFD8FFE0'),
('Karel', 'Dvořák', 'KDvorak', 3, 'karel.dvorak@example.com', 'password789', TRUE, ROW('Alena', 'Dvořáková', '987654321'), NULL, E'\\xFFD8FFEE'),
('Lucie', 'Havlíčková', 'LHavlickova', 4, 'lucie.havlickova@example.com', 'securepass', FALSE, NULL, NULL, E'\\xFFD8FFE1'),
('Tomáš', 'Kučera', 'TKucera', 5, 'tomas.kucera@example.com', 'adminpass', TRUE, ROW('Radek', 'Kučera', '456789123'), ROW('Marie', 'Kučerová', '987123456'), E'\\xFFD8FFDB');

-- Testovací data pro Quests
INSERT INTO Quests (Name, Icon, Description) VALUES
('Najdi poklad', '/icons/treasure.png', 'Najít skrytý poklad'),
('Postav přístřešek', '/icons/shelter.png', 'Postavit jednoduchý přístřešek z přírodních materiálů'),
('Pomoz ostatním', '/icons/help.png', 'Pomoc při zajištění schůzky'),
('Nauč se nové dovednosti', '/icons/skills.png', 'Nauč se základy uzlování'),
('Zúčastni se výpravy', '/icons/trip.png', 'Účast na víkendové výpravě');

-- Testovací data pro QuestsCompleted
INSERT INTO QuestsCompleted (QuestId, UserId) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(2, 5);

-- Testovací data pro Badgets
INSERT INTO Badgets (Name, Description, Icon) VALUES
('Statečný Skaut', 'Za splnění 5 úkolů', E'\\xFFD8FFE2'),
('Zlatý Skaut', 'Za splnění všech úkolů', E'\\xFFD8FFE3'),
('Pomocník', 'Za pomoc ostatním', E'\\xFFD8FFE4'),
('Cestovatel', 'Za účast na více než 3 výpravách', E'\\xFFD8FFE5'),
('Učitel', 'Za předání dovedností ostatním', E'\\xFFD8FFE6');

-- Testovací data pro UserBadgets
INSERT INTO UserBadgets (UserId, BadgetId) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Testovací data pro Meeting
INSERT INTO Meeting (Velitel, Zastupce, Dosplej, Name, Popis, DatumZac, DatumKon) VALUES
(1, 2, 3, 'Výprava do lesa', 'Přespání a hry v lese', '2024-11-30', '2024-12-02'),
(2, 1, 4, 'Čištění lesa', 'Sbírání odpadků a úklid lesa', '2024-12-05', '2024-12-05'),
(3, 5, 2, 'Výstup na horu', 'Výprava na Sněžku', '2024-12-10', '2024-12-11'),
(4, 3, 1, 'Tábor v přírodě', 'Týdenní letní tábor', '2024-07-01', '2024-07-07'),
(5, 4, 3, 'Zimní přespání', 'Zimní výprava s přespáním', '2025-01-15', '2025-01-16');

-- Testovací data pro Participant
INSERT INTO Participant (MeetingID, UserId, Note) VALUES
(1, 1, 'Organizátor akce'),
(1, 2, 'Pomocník'),
(1, 3, 'Účastník'),
(2, 4, 'Dobrovolník'),
(2, 5, 'Úklidový tým'),
(3, 1, 'Vedoucí skupiny'),
(4, 2, 'Táborový organizátor'),
(5, 3, 'Účastník');

-- Testovací data pro Things
INSERT INTO Things (Nazev, ICON) VALUES
('Stan', E'\\xFFD8FFAA'),
('Lahev vody', E'\\xFFD8FFBB'),
('Baterka', E'\\xFFD8FFCC'),
('Mapa', E'\\xFFD8FFDD'),
('Kompas', E'\\xFFD8FFEE');

-- Testovací data pro MeetingThings
INSERT INTO MeetingThings (ThingsId, MeetingID, Pocet) VALUES
(1, 1, 5),
(2, 1, 10),
(3, 2, 3),
(4, 3, 7),
(5, 4, 2);
