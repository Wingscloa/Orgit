CREATE TABLE Users (
	UserId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserUID varchar(255) NOT NULL,
	FirstName varchar(64) NOT NULL,
	LastName varchar(64) NOT NULL,
	Nickname varchar(64) NULL,
	Email varchar(128) NOT NULL UNIQUE,
	ProfileIcon BYTEA NULL,
	Deleted BOOLEAN NOT NULL DEFAULT FALSE,
	DeletedAt TIMESTAMP NULL,
	CreatedAt TIMESTAMP DEFAULT NOW(),
	LastActive TIMESTAMP NOT NULL,
	TelephoneNumber varchar(16) NULL,
	TelephonePrefix varchar(6) NULL,
	Level INTEGER NOT NULL DEFAULT 1,
	Experience INTEGER NOT NULL DEFAULT 0,
	SettingsConfig BYTEA NULL
);

CREATE INDEX idx_users_email ON Users(Email);
CREATE INDEX idx_users_Deleted ON Users(Deleted);
CREATE INDEX idx_users_DeletedAt ON Users(DeletedAt);
CREATE INDEX idx_users_LastActive ON Users(LastActive);

-- GROUPS & EVENTS

CREATE TABLE Groups (
	GroupId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ProfilePic BYTEA NOT NULL,
	Name varchar(32) NOT NULL,
	City varchar(32) NOT NULL,
	Leader INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Description varchar(512) NOT NULL,
	CreatedBy INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	CreatedAt DATE DEFAULT NOW()
);

CREATE TABLE GroupMembers (
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	PRIMARY KEY (GroupId, UserId)
);

CREATE TABLE Events (
	EventId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE,
	Name varchar(32) NOT NULL,
	Description varchar(512) NOT NULL,
	ProfilePic BYTEA NULL,
	Begins TIMESTAMP NOT NULL,
	Ends TIMESTAMP NOT NULL,
	CreatedAt TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_Events_GroupId ON Events(GroupId);

CREATE TABLE EventItems (
	EventItemId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	EventId INTEGER REFERENCES Events(EventId) ON DELETE CASCADE,
	ItemName varchar(255) NOT NULL,
	Quantity INTEGER NOT NULL DEFAULT 1,
	CreatedAt TIMESTAMP DEFAULT NOW()
);

CREATE TABLE EventParticipants (
	EventId INTEGER REFERENCES Events(EventId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	PRIMARY KEY (EventId, UserId)
);

CREATE INDEX idx_eventparticipants_userid ON EventParticipants(UserId);

CREATE TYPE TitleGroupEnum AS ENUM ('specials', 'achievements', 'level', 'unique');

CREATE TABLE Titles (
	TitleId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	TitleName varchar(64) NOT NULL UNIQUE,
	TitleColor varchar(64) NOT NULL,
	TitleGroup TitleGroupEnum NOT NULL,
	LevelReq INTEGER NULL,
	Description varchar(255) NULL
);

CREATE TABLE UserTitles (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	TitleId INTEGER REFERENCES Titles(TitleId) ON DELETE CASCADE,
	PRIMARY KEY (UserId, TitleId)
);

CREATE TABLE Permissions (
	PermissionId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL UNIQUE,
	Description varchar(255) NOT NULL
);

CREATE TABLE Roles (
	RoleId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	Name varchar(32) NOT NULL UNIQUE,
	Description varchar(255) NULL
);

CREATE TABLE RolePermissions (
	RoleId INTEGER REFERENCES Roles(RoleId) ON DELETE CASCADE,
	PermissionId INTEGER REFERENCES Permissions(PermissionId) ON DELETE CASCADE,
	PRIMARY KEY (RoleId, PermissionId)
);

CREATE TABLE UserRoles (
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	RoleId INTEGER REFERENCES Roles(RoleId) ON DELETE CASCADE,
	PRIMARY KEY (UserId, RoleId)
);

CREATE TABLE ToDo(
	TodoId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Note varchar(255) NOT NULL,
	Quantity INTEGER NULL,
	Completed BOOLEAN DEFAULT FALSE,
	CreatedAt TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_todo_userid ON ToDo(UserId);

-- SKILL TREE

CREATE TABLE GroupTree(
	TreeId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	GroupId INTEGER REFERENCES Groups(GroupId) ON DELETE CASCADE
);

CREATE INDEX idx_GroupTree_GroupId ON GroupTree(GroupId);

CREATE TABLE BubbleGroups(
	BubbleGroupId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	TreeId INTEGER REFERENCES GroupTree(TreeId) ON DELETE CASCADE,
	Name varchar(64) NOT NULL,
	Icon BYTEA NOT NULL,
	UnlockAfterComplete INTEGER REFERENCES BubbleGroups(BubbleGroupId) ON DELETE CASCADE NULL,
	LevelReq INTEGER NULL
);

CREATE INDEX idx_BubbleGroups_Tree ON BubbleGroups(TreeId);

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

CREATE INDEX idx_BubbleQuests_Group ON BubbleQuests(BubbleGroupId);

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

CREATE INDEX idx_chat_owner ON Chat(Owner);
CREATE INDEX idx_chat_groupchatid ON Chat(GroupChatId);

CREATE TABLE ChatParticipants(
	ChatId INTEGER REFERENCES Chat(ChatId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	PRIMARY KEY (ChatId, UserId)
);

CREATE INDEX idx_chatparticipants_userid ON ChatParticipants(UserId);

CREATE TABLE Messages(
	MessageId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	ChatId INTEGER REFERENCES Chat(ChatId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Content TEXT NOT NULL,
	SendAt TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_messages_chatid ON Messages(ChatId);
CREATE INDEX idx_messages_sendat ON Messages(SendAt);

CREATE TABLE Reactions (
	ReactionId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	MessageId INTEGER REFERENCES Messages(MessageId) ON DELETE CASCADE,
	UserId INTEGER REFERENCES Users(UserId) ON DELETE CASCADE,
	Emoji varchar(32) NOT NULL,
	ReactedAt TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_reactions_messageid ON Reactions(MessageId);
CREATE INDEX idx_reactions_userid ON Reactions(UserId);

-- NOTIFICATIONS



CREATE TABLE NotificationTypes (
	NotificationTypeId INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	TypeName varchar(64) NOT NULL UNIQUE,
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
	MessageId INTEGER REFERENCES Messages(MessageId) ON DELETE CASCADE,
	ReportType varchar(32) NOT NULL,
	Note varchar(512) NOT NULL,
	Resolved BOOLEAN NOT NULL DEFAULT FALSE,
	Resolver INTEGER REFERENCES Users(UserId),
	CreatedAt TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_reports_userid ON Reports(UserId);

-- TRIGGERS

-- Trigger 
CREATE OR REPLACE FUNCTION set_deleted_at()
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.Deleted = TRUE THEN
		NEW.DeletedAt := NOW();
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_set_deleted_at
BEFORE UPDATE ON Users
FOR EACH ROW
WHEN (NEW.Deleted IS DISTINCT FROM OLD.Deleted)
EXECUTE FUNCTION set_deleted_at();

-- Trigger updating LastActive Users
CREATE OR REPLACE FUNCTION update_last_active()
RETURNS TRIGGER AS $$
BEGIN
	NEW.LastActive := NOW();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_last_active
BEFORE UPDATE ON Users
FOR EACH ROW
EXECUTE FUNCTION update_last_active();