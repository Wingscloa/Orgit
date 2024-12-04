import 'package:flutter/material.dart';
import '../../constants.dart';

class Logininput extends StatelessWidget {
  final String title;
  final String hint;
  final bool password;

  const Logininput({
    super.key,
    required this.title,
    required this.hint,
    required this.password,
  });

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
                  title,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: Color.fromARGB(255, 255, 255, 255)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    autocorrect: false,
                    obscureText: password,
                    style: TextStyle(
                        fontSize: fontSize - 0.1,
                        color: Color.fromARGB(180, 255, 255, 255)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hint,
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
