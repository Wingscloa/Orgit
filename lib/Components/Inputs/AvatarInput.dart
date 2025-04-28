import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarInput extends StatelessWidget {
  final GestureTapCallback? onTap;
  late Uint8List? image;
  AvatarInput({
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 130,
        width: 130,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(90),
            border: Border.all(color: Color.fromARGB(255, 224, 176, 29))),
        child: CircleAvatar(
          backgroundImage: image != null ? MemoryImage(image!) : null,
          backgroundColor: Color.fromARGB(255, 53, 54, 55),
          child: image != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 98, left: 95),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      color: Color.fromARGB(255, 255, 203, 105),
                    ),
                    child: SizedBox(
                      child: Icon(
                        size: 20,
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Image.asset('assets/addImage.png'),
        ),
      ),
    );
  }
}
