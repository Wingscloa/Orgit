import 'package:flutter/material.dart';
import '../../constants.dart';

class SearchField extends StatelessWidget {
  final String recommendation;

  const SearchField({
    super.key,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 46, 102, 0.15),
          borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.785,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Container(
          margin: EdgeInsets.only(left: 20),
          child: Row(children: [
            Icon(
              Icons.search,
              color: Colors.white,
              size: 40,
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: TextField(
                autocorrect: false,
                style: TextStyle(
                    fontSize: fontSize - 0.1,
                    color: Color.fromARGB(180, 255, 255, 255)),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: recommendation,
                  hintStyle:
                      TextStyle(color: Color.fromARGB(112, 255, 255, 255)),
                ),
              ),
            )
          ]),
        ),
      ),
    ); // ),
  }
}
