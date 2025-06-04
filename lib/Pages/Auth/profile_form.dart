import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:orgit/Components/Feature/bottom_dots.dart';
import 'package:orgit/Components/Inputs/from_input.dart';
import 'package:orgit/Components/Modals/confirmation_modal.dart';
import 'package:orgit/services/auth/auth.dart';
import '../../utils/responsive_utils.dart';
import 'dart:io';

class Profileform extends StatefulWidget {
  final useruid = FirebaseAuth.instance.currentUser!.uid;
  final firstNameCont = TextEditingController();
  final lastNameCont = TextEditingController();
  final nicknameCont = TextEditingController();
  final telephonePrefixCont = TextEditingController();
  final telephoneCont = TextEditingController();
  final dateCont = TextEditingController();
  XFile? selectedImage;

  Profileform() {
    telephonePrefixCont.text = "+420";
  }

  @override
  State<Profileform> createState() => _ProfileformState();
}

class _ProfileformState extends State<Profileform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF131416),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.getPaddingHorizontal(context),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ResponsiveUtils.getSpacingMedium(context),
                ),
                // Header with back button
                Row(
                  children: [
                    InkWell(
                      onTap: () => _showSignOutConfirmation(context),
                      child: Row(children: [
                        Transform.rotate(
                          angle: 3.14,
                          child: Icon(
                            Icons.arrow_right_alt,
                            color: Colors.white,
                            size: ResponsiveUtils.getIconSize(context) * 1.5,
                          ),
                        ),
                        SizedBox(
                          width: ResponsiveUtils.getSpacingMedium(context),
                        ),
                        Text(
                          'Profil',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                ResponsiveUtils.getHeadingFontSize(context),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Profile Image
                      ProfileIcon(
                        onTap: _pickImageFromGallery,
                        selectedImage: widget.selectedImage,
                      ),

                      // Form Fields
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FormInput(
                              labelText: 'Jméno',
                              controller: widget.firstNameCont,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingSmall(context)),
                            FormInput(
                              labelText: 'Příjmení',
                              controller: widget.lastNameCont,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingSmall(context)),
                            FormInput(
                              labelText: 'Přezdívka',
                              controller: widget.nicknameCont,
                              iconColor: Colors.white,
                            ),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingSmall(context)),
                            TelephoneInput(widget: widget),
                            SizedBox(
                                height:
                                    ResponsiveUtils.getSpacingSmall(context)),
                            FormInput(
                              labelText: 'Datum narození',
                              controller: widget.dateCont,
                              iconColor: Colors.white,
                              icon: Bootstrap.calendar,
                              readonly: true,
                              dateInput: true,
                            ),
                          ],
                        ),
                      ),

                      // Submit Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => (),
                            child: Container(
                              width: ResponsiveUtils.isSmallScreen(context)
                                  ? MediaQuery.of(context).size.width * 0.8
                                  : MediaQuery.of(context).size.width * 0.7,
                              height: ResponsiveUtils.getButtonHeight(context),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 203, 105),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(6),
                                  bottomLeft: Radius.circular(6),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Dokončit registraci',
                                    style: TextStyle(
                                      fontSize:
                                          ResponsiveUtils.getSubtitleFontSize(
                                              context),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: ResponsiveUtils.getSpacingMedium(
                                        context),
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt_rounded,
                                    size: ResponsiveUtils.getIconSize(context) *
                                        1.5,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Bottom Dots
                Column(
                  children: [
                    BottomDots(currentIndex: 1, totalDots: 3),
                    SizedBox(
                      height: ResponsiveUtils.getSpacingMedium(context),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future _pickImageFromGallery() async {
    try {
      final returnedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (returnedImage != null) {
        setState(() {
          widget.selectedImage = returnedImage;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Chyba při výběru obrázku: $e')),
      );
    }
  }

  void _showSignOutConfirmation(BuildContext context) {
    ConfirmationModal.show(
      context,
      title: "Odhlášení",
      message:
          "Opravdu se chcete odhlásit? Budete přesměrováni na registrační stránku.",
      confirmText: "Ano, odhlásit",
      cancelText: "Zrušit",
      onConfirm: () async {
        try {
          await AuthService().signOut();
          if (context.mounted) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/register',
              (route) => false,
            );
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Chyba při odhlašování: $e')),
            );
          }
        }
      },
    );
  }
}

class TelephoneInput extends StatelessWidget {
  const TelephoneInput({
    super.key,
    required this.widget,
  });

  final Profileform widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: ResponsiveUtils.getSpacingSmall(context) * 0.25,
            left: ResponsiveUtils.getSpacingSmall(context),
            right: ResponsiveUtils.getSpacingLarge(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Telefon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveUtils.getBodyTextFontSize(context) * 0.8,
                  color: Color.fromARGB(255, 87, 88, 90),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: ResponsiveUtils.isSmallScreen(context) ? 55 : 70,
              height: ResponsiveUtils.getButtonHeight(context) * 0.75,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              child: Padding(
                padding:
                    EdgeInsets.all(ResponsiveUtils.getSpacingSmall(context)),
                child: TextField(
                  decoration: null,
                  controller: widget.telephonePrefixCont,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.getBodyTextFontSize(context),
                  ),
                  cursorHeight: 25,
                  cursorColor: Colors.white.withAlpha(125),
                ),
              ),
            ),
            Container(
              width: ResponsiveUtils.isSmallScreen(context)
                  ? MediaQuery.of(context).size.width * 0.45
                  : 215,
              height: ResponsiveUtils.getButtonHeight(context) * 0.75,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 27, 29),
                  border: Border.all(color: Colors.white, width: 0.05)),
              child: Padding(
                padding:
                    EdgeInsets.all(ResponsiveUtils.getSpacingSmall(context)),
                child: TextField(
                  decoration: null,
                  controller: widget.telephoneCont,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.getBodyTextFontSize(context),
                  ),
                  cursorHeight: 25,
                  cursorColor: Colors.white.withAlpha(125),
                ),
              ),
            ),
            Container(
              width: 30,
              height: ResponsiveUtils.getButtonHeight(context) * 0.75,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: InkWell(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: ResponsiveUtils.getIconSize(context) * 0.7,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
                  : AssetImage('assets/profile.png') as ImageProvider,
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
