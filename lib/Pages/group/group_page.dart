import 'package:flutter/material.dart';
import 'package:orgit/models/group_dto.dart';
import 'package:orgit/models/user_dto.dart';
import 'package:blur/blur.dart';
import 'package:orgit/utils/responsive_utils.dart';
import 'package:orgit/components/icons/avatar.dart';

class Grouppage extends StatefulWidget {
  @override
  State<Grouppage> createState() => _GrouppageState();
}

class _GrouppageState extends State<Grouppage> {
  GroupResponse group = GroupResponse(
    profilepicture: Uri.parse("https://randomuser.me/api/portraits/men/3.jpg"),
    name: "Example Group",
    city: "Example City",
    region: "Example Region",
    leader: 1,
    description: "This is an example group description.",
    createdby: 1,
    createdat: DateTime.now(),
    deleted: false,
  );
  List<UserResponse> members = [
    UserResponse(
        userid: 1,
        useruid: "mock_user_1_uuid_abcd1234",
        firstname: "Jan",
        lastname: "Novák",
        nickname: "JanN",
        email: "jan.novak@email.com",
        birthday: DateTime.parse("1995-03-15"),
        verified: true,
        deleted: false,
        telephonenumber: "123456789",
        telephoneprefix: "420",
        level: 5,
        experience: 1250,
        profileicon: Uri.parse("https://randomuser.me/api/portraits/men/1.jpg"),
        deletedat: null,
        createdat: DateTime.parse("2024-01-15T10:30:00"),
        lastactive: DateTime.parse("2024-12-14T14:20:00")),
    UserResponse(
        userid: 2,
        useruid: "mock_user_2_uuid_efgh5678",
        firstname: "Marie",
        lastname: "Svobodová",
        nickname: "MariS",
        email: "marie.svobodova@email.com",
        birthday: DateTime.parse("1992-07-22"),
        verified: true,
        deleted: false,
        telephonenumber: "987654321",
        telephoneprefix: "420",
        level: 8,
        experience: 2800,
        profileicon:
            Uri.parse("https://randomuser.me/api/portraits/women/2.jpg"),
        deletedat: null,
        createdat: DateTime.parse("2024-02-10T09:15:00"),
        lastactive: DateTime.parse("2024-12-14T16:45:00")),
    UserResponse(
        userid: 3,
        useruid: "mock_user_3_uuid_ijkl9012",
        firstname: "Petr",
        lastname: "Dvořák",
        nickname: "PetrD",
        email: "petr.dvorak@email.com",
        birthday: DateTime.parse("1988-11-08"),
        verified: false,
        deleted: false,
        telephonenumber: "555666777",
        telephoneprefix: "420",
        level: 3,
        experience: 750,
        profileicon: Uri.parse("https://randomuser.me/api/portraits/men/3.jpg"),
        deletedat: null,
        createdat: DateTime.parse("2024-03-05T14:20:00"),
        lastactive: DateTime.parse("2024-12-13T11:30:00")),
  ];

  String get memberCount {
    if (members.length == 1) {
      return "${members.length} člen";
    } else if (members.length > 1 && members.length < 5) {
      return "${members.length} členové";
    } else {
      return "${members.length} členů";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Full name
        Blur(
          blur: 4,
          blurColor: Color.fromARGB(255, 100, 100, 100),
          child: const Image(
            image: AssetImage('assets/backgroundMap.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avatar(image: NetworkImage(group.profilepicture.toString())),
                Text(
                  group.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.getHeadingFontSize(context) * 1.2,
                    letterSpacing: 4,
                  ),
                ),
                Text(
                  "${group.city}, ${group.region}",
                  style: TextStyle(
                    color: Colors.white.withAlpha(90),
                    fontSize: ResponsiveUtils.getSubtitleFontSize(context),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        19,
                        20,
                        22,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 5,
                          color: Color.fromARGB(255, 32, 32, 32),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Text(
                          memberCount,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white.withAlpha(125),
                            fontSize:
                                ResponsiveUtils.getSubtitleFontSize(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Container(
                          width: double.infinity,
                          height: 5,
                          color: Color.fromARGB(255, 32, 32, 32),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: MemberList(members: members),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MemberList extends StatelessWidget {
  final List<UserResponse> members;
  const MemberList({required this.members});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: members.length,
      itemBuilder: (context, index) {
        final member = members[index];
        return ListTile(
          onTap: () => throw UnimplementedError(
              "Member profile functionality not implemented yet"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(member.profileicon.toString()),
          ),
          title: Text(
            "${member.firstname} ${member.lastname}",
            style: TextStyle(color: Colors.white),
          ),
          trailing: Transform.rotate(
            angle: 180 * 3.1415927 / 180,
            child: Icon(Icons.arrow_back_ios),
          ),
        );
      },
    );
  }
}
