import 'package:Orgit/Components/Inputs/modalInput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TitleInput extends StatefulWidget {
  final TextEditingController controller;
  late String value;
  Offset iconPos = Offset.zero;

  TitleInput({
    Key? key,
    required this.controller,
    required this.value,
  }) : super(key: key);

  @override
  State<TitleInput> createState() => TitleInputState();
  final GlobalKey<TitleInputState> key = GlobalKey<TitleInputState>();
}

class TitleInputState extends State<TitleInput> {
  GlobalKey titleKey = GlobalKey();
  bool? visible = null;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.iconPos == Offset.zero) {
        updateIcon();
      } else {
        visible = false;
      }
    });
  }

  void updateIcon() {
    setState(() {
      RenderBox box = titleKey.currentContext!.findRenderObject() as RenderBox;
      widget.iconPos =
          box.localToGlobal(Offset.zero) + box.size.bottomRight(Offset.zero);
      visible = true;
    });
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        showModalInput(context, widget.controller, widget.value, widget.key)
      },
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                key: titleKey,
                widget.controller.text.isEmpty
                    ? widget.value
                    : widget.controller.text,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Positioned(
            top: 29.5,
            left: 0 + widget.iconPos.dx - 5,
            child: Visibility(
              visible: visible == true,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
