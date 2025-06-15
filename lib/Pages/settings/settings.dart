import 'package:orgit/components/overlays/ovr_motive.dart';
import 'package:orgit/components/overlays/ovr_role_creator.dart';
import 'package:orgit/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:orgit/global_vars.dart';
import 'package:blur/blur.dart';
import 'package:orgit/components/overlays/ovr_notification.dart';
import 'package:orgit/pages/settings/components/section_header.dart';
import 'package:orgit/pages/settings/components/section_entry.dart';
import 'package:orgit/pages/settings/components/section_line.dart';
import 'package:orgit/utils/overlay_helper.dart';
import 'package:orgit/components/Overlays/ovr_information_app.dart';
import 'package:orgit/utils/responsive_utils.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/Pages/Auth/Register.dart'; // Import pro stránku registrace

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int selectedIndex = -1;
  final AuthService _authService = AuthService();
  Future<void> _signOut(BuildContext context) async {
    try {
      await _authService.signOut();
      // Přesměrování na stránku registrace
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Register()),
          (route) => false);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Chyba při odhlašování: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Global.background,
        bottomNavigationBar: Container(
          height: ResponsiveUtils.isSmallScreen(context) ? 60 : 70,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            color: Color.fromARGB(255, 35, 35, 35),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(context, 0, Icons.calendar_month),
              _buildNavItem(context, 1, Icons.event),
              _buildNavItem(context, 2, Icons.group),
              _buildNavItem(context, 3, Icons.checklist),
              _buildNavItem(context, 4, Icons.person),
            ],
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Blur(
              blur: ResponsiveUtils.isSmallScreen(context) ? 3 : 4,
              blurColor: Color.fromARGB(255, 100, 100, 100),
              child: const Image(
                image: AssetImage('assets/backgroundMap.png'),
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: ResponsiveUtils.getPaddingVertical(context) * 2,
                    left: ResponsiveUtils.getPaddingHorizontal(context),
                    right: ResponsiveUtils.getPaddingHorizontal(context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: ResponsiveUtils.getIconSize(context) * 0.8,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: ResponsiveUtils.getPaddingHorizontal(context),
                        top: ResponsiveUtils.getSpacingMedium(context),
                      ),
                      child: Text(
                        "Nastavení",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.getHeadingFontSize(context),
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ResponsiveUtils.getSpacingLarge(context) * 0.75,
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
                          height:
                              ResponsiveUtils.getSpacingMedium(context) * 0.8,
                        ),
                        SectionHeader(header: "Účet"),
                        SectionLine(),
                        Column(
                          children: [
                            SettingEntry(
                              icon: Icons.person,
                              label: "Profil",
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Homepage(initPage: 3),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingMedium(context) *
                                        0.8),
                            SettingEntry(
                              icon: Icons.forum,
                              label: "Osobní údaje",
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Homepage(initPage: 3),
                                ),
                              ),
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingMedium(context) *
                                        0.8),
                            SettingEntry(
                              icon: Icons.shield,
                              label: "Zabezpečení",
                              onTap: () => Global.nothing(),
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingMedium(context) *
                                        0.8),
                            SettingEntry(
                              icon: Icons.group,
                              label: "Role skupiny",
                              onTap: () => OverlayHelper.showOverlay(
                                context,
                                OverlayRoleCreate(),
                              ),
                            ),
                          ],
                        ),
                        SectionLine(
                          pBot: ResponsiveUtils.getSpacingLarge(context),
                        ),
                        SectionHeader(header: "Obecné nastavení"),
                        SectionLine(),
                        Column(
                          children: [
                            SettingEntry(
                              icon: Icons.notification_add,
                              label: "Upozornění",
                              onTap: () => OverlayHelper.showOverlay(
                                context,
                                OverlayNotification(),
                              ),
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingMedium(context) *
                                        0.8),
                            SettingEntry(
                              icon: Icons.color_lens,
                              label: "Motiv",
                              onTap: () => OverlayHelper.showOverlay(
                                context,
                                OverlayMotive(),
                              ),
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingMedium(context) *
                                        0.8),
                            SettingEntry(
                              icon: Icons.info,
                              label: "Informace o aplikaci",
                              onTap: () => OverlayHelper.showOverlay(
                                context,
                                OverlayInformationApp(),
                              ),
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingMedium(context) *
                                        0.8),
                            SettingEntry(
                              icon: Icons.logout,
                              label: "Odhlásit se",
                              onTap: () => _signOut(context),
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

  Widget _buildNavItem(BuildContext context, int index, IconData icon) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => _onTapNavItem(index),
      child: Container(
        padding: EdgeInsets.all(ResponsiveUtils.getSpacingSmall(context)),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 255, 203, 105).withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isSelected ? Color.fromARGB(255, 255, 203, 105) : Colors.white,
          size: ResponsiveUtils.getIconSize(context),
        ),
      ),
    );
  }

  void _onTapNavItem(int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Homepage(
          initPage: index,
        ),
      ),
    );
  }
}
