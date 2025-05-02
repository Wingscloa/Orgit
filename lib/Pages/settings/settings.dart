import 'package:orgit/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:orgit/global_vars.dart';
import 'package:blur/blur.dart';
import 'package:orgit/components/overlays/ovr_notification.dart';
import 'package:orgit/pages/settings/components/section_header.dart';
import 'package:orgit/pages/settings/components/section_entry.dart';
import 'package:orgit/pages/settings/components/section_line.dart';
import 'package:orgit/utils/overlay_helper.dart';

class Settings extends StatelessWidget {
  static double marginItem = 35;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Global.background,
        bottomNavigationBar: Container(
          height: 55,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            color: Color.fromARGB(255, 35, 35, 35),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 35,
              ),
              InkWell(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Homepage(
                                initPage: 0,
                              )))
                },
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(
                width: marginItem,
              ),
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(
                        initPage: 1,
                      ),
                    ),
                  ),
                },
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(
                width: marginItem,
              ),
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(
                        initPage: 2,
                      ),
                    ),
                  ),
                },
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(
                width: marginItem,
              ),
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(
                        initPage: 3,
                      ),
                    ),
                  ),
                },
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              SizedBox(
                width: marginItem,
              ),
              InkWell(
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(
                        initPage: 4,
                      ),
                    ),
                  ),
                },
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Blur(
              blur: 4,
              blurColor: Color.fromARGB(255, 100, 100, 100),
              child: const Image(
                image: AssetImage('assets/map.png'),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 20),
                      child: Text(
                        "Nastavení",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 20, 22),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        // sekce nastaveni účet
                        SectionHeader(header: "Účet"),
                        SectionLine(),
                        Column(
                          spacing: 20,
                          children: [
                            SettingEntry(
                              icon: Icons.person,
                              label: "Profil",
                              onTap: () => Global.nothing(),
                            ),
                            SettingEntry(
                              icon: Icons.forum,
                              label: "Osobní údaje",
                              onTap: () => Global.nothing(),
                            ),
                            SettingEntry(
                              icon: Icons.shield,
                              label: "Zabezpečení",
                              onTap: () => Global.nothing(),
                            ),
                            SettingEntry(
                              icon: Icons.group,
                              label: "Role skupiny",
                              onTap: () => Global.nothing(),
                            ),
                          ],
                        ),
                        SectionLine(
                          pBot: 40,
                        ),
                        // sekce obecne nastaveni
                        SectionHeader(header: "Obecné nastavení"),
                        SectionLine(),
                        Column(
                          spacing: 20,
                          children: [
                            SettingEntry(
                              icon: Icons.notification_add,
                              label: "Upozornění",
                              onTap: () => OverlayHelper.showOverlay(
                                context,
                                OverlayNotification(),
                              ),
                            ),
                            SettingEntry(
                              icon: Icons.color_lens,
                              label: "Motiv",
                              onTap: () => Global.nothing(),
                            ),
                            SettingEntry(
                              icon: Icons.info,
                              label: "Informace o aplikaci",
                              onTap: () => Global.nothing(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}
