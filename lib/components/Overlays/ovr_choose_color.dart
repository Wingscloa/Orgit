import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:orgit/components/icons/role_icon.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/overlays/overlay.dart';

class OverlayChooseColor extends StatefulOverlay {
  final Color input;
  final Function(Color) onSelect;

  OverlayChooseColor({
    super.key,
    required this.input,
    required this.onSelect,
  });

  @override
  OverlayChooseColorState createState() => OverlayChooseColorState();
}

class OverlayChooseColorState extends State<OverlayChooseColor> {
  late Color _input;
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
    Colors.brown,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
  ];

  @override
  void initState() {
    super.initState();
    _input = widget.input;
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
                  SizedBox(height: 10),
                  Text(
                    "Vyber barvu",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (colors.length / 4).ceil() +
                          1, // +1 for custom color picker row
                      itemBuilder: (context, index) {
                        if (index == (colors.length / 4).ceil()) {
                          // Last row - custom color picker
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 9),
                            child: Wrap(
                              spacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final overlay = Overlay.of(context);
                                    OverlayEntry? entry;
                                    entry = OverlayEntry(
                                      builder: (context) => Positioned(
                                        top: 0,
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () => entry?.remove(),
                                                child: Container(
                                                  color: Colors.black
                                                      .withAlpha(120),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Container(
                                                  padding: EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    color: Global.settings,
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      top: Radius.circular(60),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        "Vlastní barva",
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      SizedBox(
                                                        height: 290,
                                                        child: ColorPicker(
                                                          pickerColor: _input,
                                                          onColorChanged:
                                                              (color) {
                                                            setState(() {
                                                              _input = color;
                                                              widget.onSelect(
                                                                  color);
                                                            });
                                                          },
                                                          enableAlpha: false,
                                                          displayThumbColor:
                                                              true,
                                                          portraitOnly: true,
                                                          colorPickerWidth: 300,
                                                          pickerAreaBorderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          labelTypes: const [],
                                                          pickerAreaHeightPercent:
                                                              0.7,
                                                          hexInputBar: false,
                                                          colorHistory: const [],
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      GestureDetector(
                                                        onTap: () =>
                                                            entry?.remove(),
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 12,
                                                                  horizontal:
                                                                      24),
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    203,
                                                                    105),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Text(
                                                            'Hotovo',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );

                                    overlay.insert(entry);
                                  },
                                  child: RoleIcon(
                                    width: 50,
                                    height: 50,
                                    color: Colors.grey[800]!,
                                    icon: Icons.colorize,
                                    iconColor: Colors.white,
                                    choosen: false,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        // Regular color rows
                        int startIndex = index * 4;
                        int endIndex = (index + 1) * 4;
                        List<Color> colorSublist;
                        if (endIndex < colors.length) {
                          colorSublist = colors.sublist(startIndex, endIndex);
                        } else {
                          colorSublist = colors.sublist(startIndex);
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Wrap(
                            spacing: 10,
                            alignment: WrapAlignment.center,
                            children: colorSublist.map((color) {
                              return RoleIcon(
                                width: 50,
                                height: 50,
                                color: _input != color
                                    ? color
                                    : color.withAlpha(100),
                                icon: Icons.color_lens,
                                iconColor: Colors.white,
                                choosen: color == _input,
                                function: () => {
                                  setState(() {
                                    _input = color;
                                    widget.onSelect(color);
                                  })
                                },
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
}
