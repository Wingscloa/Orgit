import 'package:flutter/material.dart';
import '../../../constants.dart';

class Historylabel extends StatelessWidget {
  final String SearchHistory;

  const Historylabel({
    super.key,
    required this.SearchHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.4),
          borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.785,
        height: MediaQuery.of(context).size.height * 0.06,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 9),
              child: Row(
                children: [
                  Icon(Icons.alarm),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    SearchHistory,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 9),
              child: Icon(
                Icons.cancel,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
