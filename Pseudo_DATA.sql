-- PSEUDO DATA FOR TESTING

-- USERS

INSERT INTO public.users (useruid, firstname, lastname, nickname, email, profileicon, telephonenumber, telephoneprefix)
	VALUES ('vv070rhAdBWCwmjxisZC7KuVmRA2','Filip','Éder','Wingscloa','8filipino@gmail.com','01010','123 456 789','420');

-- GROUP & EVENT

INSERT INTO public.groups (profilepic, name, city, leader, description) 
	VALUES ('01010','Letnaci','Decin',1,'Jsme z Decina a bydlime na Letny');

-- GROUP MEMBERS

INSERT INTO public.groupmembers (groupid,userid)
	VALUES(1,1);

-- Events
	
INSERT INTO public.events (groupid,"name",description,profilepic,begins,ends)
	VALUES (1,'Sneznik','Decin je super','10101','2025-04-12 12:00:00','2025-04-12 17:00:00');

-- Event Items

INSERT INTO public.eventitems (eventid,itemname,quantity)
	VALUES(1,'Dobrá nálada','1');

-- EVENT PARTICIPANTS

INSERT INTO public.eventparticipants (eventid,userid)
	VALUES (1,1);

-- Icon

INSERT INTO Icon (Name,Content,Extension)
	VALUES
		('Zacatek','0101','jpg'),
		('Skautik','0101','jpg'),
		('Prvni','0101','jpg'),
		('Fill_Formular','0101','jpg'),
		('Mountains','0101','jpg');


-- CATEGORY

INSERT INTO Category(CategoryId,Name)
	VALUES
		('Základní'),
		('Umělecké'),
		('Technické'),
		('Příroda'),
		('Kulturní'),
		('Vědecké'),
		('Zdravotnické'),
		('Vodácké'),
		('Sportovní'),
		('Duchovní'),
		('Společný život');
-- TITLE

SELECT * FROM Icon;

INSERT INTO Titles(Name,CategoryId,Color,Icon,Describe,Rewardable)
	VALUES
		('Začátek',1,'0000ff',1,'po prvnim zapnuti, po registraci',false),
		('Skautík',1,'0000ff',2,'po kliknuti skautika',false),
		('První úkol',1,'0000ff',3,'po splneni prvniho ukolu v Scautlingo',false),
		('Jsem plný',1,'0000ff',4,'po vyplneni všech údaju',false),
		('Za desatero horami',1,'0000ff',5,'splnění 10 achievmentu, 10 úkolu',false);