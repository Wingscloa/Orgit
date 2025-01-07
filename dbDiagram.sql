Table Users {
	UserId int [pk, increment]
    UserUID varchar [not null]
    FirstName varchar(64) [not null]
    LastName varchar(64) [not null]
    Nickname varchar(64)
    Email varchar(128) [not null, unique]
    ProfileIcon bytea
    Deleted boolean [not null, default: false]
    DeletedAt timestamp 
    CreatedAt timestamp [default: "NOW"]
    LastActive timestamp [not null]
    TelephoneNumber varchar(15)
    TelephonePrefix varchar(5)
    Level int [not null, default: 1]
    Experience int [not null, default: 0]
    SettingsConfig bytea
}

Table Titles {
	TitleId int [pk, increment]
    TitleName varchar(64) [not null, unique]
    TitleColor varchar(64) [not null]
    TitleGroup enum('specials', 'achievements', 'level', 'unique') [not null]
    LevelReq int 
    Description varchar(255)
}

Enum TitleGroupEnum {
    specials
    achievements
    level
    unique
}


Table UserTitles {
	UserId int [ref: > Users.UserId]
  TitleId int [ref: > Titles.TitleId]
  indexes {
      (UserId, TitleId) [pk]
  }
}

Table Permissions {
    PermissionId int [pk, increment]
    Name varchar(32) [not null, unique]
    Description varchar(255) [not null]
}
 

Table Roles {
    RoleId int [pk, increment]
    Name varchar(32) [not null, unique]
    Description varchar(255)
}


Table RolePermissions {
    RoleId int [ref: > Roles.RoleId]
    PermissionId int [ref: > Permissions.PermissionId]
    indexes {
        (RoleId, PermissionId) [pk]
    }
}


Table UserRoles {
    UserId int [ref: > Users.UserId]
    RoleId int [ref: > Roles.RoleId]
    indexes {
        (UserId, RoleId) [pk]
    }
}


Table ToDo {
    TodoId int [pk, increment]
    UserId int [ref: > Users.UserId]
    Note varchar(255) [not null]
    Quantity int
    Completed boolean [default: false]
    CreatedAt timestamp [default: "NOW"]
}


Table GroupTree {
    TreeId int [pk, increment]
    GroupId int [ref: > Groups.GroupId]
}


Table BubbleGroups {
    BubbleGroupId int [pk, increment]
    TreeId int [ref: > GroupTree.TreeId]
    Name varchar(64) [not null]
    Icon bytea [not null]
    UnlockAfterComplete int [ref: > BubbleGroups.BubbleGroupId]
    LevelReq int
}


Table BubbleQuests {
	BubbleQuestsId INTEGER [pk, increment]
	BubbleGroupId INTEGER [ref: > BubbleGroups.BubbleGroupId]
	Name varchar(64) [not null]
	QuestNote varchar(255) [not null]
	ProfilePic BYTEA [not null] 
	Experience INTEGER
	Title INTEGER [ref: > Titles.TitleId]
	CreatedBy INTEGER [ref: > Users.UserId]
	CreatedAt TIMESTAMP [default: `now`]
}

Table CompletedQuests {
    BubbleQuestsId int [ref: > BubbleQuests.BubbleQuestsId]
    UserId int [ref: > Users.UserId]
    indexes {
        (BubbleQuestsId, UserId) [pk]
    }
}


Table Groups {
	GroupId INTEGER [pk, increment]
	ProfilePic BYTEA [not null]
	Name varchar(32) [not null]
	City varchar(32) [not null]
	Leader INTEGER [ref: > Users.UserId]
	Description varchar(512) [not null]
	CreatedBy INTEGER [ref: > Users.UserId]
	CreatedAt DATE [default: `now`]
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
	Name varchar(32) [not null]
	Description varchar(512) [not null]
	ProfilePic BYTEA
	Begin TIMESTAMP [not null]
	End TIMESTAMP [not null]
	CreatedAt TIMESTAMP [default: `now`]
}

Table EventItems { 
	EventItemId INTEGER [pk, increment]
	EventId INTEGER [ref: > Events.EventId]
	ItemName varchar(255) [not null]
	Quantity INTEGER [default: 1, not null]
	CreatedAt TIMESTAMP [default: `now`]
}

Table EventParticipants {
	EventId INTEGER [ref: > Events.EventId]
	UserId INTEGER [ref: > Users.UserId]
	Indexes {
		(EventId, UserId) [pk]
	}
}

Table Chat {
	ChatId INTEGER [pk, increment]
	Name varchar(32)
	Owner INTEGER [ref: > Users.UserId]
	GroupChatId INTEGER [ref: > Groups.GroupId]
	CreatedAt TIMESTAMP [default: `now`]
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
	SendAt TIMESTAMP [default: `now`]
}

Table Reactions {
	ReactionId INTEGER [pk, increment]
	MessageId INTEGER [ref: > Messages.MessageId]
	UserId INTEGER [ref: > Users.UserId]
	Emoji varchar(32) [not null]
	ReactedAt TIMESTAMP [default: `now`]
}

Table Notifications {
	NotificationId INTEGER [pk, increment]
	UserId INTEGER [ref: > Users.UserId]
	Message varchar(255) [not null]
	CreatedAt TIMESTAMP [default: `now`]
	Read BOOLEAN [default: false, not null]
}

Table NotificationTypes {
    NotificationTypeId int [pk, increment] // Primary Key, Auto Increment
    TypeName varchar(64) [unique, not null] // Unique, Not Null
    Description varchar(255) // Optional
}
 

Table Reports {
	ReportId INTEGER [pk, increment]
	UserId INTEGER [ref: > Users.UserId]
	MessageId INTEGER [ref: > Messages.MessageId]
	ReportType varchar(32) [not null]
	Note varchar(512) [not null]
	Resolved BOOLEAN [default: false, not null]
	Resolver INTEGER [ref: > Users.UserId]
	CreatedAt TIMESTAMP [default: `now`]
}



Ref: "ChatParticipants"."ChatId" < "Chat"."CreatedAt"