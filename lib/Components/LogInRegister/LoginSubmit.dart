import 'package:flutter/material.dart';
import '../../constants.dart';

class LogInSubmit extends StatelessWidget {
  final bool register;
  final GestureTapCallback onTap;

  const LogInSubmit({
    super.key,
    required this.register,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(32, 49, 69, 0.15),
            borderRadius: BorderRadius.circular(12)),
        child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.785,
            height: MediaQuery.of(context).size.height * 0.08,
            child: Container(
              margin: EdgeInsets.only(left: PaddingSize, top: PaddingSize),
              child: Stack(
                children: [
                  Center(
                      child: Text(
                    register ? RegisterSubmit : LoginSubmit,
                    style: TextStyle(
                        fontSize: fontSize,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w500),
                  ))
                ],
              ),
            )),
      ),
    );
  }
}
