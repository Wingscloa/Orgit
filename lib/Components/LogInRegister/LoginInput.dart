import 'package:flutter/material.dart';
import '../../constants.dart';

class Logininput extends StatefulWidget {
  final String title;
  final String hint;
  final bool password;
  final TextEditingController controller;

  const Logininput({
    super.key,
    required this.title,
    required this.hint,
    required this.password,
    required this.controller,
  });

  @override
  State<Logininput> createState() => _LogininputState();
}

class _LogininputState extends State<Logininput> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 241, 173, 0.1),
          borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.785,
          height: MediaQuery.of(context).size.height * 0.08,
          child: Container(
            margin: EdgeInsets.only(left: PaddingSize, top: PaddingSize),
            child: Stack(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: widget.controller,
                    autocorrect: false,
                    obscureText: widget.password,
                    style: TextStyle(
                        fontSize: fontSize - 0.1,
                        color: Color.fromARGB(180, 255, 255, 255)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hint,
                      hintStyle:
                          TextStyle(color: Color.fromARGB(112, 255, 255, 255)),
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
