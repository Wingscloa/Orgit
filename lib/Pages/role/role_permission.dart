import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orgit/Components/Button/default_button.dart';
import 'package:orgit/Pages/role/role_user.dart';
import 'package:orgit/Pages/settings/components/section_line.dart';
import 'package:orgit/components/bar/top_bar_down.dart';
import 'package:orgit/components/icons/icon.dart';
import 'package:orgit/global_vars.dart';

class RolePermission extends StatefulWidget {
  final String name;
  final ValueNotifier<IconTransfer> icon;
  RolePermission({
    required this.name,
    required this.icon,
  });
  @override
  State<RolePermission> createState() => _RolePermissionState();
}

class Permissions {
  final String name;
  Permissions({
    required this.name,
  });
}

class Role {
  final String name;
  final List<Permissions> perms;

  Role({
    required this.name,
    required this.perms,
  });
}

class _RolePermissionState extends State<RolePermission> {
  int selectedRoleIndex = -1;
  List<Permissions> allPermissions = [
    Permissions(name: "Vytvářet události"),
    Permissions(name: "Upravovat události"),
    Permissions(name: "Mazat události"),
    Permissions(name: "Spravovat členy"),
    Permissions(name: "Spravovat role"),
    Permissions(name: "Vytvářet úkoly"),
    Permissions(name: "Upravovat úkoly"),
    Permissions(name: "Mazat úkoly"),
    Permissions(name: "Spravovat nastavení"),
    Permissions(name: "Zobrazit statistiky"),
    Permissions(name: "Spravovat pozvánky"),
    Permissions(name: "Spravovat oznámení"),
  ];

  List<Role> testRoles = [
    Role(
      name: "Admin",
      perms: [
        Permissions(name: "Vytvářet události"),
        Permissions(name: "Upravovat události"),
        Permissions(name: "Mazat události"),
        Permissions(name: "Spravovat členy"),
        Permissions(name: "Spravovat role"),
      ],
    ),
    Role(
      name: "Moderátor",
      perms: [
        Permissions(name: "Vytvářet události"),
        Permissions(name: "Upravovat události"),
        Permissions(name: "Vytvářet úkoly"),
        Permissions(name: "Upravovat úkoly"),
      ],
    ),
    Role(
      name: "Člen",
      perms: [
        Permissions(name: "Vytvářet události"),
        Permissions(name: "Vytvářet úkoly"),
      ],
    ),
    Role(
      name: "VIP",
      perms: [
        Permissions(name: "Vytvářet události"),
        Permissions(name: "Upravovat události"),
        Permissions(name: "Vytvářet úkoly"),
        Permissions(name: "Upravovat úkoly"),
        Permissions(name: "Zobrazit statistiky"),
        Permissions(name: "Spravovat oznámení"),
      ],
    ),
    Role(
      name: "Host",
      perms: [
        Permissions(name: "Vytvářet události"),
      ],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Global.background,
        child: Column(
          spacing: 20,
          children: [
            TopBarDown(),
            Text(
              "Krok 2 z 3",
              style: Global.defaultStyle(20, true),
            ),
            Column(
              spacing: 5,
              children: [
                Text(
                  "Nastavit oprávnění",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Color.fromARGB(255, 255, 203, 105),
                  ),
                ),
                Text(
                  "Dej této roli určitá oprávnění, co může dělat místo tebe!",
                  style: TextStyle(
                    color: Global.settingsDescription,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                SectionLine(),
              ],
            ),
            Center(
              child: SizedBox(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: LayoutBuilder(builder: (context, constraints) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: testRoles.length,
                    controller: ScrollController(initialScrollOffset: 75),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedRoleIndex = index;
                          });
                        },
                        child: Container(
                          height: 400,
                          width: 300,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Global.settingsButton,
                            borderRadius: BorderRadius.circular(8),
                            border: selectedRoleIndex == index
                                ? Border.all(
                                    color: Color.fromARGB(255, 255, 203, 105),
                                    width: 2)
                                : null,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  testRoles[index].name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: LayoutBuilder(
                                    builder: (context, constraints) {
                                  return ListView.builder(
                                    // Disable scrolling if content fits in container
                                    physics:
                                        testRoles[index].perms.length * 56.0 <=
                                                constraints.maxHeight
                                            ? NeverScrollableScrollPhysics()
                                            : ScrollPhysics(),
                                    itemCount: testRoles[index].perms.length,
                                    itemBuilder: (context, permIndex) {
                                      return ListTile(
                                        title: Text(
                                          testRoles[index]
                                              .perms[permIndex]
                                              .name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        leading: Icon(
                                          Icons.check,
                                          color: Color.fromARGB(
                                              255, 255, 203, 105),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 20,
              children: [
                Defaultbutton(
                  text: "Uložit",
                  color: Color.fromARGB(255, 255, 203, 105),
                  onTap: () {
                    if (selectedRoleIndex == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Prosím vyberte kartu nebo vytvořte nové oprávnění',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      );
                      return;
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RoleUser(RoleId: 10)));
                    }
                  },
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 45,
                  textColor: Colors.black,
                ),
                Defaultbutton(
                  text: "Nové oprávnění",
                  color: Global.settingsButton,
                  onTap: () {
                    Navigator.pop(context);
                  },
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 45,
                  textColor: Colors.white.withAlpha(200),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
