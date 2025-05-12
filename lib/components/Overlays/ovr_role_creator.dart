import 'dart:ui';
import 'package:orgit/Pages/role/role.dart';
import 'package:orgit/Components/Button/default_button.dart';
import 'package:orgit/components/icons/role_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/overlays/overlay.dart';
import 'package:orgit/components/header/ovr_header.dart';
import 'dart:math';

class OverlayRoleCreate extends StatefulOverlay {
  OverlayRoleCreate({super.key});
  @override
  OverlayRoleCreateState createState() => OverlayRoleCreateState();
}

class OverlayRoleCreateState extends State<OverlayRoleCreate> {
  List<Role> roles = [
    Role(
        name: "Majitel",
        backgroundColor: Colors.red,
        icon: Icons.kayaking,
        iconColor: Colors.white,
        count: 1),
    Role(
        name: "Group moderátor",
        backgroundColor: Colors.green,
        icon: Icons.group,
        iconColor: Colors.white,
        count: 3),
    Role(
        name: "Report operátor",
        backgroundColor: Colors.black,
        icon: Icons.warning_outlined,
        iconColor: Colors.yellow,
        count: 1),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5)
  ];
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        animationDuration: 0.ms,
        borderOnForeground: false,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(60),
          topRight: const Radius.circular(60),
        ),
        elevation: 20,
        color: Global.settings,
        child: Column(
          spacing: 35,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 45),
              child: OverlayHeader(
                label: "Role skupiny",
                onTap: widget.onClose,
              ),
            ),
            roles.isNotEmpty ? RoleGroup(roles: roles) : RoleGroupNull()
          ],
        ),
      ),
    );
  }
}

class RoleGroupNull extends StatelessWidget {
  const RoleGroupNull({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 70,
      children: [
        SizedBox(
          height: 30,
        ),
        Image(
          image: AssetImage(
            'assets/RoleGroupBackground.png',
          ),
        ),
        Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Rozděl práci mezi ostatní",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 203, 105),
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                textAlign: TextAlign.center,
                "Rozdělování práce je základ každého dobrého organizování. Používej role k jednoduššímu rozdělení prací. ",
                style: TextStyle(
                  color: Global.settingsDescription,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.center,
          child: Defaultbutton(
              text: "Vytvořit roli",
              color: Color.fromARGB(255, 255, 203, 105),
              onTap: () => print("Vytvořit roli"),
              width: MediaQuery.of(context).size.width * 0.85,
              textColor: Colors.black,
              height: 40),
        ),
      ],
    );
  }
}

class RoleGroup extends StatelessWidget {
  const RoleGroup({
    super.key,
    required this.roles,
  });

  final List<Role> roles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          spacing: 5,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Rozděl práci mezi ostatní",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 203, 105),
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  "Rozdělování práce je základ každého dobrého organizování. Používej role k jednoduššímu rozdělení prací. ",
                  style: TextStyle(
                    color: Colors.grey.withAlpha(125),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 6 * 75,
          child: ListView.builder(
            itemCount: roles.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RoleContainer(
                  header: roles[index].name,
                  count: roles[index].count,
                  icon: roles[index].icon,
                  iconColor: roles[index].iconColor,
                  iconBackground: roles[index].backgroundColor,
                ),
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Defaultbutton(
              text: "Vytvořit novou roli",
              color: Color.fromARGB(255, 255, 203, 105),
              onTap: () => print("Vytvorit novou roli"),
              width: MediaQuery.of(context).size.width * 0.85,
              textColor: Colors.black,
              height: 40),
        ),
      ],
    );
  }
}

class RoleContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String header;
  final int count;
  const RoleContainer({
    required this.header,
    required this.count,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("neco se ma stat"),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Global.settingsButton,
          border: Border.all(
            color: Colors.white.withAlpha(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.white.withAlpha(10),
              offset: Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: 15,
                children: [
                  RoleIcon(
                    color: iconBackground,
                    icon: icon,
                    iconColor: iconColor,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        header,
                        style: Global.defaultStyle(16, true),
                      ),
                      Text(
                        countToText(count),
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.withAlpha(140),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Transform.rotate(
                  angle: pi,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String countToText(int count) {
    if (count == 1) {
      return "$count člen";
    } else if (count < 5) {
      return "$count členové";
    } else {
      return "$count členu";
    }
  }
}
