import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final IconData icon;
  final Color iconColor;
  final bool obscureText;
  final bool showObscureText;
  final bool changePassword;
  final bool readonly;
  final bool dateInput;
  final String righText;
  final Color rightTextColor;
  final GestureTapCallback? righTextOnTap;

  FormInput(
      {required this.labelText,
      required this.controller,
      required this.iconColor,
      this.righTextOnTap,
      this.changePassword =
          false, // highest priority,  if true => shows up as password, icons (eye of visibility), // show ups change password text
      this.showObscureText = false,
      this.obscureText = false,
      this.readonly = false,
      this.dateInput = false,
      this.righText = "",
      this.rightTextColor = const Color.fromARGB(255, 255, 203, 105),
      this.icon = Icons.check});
  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  late bool _obscureText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 2.5, left: 8, right: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.labelText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Color.fromARGB(255, 87, 88, 90),
                ),
              ),
              widget.righText.isNotEmpty
                  ? InkWell(
                      onTap: widget.righTextOnTap,
                      child: Text(
                        widget.righText,
                        style: TextStyle(
                          color: widget.rightTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFormField(
                  onTap: widget.dateInput
                      ? () => _selectDate()
                      : () => print('ahoj'),
                  readOnly: widget.readonly,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    border: InputBorder.none, // Odstranění čáry pod textem
                  ),
                  controller: widget.controller,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  cursorHeight: 25,
                  cursorColor: Colors.white.withAlpha(125),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.08,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: InkWell(
                onTap: widget.showObscureText
                    ? () => (setState(() {
                          _obscureText = !_obscureText;
                        }))
                    : () => (),
                child: Icon(
                  widget.showObscureText
                      ? widget.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off
                      : widget.icon,
                  color: widget.iconColor,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        widget.controller.text = picked.toString().split(" ")[0];
      });
    }
  }
}
