import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:orgit/Components/Feature/bottom_dots.dart';
import 'package:orgit/Components/Inputs/formInput.dart';
import 'package:orgit/Components/Modals/confirmation_modal.dart';
import 'package:orgit/Pages/group/join_group.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/services/api/api_client.dart';
import 'package:orgit/models/user_dto.dart';
import 'dart:typed_data';
import '../../utils/responsive_utils.dart';
import 'package:orgit/components/inputs/telephoneInput.dart';
import 'package:orgit/components/icons/profileIcon.dart';
import 'package:orgit/Pages/Auth/Register.dart';

class Profileform extends StatefulWidget {
  @override
  State<Profileform> createState() => _ProfileformState();
}

class _ProfileformState extends State<Profileform> {
  final useruid = FirebaseAuth.instance.currentUser!.uid;

  final firstNameCont = TextEditingController();
  String firstNameError = "";
  Color firstNameValid = Colors.white;

  final lastNameCont = TextEditingController();
  String lastNameError = "";
  Color lastNameValid = Colors.white;

  final nicknameCont = TextEditingController();
  String nicknameError = "";
  Color nicknameValid = Colors.white;

  final telephonePrefixCont = TextEditingController();
  String telephonePrefixError = "";
  Color telephonePrefixValid = Colors.white;

  final telephoneCont = TextEditingController();
  String telephoneError = "";
  Color telephoneValid = Colors.white;

  final dateCont = TextEditingController();
  String dateError = "";
  Color dateValid = Colors.white;

  XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    telephonePrefixCont.text = "+420";
    // Add listeners for real-time validation
    firstNameCont.addListener(_validateFirstName);
    lastNameCont.addListener(_validateLastName);
    nicknameCont.addListener(_validateNickname);
    dateCont.addListener(_validateDate);
  }

  @override
  void dispose() {
    firstNameCont.removeListener(_validateFirstName);
    lastNameCont.removeListener(_validateLastName);
    nicknameCont.removeListener(_validateNickname);
    dateCont.removeListener(_validateDate);
    super.dispose();
  }

  void _validateFirstName() {
    setState(() {
      String firstName = firstNameCont.text.trim();
      if (firstName.isEmpty) {
        firstNameError = "";
        firstNameValid = Colors.white;
      } else if (firstName.length > 32) {
        firstNameError = "Jméno může mít maximálně 32 znaků";
        firstNameValid = Colors.red;
      } else {
        firstNameError = "";
        firstNameValid = Colors.green;
      }
    });
  }

  void _validateLastName() {
    setState(() {
      String lastName = lastNameCont.text.trim();
      if (lastName.isEmpty) {
        lastNameError = "";
        lastNameValid = Colors.white;
      } else if (lastName.length > 32) {
        lastNameError = "Příjmení může mít maximálně 32 znaků";
        lastNameValid = Colors.red;
      } else {
        lastNameError = "";
        lastNameValid = Colors.green;
      }
    });
  }

  void _validateNickname() {
    setState(() {
      String nickname = nicknameCont.text.trim();
      if (nickname.isEmpty) {
        nicknameError = "";
        nicknameValid = Colors.white;
      } else if (nickname.length > 32) {
        nicknameError = "Přezdívka může mít maximálně 32 znaků";
        nicknameValid = Colors.red;
      } else {
        nicknameError = "";
        nicknameValid = Colors.green;
      }
    });
  }

  void _validateDate() {
    setState(() {
      String date = dateCont.text.trim();
      if (date.isEmpty) {
        dateError = "";
        dateValid = Colors.white;
      } else {
        try {
          DateTime.parse(date);
          dateError = "";
          dateValid = Colors.green;
        } catch (e) {
          dateError = "Neplatné datum";
          dateValid = Colors.red;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF131416),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getPaddingHorizontal(context),
              ),
              child: SizedBox(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
                child: Column(
                  children: [
                    SizedBox(
                      height: ResponsiveUtils.getSpacingMedium(context),
                    ),
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
                                size:
                                    ResponsiveUtils.getIconSize(context) * 1.5,
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
                          ProfileIcon(
                            onTap: _pickImageFromGallery,
                            selectedImage: selectedImage,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FormInput(
                                  labelText: 'Jméno',
                                  controller: firstNameCont,
                                  iconColor: firstNameValid,
                                ),
                                SizedBox(
                                    height: ResponsiveUtils.getSpacingSmall(
                                        context)),
                                FormInput(
                                  labelText: 'Příjmení',
                                  controller: lastNameCont,
                                  iconColor: lastNameValid,
                                ),
                                SizedBox(
                                    height: ResponsiveUtils.getSpacingSmall(
                                        context)),
                                FormInput(
                                  labelText: 'Přezdívka',
                                  controller: nicknameCont,
                                  iconColor: nicknameValid,
                                ),
                                SizedBox(
                                    height: ResponsiveUtils.getSpacingSmall(
                                        context)),
                                TelephoneInput(
                                  prefixController: telephonePrefixCont,
                                  phoneController: telephoneCont,
                                ),
                                SizedBox(
                                    height: ResponsiveUtils.getSpacingSmall(
                                        context)),
                                FormInput(
                                  labelText: 'Datum narození',
                                  controller: dateCont,
                                  iconColor: dateValid,
                                  icon: Bootstrap.calendar,
                                  readonly: true,
                                  dateInput: true,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => _handleCreateProfile(),
                                child: Container(
                                  width: ResponsiveUtils.isSmallScreen(context)
                                      ? MediaQuery.of(context).size.width * 0.8
                                      : MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      ResponsiveUtils.getButtonHeight(context),
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
                                  child: GestureDetector(
                                    onTap: () => _handleCreateProfile(),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Dokončit registraci',
                                          style: TextStyle(
                                            fontSize: ResponsiveUtils
                                                .getSubtitleFontSize(context),
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              ResponsiveUtils.getSpacingMedium(
                                                  context),
                                        ),
                                        Icon(
                                          Icons.arrow_right_alt_rounded,
                                          size: ResponsiveUtils.getIconSize(
                                                  context) *
                                              1.5,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
          selectedImage = returnedImage;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Chyba při výběru obrázku: $e')),
        );
      }
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Úspěšně jste se odhlásili'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
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

  void _handleCreateProfile() {
    String firstName = firstNameCont.text.trim();
    String lastName = lastNameCont.text.trim();
    String nickname = nicknameCont.text.trim();
    String telephonePrefix = telephonePrefixCont.text.trim();
    String telephone = telephoneCont.text.trim();
    String dateOfBirth = dateCont.text.trim();

    createProfile(
      firstName,
      lastName,
      nickname,
      telephonePrefix,
      telephone,
      dateOfBirth,
      selectedImage,
      context,
    );
  }

  Future<void> createProfile(
    String firstName,
    String lastName,
    String nickname,
    String telephonePrefix,
    String telephone,
    String dateOfBirth,
    XFile? image,
    BuildContext context,
  ) async {
    bool isValid = true;

    setState(() {
      // Validate firstName
      if (firstName.isEmpty) {
        firstNameError = "Jméno je povinné";
        firstNameValid = Colors.red;
        isValid = false;
      } else if (firstName.length > 32) {
        firstNameError = "Jméno může mít maximálně 32 znaků";
        firstNameValid = Colors.red;
        isValid = false;
      } else {
        firstNameError = "";
        firstNameValid = Colors.green;
      }

      // Validate lastName
      if (lastName.isEmpty) {
        lastNameError = "Příjmení je povinné";
        lastNameValid = Colors.red;
        isValid = false;
      } else if (lastName.length > 32) {
        lastNameError = "Příjmení může mít maximálně 32 znaků";
        lastNameValid = Colors.red;
        isValid = false;
      } else {
        lastNameError = "";
        lastNameValid = Colors.green;
      }

      // Validate nickname
      if (nickname.isEmpty) {
        nicknameError = "Přezdívka je povinná";
        nicknameValid = Colors.red;
        isValid = false;
      } else if (nickname.length > 32) {
        nicknameError = "Přezdívka může mít maximálně 32 znaků";
        nicknameValid = Colors.red;
        isValid = false;
      } else {
        nicknameError = "";
        nicknameValid = Colors.green;
      }

      // Validate telephone prefix - only if telephone is provided
      String cleanPrefix = telephonePrefix.replaceAll('+', '');
      if (telephone.isNotEmpty) {
        if (cleanPrefix.length != 3 ||
            !RegExp(r'^\d{3}$').hasMatch(cleanPrefix)) {
          telephonePrefixError = "Předvolba musí mít 3 číslice";
          telephonePrefixValid = Colors.red;
          isValid = false;
        } else {
          telephonePrefixError = "";
          telephonePrefixValid = Colors.green;
        }
      } else {
        telephonePrefixError = "";
        telephonePrefixValid = Colors.white;
      } // Validate telephone number - optional
      if (telephone.isNotEmpty) {
        if (!RegExp(r'^\d{1,9}$').hasMatch(telephone)) {
          telephoneError = "Telefonní číslo může mít maximálně 9 číslic";
          telephoneValid = Colors.red;
          isValid = false;
        } else {
          telephoneError = "";
          telephoneValid = Colors.green;
        }
      } else {
        telephoneError = "";
        telephoneValid = Colors.white;
      }

      // Validate date
      if (dateOfBirth.isEmpty) {
        dateError = "Datum narození je povinné";
        dateValid = Colors.red;
        isValid = false;
      } else {
        try {
          DateTime.parse(dateOfBirth);
          dateError = "";
          dateValid = Colors.green;
        } catch (e) {
          dateError = "Neplatné datum";
          dateValid = Colors.red;
          isValid = false;
        }
      }
    });

    if (!isValid) {
      String errorMessage = firstNameError.isNotEmpty
          ? firstNameError
          : lastNameError.isNotEmpty
              ? lastNameError
              : nicknameError.isNotEmpty
                  ? nicknameError
                  : telephonePrefixError.isNotEmpty
                      ? telephonePrefixError
                      : telephoneError.isNotEmpty
                          ? telephoneError
                          : dateError.isNotEmpty
                              ? dateError
                              : "Zkontrolujte zadané údaje";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vytváří se profil...'),
          backgroundColor: Colors.blue,
        ),
      );

      Uint8List? imageBytes = await _processImage(image);

      UserProfileRequest profileRequest = UserProfileRequest(
        useruid: useruid,
        firstname: firstName,
        lastname: lastName,
        nickname: nickname,
        telephoneprefix: telephonePrefix.replaceAll('+', ''),
        telephonenumber: telephone,
        birthday: DateTime.parse(dateOfBirth),
        profileicon: imageBytes, // Může být null
      );
      final apiClient = ApiClient();
      final response =
          await apiClient.put('/User', body: profileRequest.toJson());
      final status = response['status'];
      if (status == "success") {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Profil byl úspěšně vytvořen'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Joingroup()));
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chyba při vytváření profilu: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<Uint8List?> _processImage(XFile? image) async {
    if (image == null) return null;

    try {
      final int fileSize = await image.length();
      const int maxSize = 5 * 1024 * 1024; // 5MB

      if (fileSize > maxSize) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Obrázek je příliš velký (max 5MB). Vybraný obrázek má ${(fileSize / 1024 / 1024).toStringAsFixed(1)}MB.'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return null;
      }

      final Uint8List imageBytes = await image.readAsBytes();
      return imageBytes;
    } catch (e) {
      print('❌ Error processing image: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Chyba při zpracování obrázku: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    }
  }
}
