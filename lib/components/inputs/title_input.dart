import 'package:orgit/components/inputs/modal_input.dart';
import 'package:flutter/material.dart';

class TitleInput extends StatefulWidget {
  final TextEditingController controller;
  final String value;
  final Offset iconPos;

  TitleInput({
    this.iconPos = Offset.zero,
    required this.controller,
    required this.value,
  });

  @override
  State<TitleInput> createState() => TitleInputState();
  final GlobalKey<TitleInputState> globalkey = GlobalKey<TitleInputState>();
}

class TitleInputState extends State<TitleInput> {
  late Offset _iconPos;
  GlobalKey titleKey = GlobalKey();

  bool? visible;
  @override
  void initState() {
    super.initState();
    _iconPos = widget.iconPos;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_iconPos == Offset.zero) {
        updateIcon();
      } else {
        visible = false;
      }
    });
  }

  void updateIcon() {
    setState(() {
      RenderBox box = titleKey.currentContext!.findRenderObject() as RenderBox;
      _iconPos =
          box.localToGlobal(Offset.zero) + box.size.bottomRight(Offset.zero);
      visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
        showModalInput(
            context, widget.controller, widget.value, widget.globalkey)
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
            left: 0 + _iconPos.dx - 5,
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
