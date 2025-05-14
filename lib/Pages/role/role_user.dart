import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:orgit/Components/Button/default_button.dart';
import 'package:orgit/Pages/Auth/profile_form.dart';
import 'package:orgit/Pages/settings/components/section_line.dart';
import 'package:orgit/components/bar/top_bar_down.dart';
import 'package:orgit/components/icons/icon.dart';
import 'package:orgit/components/inputs/custom_searchbar.dart';
import 'package:orgit/global_vars.dart';

class RoleUser extends StatefulWidget {
  final int RoleId;
  RoleUser({
    required this.RoleId,
  });
  @override
  State<RoleUser> createState() => _RoleUserState();
}

class _RoleUserState extends State<RoleUser> {
  List<int> selectedUsers = [];
  TextEditingController search = TextEditingController();
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
              "Krok 3 z 3",
              style: Global.defaultStyle(20, true),
            ),
            Column(
              spacing: 5,
              children: [
                Text(
                  "Přidat členům",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 32,
                    color: Color.fromARGB(255, 255, 203, 105),
                  ),
                ),
                Text(
                  "Přiřaď tuto roli svým členům.",
                  style: TextStyle(
                    color: Global.settingsDescription,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                SectionLine(),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Customsearchbar(
                hintText: "Hledat člena",
                controller: search,
                suggestions: ["ahoj", "prdelko", "pookie", "ojel bych te"],
              ),
            ),
            SizedBox(
              height: 350,
              width: MediaQuery.of(context).size.width * 0.95,
              child: ListView.builder(
                itemCount: 12,
                itemBuilder: (context, index) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 27, 29),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage("assets/profile.png"),
                        backgroundColor: Color.fromARGB(255, 53, 54, 55),
                      ),
                      title: Text(
                        "Vicko",
                        style: Global.defaultStyle(16, true),
                      ),
                      subtitle: Text(
                        "Simon Bumba",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withAlpha(122),
                        ),
                      ),
                      trailing: Checkbox(
                        value: selectedUsers.contains(index),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedUsers.add(index);
                            } else {
                              selectedUsers.remove(index);
                            }
                          });
                        },
                        fillColor:
                            WidgetStatePropertyAll(Colors.white.withAlpha(40)),
                      ),
                    ),
                  ),
                ),
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
                    if (selectedUsers.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              'Prosím vyberte alespoň jednoho uživatele',
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
                    }
                    Navigator.pop(context);
                  },
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: 45,
                  textColor: Colors.black,
                ),
                Defaultbutton(
                  text: "Přeskočit tento krok",
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
