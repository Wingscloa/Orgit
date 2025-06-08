import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';
import 'dart:io';

class ProfileIcon extends StatelessWidget {
  final VoidCallback onTap;
  final XFile? selectedImage;

  const ProfileIcon({
    super.key,
    required this.onTap,
    this.selectedImage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: ResponsiveUtils.isSmallScreen(context) ? 50 : 60,
              backgroundImage: selectedImage != null
                  ? FileImage(File(selectedImage!.path))
                  : AssetImage('assets/profileIcon.png') as ImageProvider,
              backgroundColor: Color.fromARGB(255, 53, 54, 55),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: ResponsiveUtils.isSmallScreen(context) ? 30 : 35,
                height: ResponsiveUtils.isSmallScreen(context) ? 30 : 35,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 255, 203, 105),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                    size: ResponsiveUtils.isSmallScreen(context) ? 16 : 20,
                  ),
                  onPressed: onTap,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
