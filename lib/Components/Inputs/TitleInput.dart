import 'package:Orgit/Components/Inputs/modalInput.dart';
import 'package:flutter/material.dart';

class TitleInput extends StatefulWidget {
  final TextEditingController controller;
  late String value;

  TitleInput({
    required this.controller,
    required this.value,
  });

  @override
  State<TitleInput> createState() => _TitleInputState();
}

class _TitleInputState extends State<TitleInput> {
  GlobalKey titleKey = GlobalKey();
  Offset iconPos = Offset.zero;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateIcon();
    });
  }

  void updateIcon() {
    setState(() {
      RenderBox box = titleKey.currentContext!.findRenderObject() as RenderBox;
      iconPos =
          box.localToGlobal(Offset.zero) + box.size.bottomRight(Offset.zero);
    });
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {showModalInput(context, widget.controller, widget.value)},
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
              left: 0 + iconPos.dx - 5,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 19,
              ))
        ],
      ),
    );
  }
}
