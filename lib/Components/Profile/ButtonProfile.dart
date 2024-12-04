import 'package:flutter/material.dart';
import '../../constants.dart';

class ButtonProfile extends StatelessWidget {
  final IconData icon;
  final String header;
  final PageRoute? page;

  const ButtonProfile({
    super.key,
    required this.icon,
    required this.header,
    this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          print("Button Profile");
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(107, 66, 38, 1),
                  borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.09,
                height: MediaQuery.of(context).size.height * 0.045,
                child: Center(
                  child: Icon(
                    icon,
                    color: Color.fromARGB(255, 196, 196, 196),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Text(
                header,
                style: TextStyle(
                  fontSize: fontSize / 1.5,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ));
  }
}
