import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  IconData icon;
  final Color iconColor;
  bool obscureText;
  bool showObscureText;
  bool changePassword;

  FormInput(
      {required this.labelText,
      required this.controller,
      required this.iconColor,
      this.changePassword =
          false, // highest priority,  if true => shows up as password, icons (eye of visibility), // show ups change password text
      this.showObscureText = false,
      this.obscureText = false,
      this.icon = Icons.check});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
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
              widget.changePassword
                  ? InkWell(
                      onTap: () {
                        print('Change Password');
                      },
                      child: Text(
                        'Zapomenuté heslo?',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 203, 105),
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
              width: 270,
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  obscureText: widget.obscureText,
                  decoration: null,
                  controller: widget.controller,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  cursorHeight: 25,
                  cursorColor: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Container(
              width: 30,
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: InkWell(
                onTap: widget.showObscureText
                    ? () => (setState(() {
                          widget.obscureText = !widget.obscureText;
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
}
