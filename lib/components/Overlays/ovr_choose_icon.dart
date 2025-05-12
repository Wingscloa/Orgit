import 'package:flutter/material.dart';
import 'package:orgit/Pages/role/role.dart';
import 'package:orgit/components/icons/role_icon.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/icons/icon.dart';
import 'package:orgit/components/overlays/overlay.dart';

class OverlayChooseIcon extends StatefulOverlay {
  late final ValueNotifier<IconTransfer> input;
  final Function(IconTransfer) onSelect;
  OverlayChooseIcon({
    super.key,
    required this.input,
    required this.onSelect,
  });
  @override
  OverlayChooseIconState createState() => OverlayChooseIconState();
}

class OverlayChooseIconState extends State<OverlayChooseIcon> {
  List<IconTransfer> icons = [
    IconTransfer(
      icon: Icons.person,
      iconColor: Colors.white,
      backgroundColor: Colors.blueAccent,
    ),
    IconTransfer(
      icon: Icons.settings,
      iconColor: Colors.white,
      backgroundColor: Colors.grey,
    ),
    IconTransfer(
      icon: Icons.notifications,
      iconColor: Colors.white,
      backgroundColor: Colors.deepOrange,
    ),
    IconTransfer(
      icon: Icons.chat,
      iconColor: Colors.white,
      backgroundColor: Colors.green,
    ),
    IconTransfer(
      icon: Icons.map,
      iconColor: Colors.white,
      backgroundColor: Colors.purple,
    ),
    IconTransfer(
      icon: Icons.camera_alt,
      iconColor: Colors.white,
      backgroundColor: Colors.teal,
    ),
    IconTransfer(
      icon: Icons.favorite,
      iconColor: Colors.white,
      backgroundColor: Colors.redAccent,
    ),
    IconTransfer(
      icon: Icons.music_note,
      iconColor: Colors.white,
      backgroundColor: Colors.indigo,
    ),
    IconTransfer(
      icon: Icons.work,
      iconColor: Colors.white,
      backgroundColor: Colors.brown,
    ),
    IconTransfer(
      icon: Icons.flight,
      iconColor: Colors.white,
      backgroundColor: Colors.cyan,
    ),
    IconTransfer(
      icon: Icons.shopping_cart,
      iconColor: Colors.white,
      backgroundColor: Colors.pinkAccent,
    ),
    IconTransfer(
      icon: Icons.language,
      iconColor: Colors.white,
      backgroundColor: Colors.lightBlue,
    ),
    IconTransfer(
      icon: Icons.calendar_today,
      iconColor: Colors.white,
      backgroundColor: Colors.deepPurple,
    ),
    IconTransfer(
      icon: Icons.lock,
      iconColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    IconTransfer(
      icon: Icons.book,
      iconColor: Colors.white,
      backgroundColor: Colors.amber,
    ),
    IconTransfer(
      icon: Icons.more_horiz,
      iconColor: Colors.white,
      backgroundColor: Colors.black,
    ),
  ];
  @override
  void initState() {
    super.initState();
    widget.input.addListener(() => setState(() {}));
  }

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onClose,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withAlpha(130),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                color: Global.settings,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Vyber ikonu",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (icons.length / 4).ceil(),
                      itemBuilder: (context, index) {
                        int startIndex = index * 4;
                        int endIndex = (index + 1) * 4;
                        List<IconTransfer> iconSublist;
                        if (endIndex < icons.length) {
                          // not out of index
                          iconSublist = icons.sublist(startIndex, endIndex);
                        } else {
                          // out of index
                          iconSublist = icons.sublist(startIndex);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Wrap(
                            spacing: 10,
                            alignment: WrapAlignment.center,
                            children: iconSublist.map((item) {
                              return RoleIcon(
                                width: 50,
                                height: 50,
                                color: widget.input != item
                                    ? item.backgroundColor
                                    : item.backgroundColor.withAlpha(100),
                                icon: item.icon,
                                iconColor: widget.input != item
                                    ? item.iconColor
                                    : item.iconColor.withAlpha(100),
                                choosen: item == widget.input.value,
                                function: icons.last != item
                                    ? () => widget.onSelect(item)
                                    : () => previewIcons(),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void chooseIcon(IconTransfer iconSelf) {
    setState(() {
      widget.input.value = iconSelf;
    });
  }

  void previewIcons() {
    print("preview Icon");
  }
}
