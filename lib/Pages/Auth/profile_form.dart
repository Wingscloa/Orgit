import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:orgit/Components/Feature/bottom_dots.dart';
import 'package:orgit/Components/Inputs/from_input.dart';

class Profileform extends StatefulWidget {
  final useruid = FirebaseAuth.instance.currentUser!.uid;
  final firstNameCont = TextEditingController();
  final lastNameCont = TextEditingController();
  final nicknameCont = TextEditingController();
  final telephonePrefixCont = TextEditingController();
  final telephoneCont = TextEditingController();
  final dateCont = TextEditingController();
  late final XFile? selectedImage;
  @override
  State<Profileform> createState() => _ProfileformState();
}

class _ProfileformState extends State<Profileform> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 46),
                  child: InkWell(
                    onTap: AuthService().signOut,
                    child: Row(children: [
                      Transform.rotate(
                        angle: 3.14,
                        child: Icon(
                          Icons.arrow_right_alt,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      SizedBox(
                        width: 22,
                      ),
                      Text(
                        'Profil',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ProfileIcon(
                  onTap: _pickImageFromGallery,
                  // image: widget.selectedImage,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        FormInput(
                          labelText: 'Jméno',
                          controller: widget.firstNameCont,
                          iconColor: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FormInput(
                          labelText: 'Příjmení',
                          controller: widget.lastNameCont,
                          iconColor: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FormInput(
                          labelText: 'Přezdívka',
                          controller: widget.nicknameCont,
                          iconColor: Colors.white,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        TelephoneInput(widget: widget),
                        SizedBox(
                          height: 8,
                        ),
                        FormInput(
                          labelText: 'Datum narození',
                          controller: widget.dateCont,
                          iconColor: Colors.white,
                          icon: Bootstrap.calendar,
                          readonly: true,
                          dateInput: true,
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => (),
                      child: Container(
                        width: 290,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 255, 203, 105),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Dokončit registraci',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.arrow_right_alt_rounded,
                              size: 50,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BottomDots(currentIndex: 1, totalDots: 3),
                SizedBox(
                  height: 18,
                )
              ],
            )
          ],
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
      // Handle the error here, e.g., show a dialog or a snackbar
      print('Error picking image: $e');
    }
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
          padding: const EdgeInsets.only(bottom: 2.5, left: 8, right: 28),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Telefon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Color.fromARGB(255, 87, 88, 90),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 55,
              height: 45,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: null,
                  controller: widget.telephonePrefixCont,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  cursorHeight: 25,
                  cursorColor: Colors.white.withAlpha(125),
                ),
              ),
            ),
            Container(
              width: 215,
              height: 45,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 27, 29),
                  border: Border.all(color: Colors.white, width: 0.05)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: null,
                  controller: widget.telephoneCont,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  cursorHeight: 25,
                  cursorColor: Colors.white.withAlpha(125),
                ),
              ),
            ),
            Container(
              width: 30,
              height: 45,
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
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// TODO: Opravit Profilovky

class ProfileIcon extends StatelessWidget {
  final VoidCallback onTap;
  // final Image image;
  const ProfileIcon({
    super.key,
    required this.onTap,
    // required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: image != null
            //       ? FileImage(image)
            //       : AssetImage('assets/profile.png') as ImageProvider,
            // ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 255, 203, 105),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: IconButton(
                  icon: Icon(Icons.edit, color: Colors.black, size: 16),
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
