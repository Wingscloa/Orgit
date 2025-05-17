Table Users {
	UserId INTEGER [pk, increment]
    UserUID VARCHAR(255) [not null]
    FirstName VARCHAR(64) [not null]
    LastName VARCHAR(64) [not null]
    Nickname VARCHAR(64)
    Email VARCHAR(128) [not null, unique]
	Birthday DATE [not null]
	Verified BOOLEAN  [not null, default : false]
    ProfileIcon BYTEA
    Deleted BOOLEAN [not null, default: false]
    DeletedAt DATE 
    CreatedAt DATE [default: "NOW"]
    LastActive DATE [not null]
    TelephoneNumber VARCHAR(15)
    TelephonePrefix VARCHAR(5)
    Level INTEGER [not null, default: 1]
    Experience INTEGER [not null, default: 0]
    SettingsConfig BYTEA
	OnNotify BOOLEAN [not null, default : true]
}

Table Category {
	CategoryId INTEGER [pk, increment]
	Name VARCHAR(32) [not null]
}

Table TitlesIcons {
	IconId INTEGER [pk, increment]
	Name VARCHAR(32) [not null]
	Path TEXT
	URL VARCHAR(255)
	Data BYTEA
}

Table Titles {
	TitleId INTEGER [pk, increment]
    Name VARCHAR(64) [not null, unique]
    Color VARCHAR(64) [not null]
	CategoryId INTEGER [ref: > Category.CategoryId]
    LevelReq INTEGER 
	AppDefault INTEGER [not null, default : false]
    Description VARCHAR(255)
	Icon INTEGER [ref: > TitlesIcons.IconId]
}

Table UserTitles {
	UserId INTEGER [ref: > Users.UserId]
 	TitleId INTEGER [ref: > Titles.TitleId]
  indexes {
      (UserId, TitleId) [pk]
  }
}

Table Roles {
    RoleId INTEGER [pk, increment]
    Name VARCHAR(32) [not null]
	Color VARCHAR(7) [not null]
    Description VARCHAR(255)
	DuolingoCreateGroup BOOLEAN [not null, default : false]
	DuolingoDeleteGroup BOOLEAN [not null, default : false]
	DuolingoCreateQuest BOOLEAN [not null, default : false]
	DuolingoDeleteQuest BOOLEAN [not null, default : false]
	DuolingoValidationQuest BOOLEAN [not null, default : false]
	ChatDeleteMsg BOOLEAN [not null, default : false]
	ChatMuteMsg BOOLEAN [not null, default : false]
	EditParticipants BOOLEAN [not null, default : false]
	EventDelete BOOLEAN [not null, default : false]
	EventCreate BOOLEAN [not null, default : false]
	GroupKickUser BOOLEAN [not null, default : false]
	GroupBlockUser BOOLEAN [not null, default : false]
	GroupAcceptUser BOOLEAN [not null, default : false]
	GroupAddRole BOOLEAN [not null, default : false]
	ReportView BOOLEAN [not null, default : false]
	ReportDelete BOOLEAN [not null, default : false]
	ReportAnswer BOOLEAN [not null, default : false]
}


Table UserRoles {
    UserId INTEGER [ref: > Users.UserId]
    RoleId INTEGER [ref: > Roles.RoleId]
    indexes {
        (UserId, RoleId) [pk]
    }
}

Table ToDo {
    TodoId INTEGER [pk, increment]
    UserId INTEGER [ref: > Users.UserId]
	Thing VARCHAR(32) [not null]
    Note VARCHAR(255) [not null]
	ToComplete timestamp 
    Completed BOOLEAN [default: false]
    CreatedAt timestamp [default: "NOW"]
	Music VARCHAR(16) [default : 'joy']
	Repeat BOOLEAN [default : false]
}

Table Groups {
	GroupId INTEGER [pk, increment]
	ProfilePic BYTEA [not null]
	Name VARCHAR(32) [not null, unique]
	City VARCHAR(32) [not null]
	Region VARCHAR(32) [not null]
	Leader INTEGER [ref: > Users.UserId]
	Description VARCHAR(512) [not null]
	CreatedBy INTEGER [ref: > Users.UserId]
	CreatedAt DATE [default: "NOW"]
}

TABLE LevelName{
	LevelId INTEGER [pk, increment]
	GroupId INTEGER [ref: > Groups.GroupId]
	Name VARCHAR(16) [not null]
	LevelReq INTEGER [not null]
}

TABLE GroupTitles{
	TitleId INTEGER [ref: > Titles.TitleId]
	GroupId INTEGER [ref: > Groups.GroupId]
	indexes {
		(TitleId, GroupId) [pk]
	}
}

Table GroupMembers {
	GroupId INTEGER [ref: > Groups.GroupId]
	UserId INTEGER [ref: > Users.UserId]
	Indexes {
		(GroupId, UserId) [pk]
	}
}



Table Events {
	EventId INTEGER [pk, increment]
	GroupId INTEGER [ref: > Groups.GroupId]
	Name VARCHAR(32) [not null]
	color CHAR(7) [default : '#FFCB69']
	Description VARCHAR(512) [not null]
	ProfilePic BYTEA
	Address VARCHAR(128) [not null]
	Begins TIMESTAMP [not null]
	Ends TIMESTAMP [not null]
	CreatedAt TIMESTAMP [default: `now`]
}

Table EventItems { 
	EventItemId INTEGER [pk, increment]
	EventId INTEGER [ref: > Events.EventId]
	Name VARCHAR(255) [not null]
	Quantity INTEGER
	CreatedAt TIMESTAMP [default: "NOW"]
}


Enum EventPart_status {
    "Včasný příchod"
    "Pozdní příchod"
    "Omluven"
    "Neomluven"
}

Table EventParticipants {
	EventId INTEGER [ref: > Events.EventId]
	UserId INTEGER [ref: > Users.UserId]
	State EventPart_status
	Indexes {
		(EventId, UserId) [pk]
	}
}

Table GroupTree {
    TreeId INTEGER [pk, increment]
    GroupId INTEGER [ref: > Groups.GroupId]
}

Table BubbleGroups {
    BubbleGroupId INTEGER [pk, increment]
    TreeId INTEGER [ref: > GroupTree.TreeId]
    Name VARCHAR(64) [not null]
    Icon BYTEA [not null]
    UnlockAfterComplete INTEGER [ref: > BubbleGroups.BubbleGroupId]
    LevelReq INTEGER
}


Table BubbleQuests {
	BubbleQuestsId INTEGER [pk, increment]
	BubbleGroupId INTEGER [ref: > BubbleGroups.BubbleGroupId]
	Name VARCHAR(64) [not null]
	QuestNote VARCHAR(255) [not null]
	ProfilePic BYTEA [not null] 
	Experience INTEGER
	Title INTEGER [ref: > Titles.TitleId]
	CreatedBy INTEGER [ref: > Users.UserId]
	CreatedAt TIMESTAMP [default: `now`]
}

Table CompletedQuests {
    BubbleQuestsId INTEGER [ref: > BubbleQuests.BubbleQuestsId]
    UserId INTEGER [ref: > Users.UserId]
    indexes {
        (BubbleQuestsId, UserId) [pk]
    }
}

Table Chat {
	ChatId INTEGER [pk, increment]
	Name VARCHAR(32)
	Owner INTEGER [ref: > Users.UserId]
	GroupChatId INTEGER [ref: > Groups.GroupId]
	CreatedAt TIMESTAMP [default: "NOW"]
}

Table ChatParticipants {
	ChatId INTEGER [ref: > Chat.ChatId]
	UserId INTEGER [ref: > Users.UserId]
	Indexes {
		(ChatId, UserId) [pk]
	}
}

Table Messages {
	MessageId INTEGER [pk, increment]
	ChatId INTEGER [ref: > Chat.ChatId]
	UserId INTEGER [ref: > Users.UserId]
	Content TEXT [not null]
	SendAt TIMESTAMP [default: "NOW"]
}

Table Reactions {
	ReactionId INTEGER [pk, increment]
	MessageId INTEGER [ref: > Messages.MessageId]
	UserId INTEGER [ref: > Users.UserId]
	Emoji VARCHAR(32) [not null]
	ReactedAt TIMESTAMP [default: `now`]
}

	
Table NotificationTypes {
    NotificationTypeId INTEGER [pk, increment]
    TypeName VARCHAR(64) [unique, not null]
    Description VARCHAR(255)
}

Table Notifications {
	NotificationId INTEGER [pk, increment]
	UserId INTEGER [ref: > Users.UserId]
	NotificationTypeId INTEGER [ref: > NotificationTypes.NotificationTypeId]
	Message VARCHAR(255) [not null]
	CreatedAt TIMESTAMP [default: ""]
	Read BOOLEAN [default: false, not null]
}

Table Reports {
	ReportId INTEGER [pk, increment]
	UserId INTEGER [ref: > Users.UserId]
	Thing VARCHAR(32) [not null]
	Note VARCHAR(512) [not null]
	Resolved BOOLEAN [default: false, not null]
	Resolver INTEGER [ref: > Users.UserId]
	CreatedAt TIMESTAMP [default: "NOW"]
	Seen BOOLEAN [not null, default: FALSE]
}

Ref: "ChatParticipants"."ChatId" < "Chat"."CreatedAt"