import 'package:Orgit/Pages/Main/homepage.dart';
import 'package:flutter/material.dart';
import 'package:Orgit/statics.dart';

class Settings extends StatelessWidget {
  static double marginItem = 35;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Statics.background,
      bottomNavigationBar: Container(
        height: 55,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          color: Color.fromARGB(255, 35, 35, 35),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 35,
            ),
            InkWell(
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Homepage(
                              initPage: 0,
                            )))
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: marginItem,
            ),
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(
                      initPage: 1,
                    ),
                  ),
                ),
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: marginItem,
            ),
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(
                      initPage: 2,
                    ),
                  ),
                ),
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: marginItem,
            ),
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(
                      initPage: 3,
                    ),
                  ),
                ),
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
            SizedBox(
              width: marginItem,
            ),
            InkWell(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(
                      initPage: 4,
                    ),
                  ),
                ),
              },
              child: Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 40,
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(),
    );
  }
}
