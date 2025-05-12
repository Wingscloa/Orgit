import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/overlays/overlay.dart';
import 'package:orgit/components/header/ovr_header.dart';
import 'package:orgit/components/button/default_button.dart';

class OverlaySilentMode extends StatefulOverlay {
  OverlaySilentMode({super.key});
  @override
  OverlaySilentModeState createState() => OverlaySilentModeState();
}

class OverlaySilentModeState extends State<OverlaySilentMode> {
  late ValueNotifier<MapEntry<String, int>?> selectNotify =
      ValueNotifier(MapEntry("_", -1));

  List<MapEntry<String, int>> options = [
    // bude brat z cache
    MapEntry("15 minut", 15),
    MapEntry("1 hodina", 60),
    MapEntry("2 hodina", 120),
    MapEntry("4 hodina", 240),
    MapEntry("8 hodina", 480),
    MapEntry("1 týden", 10080),
    MapEntry("Vlastní", 0),
  ];

  @override
  void initState() {
    super.initState();
    selectNotify.addListener(() {
      if (selectNotify.value?.value == 0) {
        print("Uzivatel chce vytvorit vlastni casovy usek");
      } else {
        print("Uzivatel zvolil : ${selectNotify.value}");
      }
    });
  }

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
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 45),
              child: OverlayHeader(
                label: "Tichý režim",
                onTap: widget.onClose,
              )),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: options.length * 50,
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) {
                final item = options[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: MuteOption(
                      groupValue: selectNotify.value,
                      value: item,
                      function: (value) {
                        setState(() {
                          selectNotify.value = value;
                        });
                      }),
                );
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Defaultbutton(
                  width: 170,
                  height: 50,
                  text: "Zrušit",
                  textColor: Colors.grey,
                  color: Color.fromARGB(255, 26, 27, 29),
                  onTap: () => {
                        print("ahoj"),
                      }),
              Defaultbutton(
                  width: 170,
                  height: 50,
                  text: "Uložit",
                  textColor: Colors.white,
                  color: Color.fromARGB(255, 255, 203, 105),
                  onTap: () => {
                        print("ahoj"),
                      }),
            ],
          )
        ]),
      ),
    );
  }
}

class MuteOption extends StatelessWidget {
  final MapEntry<String, int>? groupValue;
  final MapEntry<String, int> value;
  final Function(MapEntry<String, int>?) function;

  MuteOption(
      {required this.groupValue, required this.value, required this.function});

  @override
  Widget build(BuildContext context) {
    return RadioListTile<MapEntry<String, int>>(
      dense: true,
      activeColor: Color.fromARGB(255, 224, 176, 29),
      title: Text(
        value.key,
        style: Global.defaultStyle(16, true),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: (value) => function(value),
    );
  }
}
