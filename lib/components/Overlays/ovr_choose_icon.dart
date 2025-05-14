import 'package:flutter/material.dart';
import 'package:orgit/Pages/role/role.dart';
import 'package:orgit/components/icons/role_icon.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/icons/icon.dart';
import 'package:orgit/components/overlays/overlay.dart';

class OverlayChooseIcon extends StatefulOverlay {
  final IconTransfer input;
  final Function(IconData) onSelect;
  OverlayChooseIcon({
    super.key,
    required this.input,
    required this.onSelect,
  });
  @override
  OverlayChooseIconState createState() => OverlayChooseIconState();
}

class OverlayChooseIconState extends State<OverlayChooseIcon> {
  late IconData _input;
  late List<IconTransfer> icons;

  @override
  void initState() {
    super.initState();
    _input = widget.input.icon;
    icons = [
      IconTransfer(
        icon: Icons.anchor,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.sailing,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.directions_boat,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.water,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.waves,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.beach_access,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.kayaking,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.surfing,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.water_drop,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.pool,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.water_damage,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.flood,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.tsunami,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.water_outlined,
        iconColor: widget.input.iconColor,
        backgroundColor: widget.input.backgroundColor,
      ),
      IconTransfer(
        icon: Icons.more_horiz,
        iconColor: Colors.white,
        backgroundColor: Colors.black,
      ),
    ];
  }

  @override
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
                                color: widget.input != item.icon
                                    ? item.backgroundColor
                                    : item.backgroundColor.withAlpha(100),
                                icon: item.icon,
                                iconColor: widget.input != item.icon
                                    ? item.iconColor
                                    : item.iconColor.withAlpha(100),
                                choosen: item.icon == _input,
                                function: icons.last != item
                                    ? () {
                                        setState(() {
                                          _input = item.icon;
                                          widget.onSelect(item.icon);
                                        });
                                      }
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

  void previewIcons() {
    print("preview Icon");
  }
}
