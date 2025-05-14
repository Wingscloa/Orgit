import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:orgit/Components/Button/default_button.dart';
import 'package:orgit/Pages/role/role_permission.dart';
import 'package:orgit/Pages/settings/components/section_line.dart';
import 'package:orgit/components/bar/top_bar_down.dart';
import 'package:orgit/components/icons/icon.dart';
import 'package:orgit/components/icons/role_icon.dart';
import 'package:orgit/components/overlays/ovr_choose_icon.dart';
import 'package:orgit/components/overlays/ovr_choose_color.dart';
import 'package:orgit/global_vars.dart';
import 'dart:math';
import 'package:orgit/utils/overlay_helper.dart';

class RoleCreate extends StatefulWidget {
  @override
  State<RoleCreate> createState() => _RoleCreateState();
}

class _RoleCreateState extends State<RoleCreate> {
  final name = TextEditingController();
  late final ValueNotifier<IconTransfer> icon = ValueNotifier(
    IconTransfer(
        icon: Icons.school,
        iconColor: Colors.white,
        backgroundColor: Colors.grey),
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Global.background,
      child: Column(
        spacing: 20,
        children: [
          TopBarDown(),
          Text(
            "Krok 1 z 3",
            style: Global.defaultStyle(20, true),
          ),
          Column(
            spacing: 5,
            children: [
              Text(
                "Vytvořit novou roli",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Color.fromARGB(255, 255, 203, 105),
                ),
              ),
              Text(
                "Dej této roli výstižný název a barvu. Později můžeš změnit!",
                style: TextStyle(
                  color: Global.settingsDescription,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
              SectionLine(),
            ],
          ),
          Column(
            spacing: 25,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                spacing: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.left,
                    "Název role".toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Global.settingsDescription,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Global.settingsDescription),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        maxLength: 20,
                        maxLines: 1,
                        decoration: null,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "např. člunař, kormidelník, lodivod, palubní",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Global.settingsDescription.withAlpha(100),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "IKONA ROLE".toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Global.settingsDescription,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => OverlayHelper.showOverlay(
                            context,
                            OverlayChooseIcon(
                              input: icon.value,
                              onSelect: (p0) => setState(() {
                                icon.value.icon = p0;
                              }),
                            ),
                          ),
                          child: Row(
                            children: [
                              RoleIcon(
                                color: icon.value.backgroundColor,
                                icon: icon.value.icon,
                                iconColor: icon.value.iconColor,
                              ),
                              Transform.rotate(
                                angle: pi,
                                child: Icon(
                                  size: 20,
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Používej ikony, které se na danou funkci hodí.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Global.settingsDescription.withAlpha(100),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BARVA POZADI IKONY".toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Global.settingsDescription,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => OverlayHelper.showOverlay(
                            context,
                            OverlayChooseColor(
                              input: icon.value.backgroundColor,
                              onSelect: (p0) => setState(() {
                                icon.value.backgroundColor = p0;
                              }),
                            ),
                          ),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: icon.value.backgroundColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '#${icon.value.backgroundColor.toHexString().replaceRange(0, 2, '')}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Transform.rotate(
                                angle: pi,
                                child: Icon(
                                  size: 20,
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Vyber barvu, která bude roli reprezentovat.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Global.settingsDescription.withAlpha(100),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BARVA IKONY".toUpperCase(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Global.settingsDescription,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => OverlayHelper.showOverlay(
                            context,
                            OverlayChooseColor(
                              input: icon.value.iconColor,
                              onSelect: (p0) => setState(() {
                                icon.value.iconColor = p0;
                              }),
                            ),
                          ),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: icon.value.iconColor,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    '#${icon.value.iconColor.toHexString().replaceRange(0, 2, '')}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Transform.rotate(
                                angle: pi,
                                child: Icon(
                                  size: 20,
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Vyber barvu, která bude roli reprezentovat.",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Global.settingsDescription.withAlpha(100),
                      ),
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // vytvori roli v DB, ktera muze byt v budoucnu zmenena, momentalne ji muze editovat
                        Defaultbutton(
                          text: "Vytvořit roli",
                          color: Color.fromARGB(255, 255, 203, 105),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => RolePermission(
                                      icon: icon,
                                      name: name.text,
                                    )));
                          },
                          width: 250,
                          height: 45,
                          textColor: Colors.black,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
