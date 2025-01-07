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

-- TITLE

INSERT INTO public.titles (description,levelreq,titlecolor,titlegroup,titlename)
	VALUES ('Prvni krucky v aplikaci',0,'#FF5733','level','Novacek');


INSERT INTO public.usertitles(titleid,userid)
	VALUES(1,1);