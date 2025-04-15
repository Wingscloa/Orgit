import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatelessWidget {
  final GestureTapCallback? OnTap;
  final Uint8List? image;
  ImageInput({
    required this.OnTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: OnTap,
        child: Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 224, 176, 29)),
            borderRadius: BorderRadius.circular(65),
            color: Color.fromARGB(255, 53, 54, 55),
          ),
          // child: Center(
          //   child: image == null
          //       ? Image.asset('assets/addImage.png')
          //       : Image.memory(image!),
          // ),
          child: image == null
              ? Center(
                  child: Image.asset('assets/addImage.png'),
                )
              : Image.memory(image!),
        ));
  }
}
