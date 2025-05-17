-- checked
CREATE TABLE Users (
	UserId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserUID varchar(255) NOT NULL,
	FirstName varchar(32) NULL,
	LastName varchar(32) NULL,
	Nickname varchar(32) NULL,
	Email varchar(64) NOT NULL UNIQUE,
	Birthday DATE NULL,
	Verified BOOLEAN NULL DEFAULT FALSE,
	Deleted BOOLEAN NOT NULL DEFAULT FALSE,
	TelephoneNumber char(9) NULL ,
	TelephonePrefix char(3) NULL,
	Level INTEGER NOT NULL DEFAULT 1,
	Experience INTEGER NOT NULL DEFAULT 0,
	ProfileIcon TEXT NULL,
	DeletedAt DATE NULL,
	CreatedAt DATE DEFAULT NOW(),
	LastActive DATE NULL
);

CREATE TABLE user_settings(
	UserId INTEGER PRIMARY KEY REFERENCES Users(UserId) ON DELETE CASCADE,
	notification_on BOOLEAN DEFAULT TRUE,
	theme TEXT DEFAULT 'default'
);

CREATE INDEX idx_users_email ON Users(Email);
CREATE INDEX idx_users_useruid ON Users(UserUID);

-- Icons

CREATE TABLE Icon(
	IconId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(16) NOT NULL,
	Content TEXT NOT NULL,
	Extension varchar(8) NOT NULL
);

-- Titles

--created
CREATE TABLE Category(
	CategoryId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(16) NOT NULL
);

CREATE TABLE Titles (
	TitleId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL,
	CategoryId INTEGER REFERENCES Category(CategoryId) ON DELETE CASCADE,
	Color char(6) NOT NULL,
	Icon INTEGER REFERENCES Icon(IconId) ON DELETE CASCADE,
	Describe varchar(255) NOT NULL,
	Rewardable BOOLEAN NOT NULL
);

CREATE TABLE UserTitles (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	TitleId INTEGER REFERENCES Titles(TitleId) ON DELETE CASCADE,
	PRIMARY KEY (UserId, TitleId)
);

-- TODO

CREATE TABLE ToDo(
	TodoId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Title varchar(32) NOT NULL,
	Note varchar(255) NULL,
	WhenComplete TIMESTAMP NOT NULL,
	ToComplete TIMESTAMP NULL,
	Completed BOOLEAN DEFAULT FALSE,
	CreatedAt TIMESTAMP DEFAULT NOW()
);


CREATE INDEX idx_todo_userid ON ToDo(UserId);

-- GROUPS & EVENTS

-- created

CREATE TABLE Groups (
	GroupId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ProfilePicture TEXT NOT NULL,
	Name varchar(32) NOT NULL UNIQUE,
	City varchar(32) NOT NULL,
	Region varchar(32) NOT NULL,
	Leader INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Description varchar(512) NOT NULL,
	CreatedBy INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	CreatedAt DATE DEFAULT NOW(),
	Deleted BOOLEAN DEFAULT FALSE
);

-- created
CREATE TABLE LevelName(
	LevelId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER REFERENCES groups(GroupId) ON DELETE CASCADE,
	Name varchar(16) NOT NULL,
	LevelReq INTEGER NOT NULL
);

-- created
CREATE TABLE GroupMembers (
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	PRIMARY KEY (GroupId, UserId)
);


-- Roles

CREATE TABLE Roles (
	RoleId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE,
	Name varchar(32) NOT NULL,
	IconId INTEGER REFERENCES Icon(IconId) ON DELETE CASCADE,
	Admin BOOLEAN NOT NULL DEFAULT FALSE,
	-- Duolingo Group
	DuolingoCreateGroup BOOLEAN NOT NULL  DEFAULT FALSE,
	DuolingoDeleteGroup BOOLEAN NOT NULL  DEFAULT FALSE,
	-- Duolingo Quest
	DuolingoCreateQuest BOOLEAN NOT NULL DEFAULT FALSE,
	DuolingoDeleteQuest BOOLEAN NOT NULL DEFAULT FALSE,
	DuolingoValidationQuest BOOLEAN NOT NULL DEFAULT FALSE,
	-- Event
	EventDelete BOOLEAN NOT NULL DEFAULT FALSE,
	EventCreate BOOLEAN NOT NULL DEFAULT FALSE,
	-- Meeting Grade
	MeetingGrade BOOLEAN NOT NULL DEFAULT FALSE,
	-- Group
	GroupKickUser BOOLEAN NOT NULL DEFAULT FALSE,
	GroupBlockUser BOOLEAN NOT NULL DEFAULT FALSE,
	GroupAcceptUser BOOLEAN NOT NULL DEFAULT FALSE,
	GroupAddRole BOOLEAN NOT NULL DEFAULT FALSE,
	-- Report
	ReportView BOOLEAN NOT NULL DEFAULT FALSE,
	ReportDelete BOOLEAN NOT NULL DEFAULT FALSE,
	ReportAnswer BOOLEAN NOT NULL DEFAULT FALSE,
	ReportEdit BOOLEAN NOT NULL DEFAULT FALSE,
	-- Role
	RoleCreate BOOLEAN NOT NULL DEFAULT FALSE,
	RoleDelete BOOLEAN NOT NULL DEFAULT FALSE,
	-- Member 
	MemberAccept BOOLEAN NOT NULL DEFAULT FALSE,
	MemberRemove BOOLEAN NOT NULL DEFAULT FALSE,
	MemberBlock BOOLEAN NOT NULL DEFAULT FALSE,
	-- Title
	TitleCreate BOOLEAN NOT NULL DEFAULT FALSE,
	TitleRemove BOOLEAN NOT NULL DEFAULT FALSE,
	TitleSign BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE UserRoles (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	RoleId INTEGER REFERENCES Roles(RoleId) ON DELETE CASCADE,
	PRIMARY KEY (UserId, RoleId)
);

-- Event Create
-- created
CREATE TABLE Events (
	EventId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER NULL REFERENCES Groups(GroupId) ON DELETE CASCADE, -- NULL = UserEvent / NOT NULL = GroupEvent
	Creator INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Name varchar(32) NOT NULL,
	Color char(6) NULL DEFAULT '#FFCB69',
	Description varchar(512) NOT NULL,
	Address varchar(128) NOT NULL,
	Begins DATE NOT NULL,
	Ends DATE NOT NULL,
	CreatedAt DATE DEFAULT NOW(),
	IconId INTEGER REFERENCES Icon(IconId) ON DELETE CASCADE
);


CREATE INDEX idx_event_group ON Events(GroupId);
CREATE INDEX idx_event_creator ON Events(EventId);

-- Event items

CREATE TABLE Item(
	ItemId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	EventId INTEGER REFERENCES Events(EventId) ON DELETE CASCADE,
	IconId INTEGER REFERENCES Icon(IconId) ON DELETE CASCADE,
	Name varchar(16) NOT NULL,
	Count INT NOT NULL
);

CREATE INDEX idx_item_event ON Item(EventId);

-- Po insertu Event ==> vyplnit lidem veci, aby si mohli lehce odkliknout, jestli to maji odkliknuto
CREATE TABLE CompletedItem(
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	ItemId INTEGER REFERENCES Item(ItemId) ON DELETE CASCADE,
	PickUp BOOLEAN NOT NULL,
	PRIMARY KEY (UserId,ItemId)
);

-- Event Grading

-- created
CREATE TYPE EventPartStatus AS ENUM (
    'Včasný příchod',
    'Pozdní příchod',
    'Omluven',
    'Neomluven'
);
-- created
CREATE TABLE EventParticipants (
	EventId INTEGER REFERENCES Events(EventId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	State EventPartStatus NULL,
	PRIMARY KEY (EventId, UserId)
);

CREATE INDEX idx_eventparticipants_userid ON EventParticipants(UserId);


-- NOTIFICATIONS

CREATE TABLE NotificationTypes (
	NotificationTypeId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(64) NOT NULL UNIQUE,
	Description varchar(255) NULL
);

CREATE TABLE Notifications (
	NotificationId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	NotificationTypeId INTEGER REFERENCES NotificationTypes(NotificationTypeId) ON DELETE CASCADE,
	Title varchar(32) NOT NULL,
	Message varchar(255) NOT NULL,
	CreatedAt TIMESTAMP DEFAULT NOW(),
	Read BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_notifications_userid ON Notifications(UserId);

-- REPORTS

CREATE TABLE Reports (
	ReportId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Title varchar(32) NOT NULL,
	Note varchar(512) NOT NULL,
	Resolved BOOLEAN NOT NULL DEFAULT FALSE,
	Resolver INTEGER REFERENCES Users(UserId),
	CreatedAt TIMESTAMP DEFAULT NOW(),
	Seen BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_reports_userid ON Reports(UserId);


-- SKILL TREE

-- created

CREATE TABLE GroupTree(
	TreeId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE
);

-- created
CREATE TABLE BubbleGroups(
	BubbleGroupId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	TreeId INTEGER REFERENCES GroupTree(TreeId) ON DELETE CASCADE,
	Name varchar(32) NOT NULL,
	IconId INTEGER REFERENCES Icon(IconId) ON DELETE CASCADE,
	UnlockAfterComplete INTEGER REFERENCES BubbleGroups(BubbleGroupId) ON DELETE CASCADE NULL,
	LevelReq INTEGER NULL DEFAULT 1
);

-- created
CREATE TABLE BubbleQuests(
	BubbleQuestsId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	BubbleGroupId INTEGER REFERENCES BubbleGroups(BubbleGroupId) ON DELETE CASCADE,
	Name varchar(32) NOT NULL,
	QuestNote varchar(255) NOT NULL,
	IconId INTEGER REFERENCES Icon(IconId) ON DELETE CASCADE,
	Experience INTEGER NULL,
	Title INTEGER REFERENCES Titles(TitleId) ON DELETE CASCADE NULL,
	CreatedBy INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	CreatedAt TIMESTAMP DEFAULT NOW()
);

-- created
CREATE TABLE CompletedQuests(
	BubbleQuestsId INTEGER REFERENCES BubbleQuests(BubbleQuestsId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	PRIMARY KEY (BubbleQuestsId, UserId)
);

CREATE INDEX idx_completedquests_userid ON CompletedQuests(UserId);



-- VIEWS

-- ALL GROUPS ONLY Profile and Name

CREATE VIEW AllGroups AS 
	SELECT 
		G.groupid,
		G."name",
		G.ProfilePicture,
		G.city
	FROM groups as G
	WHERE G.deleted = FALSE;
	
-- spojeny tituly zakladni aplikace a tituly skupiny uzivatele, ktera vraci potrebne veci pro zobrazeni
CREATE OR REPLACE FUNCTION Func_get_all_titles(group_id INT)
RETURNS TABLE (
    name varchar(64),
    color varchar(64),
    levelreq INT,
    description varchar(255),
    categoryname varchar(32)
) AS $$
BEGIN
    RETURN QUERY
		SELECT -- tituly ze skupiny
			titles.name,
			titles.color,
			titles.levelreq,
			titles.description,
			category."name"
			
			FROM grouptitles 
				JOIN titles ON titles.titleid = grouptitles.titleid 
				JOIN category ON titles.categoryid = category.categoryid
		
			WHERE grouptitles.groupid = group_id

		UNION

		SELECT titles.name, -- tituly ze zakladni aplikace
			titles.color,
			titles.levelreq,
			titles.description,
			category."name"
			FROM titles JOIN category ON titles.categoryid = category.categoryid
			WHERE titles.appdefault = TRUE;
END;
$$ LANGUAGE plpgsql;

-- add admin user and grand all permissions
CREATE user admin;
GRANT postgres TO admin;