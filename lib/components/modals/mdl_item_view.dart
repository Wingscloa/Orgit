import 'package:orgit/Components/Header/scroll_header.dart';
import 'package:orgit/Components/Header/show_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Itemview extends StatefulWidget {
  final String textHeader;
  final double headerFont;
  final String textFooter;
  final GestureTapCallback onTapFooter;
  late final List<Widget> cards;
  late final bool opened;

  Itemview(
      {required this.textHeader,
      required this.headerFont,
      required this.textFooter,
      required this.onTapFooter,
      required this.cards,
      this.opened = false});

  @override
  State<Itemview> createState() => _ItemviewState();
}

class _ItemviewState extends State<Itemview> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => {
                setState(() {
                  widget.opened = !widget.opened;
                }),
                print('ItemView : ${widget.opened}'),
              },
              child: Scrollheader(
                text: widget.textHeader,
                fontSize: widget.headerFont,
                isOpened: widget.opened,
              ),
            ),
          ],
        ),
        widget.opened
            ? Animate(
                effects: [
                  FadeEffect(duration: 350.ms),
                  // MoveEffect(curve: Curves.ease),
                  SlideEffect(
                      duration: 200.ms,
                      curve: Curves.easeInOut,
                      end: Offset.zero)
                ],
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 325,
                      height: 280,
                      child: SingleChildScrollView(
                        child: Column(children: widget.cards),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ShowHeader(
                        width: 212,
                        height: 1,
                        onTap: widget.onTapFooter,
                        panelColor: Colors.white38,
                        textColor: Color.fromARGB(255, 255, 203, 105),
                        text: 'Zobrazit více',
                        textSize: 20,
                        gap: 20),
                  ],
                ),
              )
            : Container()
      ],
    );
  }
}
