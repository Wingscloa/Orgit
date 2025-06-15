import 'package:flutter/material.dart';
import 'package:orgit/utils/responsive_utils.dart';

class Avatar extends StatelessWidget {
  final ImageProvider image;

  const Avatar({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
          border: Border.all(
            color: Color.fromARGB(255, 224, 176, 29),
            width: 2,
          ),
        ),
        height: ResponsiveUtils.isSmallScreen(context) ? 120 : 140,
        width: ResponsiveUtils.isSmallScreen(context) ? 120 : 140,
        child: CircleAvatar(
          backgroundImage: image,
          backgroundColor: Color.fromARGB(255, 53, 54, 55),
        ),
      ),
    );
  }
}
