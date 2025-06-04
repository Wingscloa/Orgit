import 'package:orgit/Components/inputs/modal_input.dart';
import 'package:flutter/material.dart';

class TitleInput extends StatefulWidget {
  final TextEditingController controller;
  final String value;
  final Offset iconPos;
  final int maxLength;

  TitleInput({
    this.iconPos = Offset.zero,
    required this.controller,
    required this.value,
    this.maxLength = 50,
    Key? key,
  }) : super(key: key);

  @override
  State<TitleInput> createState() => TitleInputState();
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
        showModalInput(context, widget.controller, widget.value, updateIcon)
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              key: titleKey,
              widget.controller.text.isEmpty
                  ? widget.value
                  : widget.controller.text.length > widget.maxLength
                      ? '${widget.controller.text.substring(0, widget.maxLength)}...'
                      : widget.controller.text,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8),
          Visibility(
            visible: visible == true,
            child: Icon(
              Icons.edit,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
