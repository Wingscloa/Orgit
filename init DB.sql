CREATE TABLE Users (
	UserId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserUID varchar(255) NOT NULL,
	FirstName varchar(64) NOT NULL,
	LastName varchar(64) NOT NULL,
	Nickname varchar(64) NOT NULL,
	Email varchar(128) NOT NULL UNIQUE,
	Birthday DATE NOT NULL,
	Verified BOOLEAN NOT NULL DEFAULT FALSE,
	ProfileIcon BYTEA NOT NULL,
	Deleted BOOLEAN NOT NULL DEFAULT FALSE,
	DeletedAt DATE NULL,
	CreatedAt DATE DEFAULT NOW(),
	LastActive DATE NULL,
	TelephoneNumber varchar(15) NOT NULL,
	TelephonePrefix varchar(5) NOT NULL,
	Level INTEGER NOT NULL DEFAULT 1,
	Experience INTEGER NOT NULL DEFAULT 0,
	SettingsConfig BYTEA NULL,
	OnNotify BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE INDEX idx_users_email ON Users(Email);
CREATE INDEX idx_users_useruid ON Users(UserUID);


CREATE TABLE Category(
	CategoryId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL
);

CREATE TABLE TitlesIcons (
	IconId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL,
	Path TEXT NULL,
	URL varchar(255) NULL,
	Data BYTEA NULL
);

-- title = badget
CREATE TABLE Titles (
	TitleId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(64) NOT NULL,
	Color varchar(64) NOT NULL,
	CategoryId INTEGER REFERENCES Category(CategoryId) ON DELETE CASCADE,
	LevelReq INTEGER NULL,
	AppDefault BOOLEAN NOT NULL DEFAULT FALSE,
	Description varchar(255) NULL,
	Icon INTEGER REFERENCES TitlesIcons(IconId) ON DELETE CASCADE
);

CREATE TABLE UserTitles (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	TitleId INTEGER REFERENCES Titles(TitleId) ON DELETE CASCADE,
	PRIMARY KEY (UserId, TitleId)
);

CREATE TABLE Roles (
	RoleId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL,
	Color varchar(7) NOT NULL,
	Description varchar(255) NULL,
	Admin BOOLEAN NOT NULL DEFAULT FALSE,
	-- Duolingo Moderator - 5
	DuolingoCreateGroup BOOLEAN NOT NULL  DEFAULT FALSE,
	DuolingoDeleteGroup BOOLEAN NOT NULL  DEFAULT FALSE,
	DuolingoCreateQuest BOOLEAN NOT NULL DEFAULT FALSE,
	DuolingoDeleteQuest BOOLEAN NOT NULL DEFAULT FALSE,
	DuolingoValidationQuest BOOLEAN NOT NULL DEFAULT FALSE,
	-- Chat Moderator - 2
	ChatDeleteMsg BOOLEAN NOT NULL DEFAULT FALSE,
	ChatMuteMsg BOOLEAN NOT NULL DEFAULT FALSE,
	-- Organisation - 3
	EditParticipants BOOLEAN NOT NULL DEFAULT FALSE,
	EventDelete BOOLEAN NOT NULL DEFAULT FALSE,
	EventCreate BOOLEAN NOT NULL DEFAULT FALSE,
	-- Group Moderator - 4
	GroupKickUser BOOLEAN NOT NULL DEFAULT FALSE,
	GroupBlockUser BOOLEAN NOT NULL DEFAULT FALSE,
	GroupAcceptUser BOOLEAN NOT NULL DEFAULT FALSE,
	GroupAddRole BOOLEAN NOT NULL DEFAULT FALSE,
	-- Report Moderator - 3
	ReportView BOOLEAN NOT NULL DEFAULT FALSE,
	ReportDelete BOOLEAN NOT NULL DEFAULT FALSE,
	ReportAnswer BOOLEAN NOT NULL DEFAULT FALSE
);

INSERT INTO Roles (Name,Color,Description,Admin)
	VALUES ('Owner','#0c8ce9','Have all perms to do',TRUE);

CREATE TABLE UserRoles (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	RoleId INTEGER REFERENCES Roles(RoleId) ON DELETE CASCADE,
	PRIMARY KEY (UserId, RoleId)
);

CREATE TABLE ToDo(
	TodoId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Thing varchar(32) NOT NULL,
	Note varchar(255) NULL,
	ToComplete TIMESTAMP NULL,
	Completed BOOLEAN DEFAULT FALSE,
	CreatedAt TIMESTAMP DEFAULT NOW(),
	Music varchar(16) NULL DEFAULT 'joy',
	Repeat BOOLEAN DEFAULT FALSE
);

CREATE INDEX idx_todo_userid ON ToDo(UserId);

-- GROUPS & EVENTS

CREATE TABLE Groups (
	GroupId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ProfilePic BYTEA NOT NULL,
	Name varchar(32) NOT NULL UNIQUE,
	City varchar(32) NOT NULL,
	Region varchar(32) NOT NULL,
	Leader INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Description varchar(512) NOT NULL,
	CreatedBy INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	CreatedAt DATE DEFAULT NOW()
);

CREATE TABLE LevelName(
	LevelId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER REFERENCES groups(GroupId) ON DELETE CASCADE,
	Name varchar(16) NOT NULL,
	LevelReq INTEGER NOT NULL
);

CREATE TABLE GroupTitles(
	TitleId INTEGER REFERENCES Titles(TitleId) ON DELETE CASCADE,
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE,
	PRIMARY KEY (TitleId, GroupId)
);

CREATE TABLE GroupMembers (
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	PRIMARY KEY (GroupId, UserId)
);

CREATE TABLE Events (
	EventId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER NULL REFERENCES Groups(GroupId) ON DELETE CASCADE,
	Creator INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	GroupEvent BOOLEAN NOT NULL DEFAULT FALSE,
	Name varchar(32) NOT NULL,
	Color char(7) NULL DEFAULT '#FFCB69',
	Description varchar(512) NOT NULL,
	ProfilePic BYTEA NULL,
	Address varchar(128) NOT NULL,
	Begins TIMESTAMP NOT NULL,
	Ends TIMESTAMP NOT NULL,
	Date DATE NOT NULL,
	CreatedAt TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_event_group ON Events(GroupId);
CREATE INDEX idx_event_creator ON Events(EventId);



CREATE TABLE EventItems (
	EventItemId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	EventId INTEGER REFERENCES Events(EventId) ON DELETE CASCADE,
	Name varchar(255) NOT NULL,
	Quantity INTEGER  NULL,
	CreatedAt TIMESTAMP DEFAULT NOW()
);

CREATE TYPE EventPart_status AS ENUM (
    'Včasný příchod',
    'Pozdní příchod',
    'Omluven',
    'Neomluven'
);


CREATE TABLE EventParticipants (
	EventId INTEGER REFERENCES Events(EventId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	State EventPart_status NULL,
	PRIMARY KEY (EventId, UserId)
);

CREATE INDEX idx_eventparticipants_userid ON EventParticipants(UserId);


-- SKILL TREE

CREATE TABLE GroupTree(
	TreeId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE
);

CREATE TABLE BubbleGroups(
	BubbleGroupId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	TreeId INTEGER REFERENCES GroupTree(TreeId) ON DELETE CASCADE,
	Name varchar(64) NOT NULL,
	Icon BYTEA NOT NULL,
	UnlockAfterComplete INTEGER REFERENCES BubbleGroups(BubbleGroupId) ON DELETE CASCADE NULL,
	LevelReq INTEGER NULL
);

CREATE TABLE BubbleQuests(
	BubbleQuestsId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	BubbleGroupId INTEGER REFERENCES BubbleGroups(BubbleGroupId) ON DELETE CASCADE,
	Name varchar(64) NOT NULL,
	QuestNote varchar(255) NOT NULL,
	ProfilePic BYTEA NOT NULL,
	Experience INTEGER NULL,
	Title INTEGER REFERENCES Titles(TitleId) ON DELETE CASCADE NULL,
	CreatedBy INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	CreatedAt TIMESTAMP DEFAULT NOW()
);

CREATE TABLE CompletedQuests(
	BubbleQuestsId INTEGER REFERENCES BubbleQuests(BubbleQuestsId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	PRIMARY KEY (BubbleQuestsId, UserId)
);

CREATE INDEX idx_completedquests_userid ON CompletedQuests(UserId);



-- CHAT

CREATE TABLE Chat(
	ChatId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NULL,
	Owner INTEGER REFERENCES Users(UserId) ON DELETE CASCADE NULL,
	GroupChatId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE NULL,
	CreatedAt TIMESTAMP DEFAULT NOW()
);

CREATE TABLE ChatParticipants(
	ChatId INTEGER REFERENCES Chat(ChatId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	PRIMARY KEY (ChatId, UserId)
);

CREATE TABLE Messages(
	MessageId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ChatId INTEGER REFERENCES Chat(ChatId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Content TEXT NOT NULL,
	SendAt TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_messages_userid ON Messages(UserId);

CREATE TABLE Reactions (
	ReactionId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	MessageId INTEGER REFERENCES Messages(MessageId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Emoji varchar(32) NOT NULL,
	ReactedAt TIMESTAMP DEFAULT NOW()
);


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
	Message varchar(255) NOT NULL,
	CreatedAt TIMESTAMP DEFAULT NOW(),
	Read BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_notifications_userid ON Notifications(UserId);

-- REPORTS

CREATE TABLE Reports (
	ReportId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Thing varchar(32) NOT NULL,
	Note varchar(512) NOT NULL,
	Resolved BOOLEAN NOT NULL DEFAULT FALSE,
	Resolver INTEGER REFERENCES Users(UserId),
	CreatedAt TIMESTAMP DEFAULT NOW(),
	Seen BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE INDEX idx_reports_userid ON Reports(UserId);


-- VIEWS

CREATE VIEW email_exists AS
SELECT 
    email,
    COUNT(*) AS email_count
FROM 
    users
GROUP BY 
    email;

 -- ALL GROUPS ONLY Profile and Name

CREATE VIEW AllGroups AS 
	SELECT 
		G.groupid,
		G."name",
		G.profilepic,
		G.city
	FROM groups as G;


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




