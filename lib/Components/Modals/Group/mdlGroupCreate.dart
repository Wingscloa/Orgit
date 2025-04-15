import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:Orgit/Components/Cards/cardGroup.dart';
import 'package:Orgit/Components/Modals/searchResults/itemView.dart';
import 'package:Orgit/Components/Bar/SlideBar.dart';
import 'package:Orgit/Components/Inputs/imageInput.dart';
import 'package:image_picker/image_picker.dart';

class Mdlgroupcreate extends StatefulWidget {
  @override
  State<Mdlgroupcreate> createState() => _MdlgroupcreateState();
}

class _MdlgroupcreateState extends State<Mdlgroupcreate> {
  final _picker = ImagePicker();
  Uint8List? image;

  Future<void> _selectImage() async {
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (selectedImage != null) {
      image = await selectedImage.readAsBytes();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 19, 20, 22),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(27),
          topRight: Radius.circular(27),
        ),
      ),
      height: 725,
      width: double.infinity,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SlideBar(),
          ),
          Positioned(
            left: 55,
            top: 40,
            child: Text(
              'Vytvořit skupinu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageInput(
                      image: image,
                      OnTap: _selectImage,
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
