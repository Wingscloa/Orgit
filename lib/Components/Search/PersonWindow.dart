import 'package:flutter/material.dart';
import '../../constants.dart';

class PersonWindow extends StatelessWidget {
  final String name;
  final String description;

  const PersonWindow({
    super.key,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 0.75),
              borderRadius: BorderRadius.circular(8)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.09,
            child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: fontSize * 1.25),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            description,
                            style: TextStyle(
                                color: Color.fromARGB(125, 255, 255, 255)),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }
}
