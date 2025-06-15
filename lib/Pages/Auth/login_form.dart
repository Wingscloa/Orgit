import 'package:flutter/material.dart';
import 'package:orgit/Pages/Auth/Register.dart';
import 'package:orgit/services/auth/auth.dart';
import 'package:orgit/components/Feature/bottom_dots.dart';
import "package:orgit/Components/Inputs/formInput.dart";
import 'package:icons_plus/icons_plus.dart';
import 'package:orgit/components/Button/social_button.dart';
import "package:orgit/global_vars.dart";
import 'package:email_validator/email_validator.dart';
import 'package:orgit/utils/navigation_utils.dart';
import '../../utils/responsive_utils.dart';

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final email = TextEditingController();
  String emailError = "";
  Color emailValid = Colors.white;
  final password = TextEditingController();
  String passwordError = "";
  Color passwordValid = Colors.white;

  @override
  void initState() {
    super.initState();
    // Add listeners for real-time validation
    email.addListener(_validateEmail);
    password.addListener(_validatePassword);
  }

  @override
  void dispose() {
    email.removeListener(_validateEmail);
    password.removeListener(_validatePassword);
    email.dispose();
    password.dispose();
    super.dispose();
  }

  void _validateEmail() {
    setState(() {
      String emailText = email.text.trim();
      if (emailText.isEmpty) {
        emailError = "";
        emailValid = Colors.white;
      } else if (!EmailValidator.validate(emailText)) {
        emailError = "Email není validní";
        emailValid = Colors.red;
      } else {
        emailError = "";
        emailValid = Colors.green;
      }
    });
  }

  void _validatePassword() {
    setState(() {
      String passwordText = password.text.trim();
      if (passwordText.isEmpty) {
        passwordError = "";
        passwordValid = Colors.white;
      } else if (passwordText.length < 6) {
        passwordError = "Heslo musí mít alespoň 6 znaků";
        passwordValid = Colors.red;
      } else {
        passwordError = "";
        passwordValid = Colors.green;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    return Scaffold(
        backgroundColor: Global.background,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight - MediaQuery.of(context).padding.top,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveUtils.getPaddingHorizontal(context),
                          vertical: ResponsiveUtils.getPaddingVertical(context),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: ResponsiveUtils.getSpacingLarge(context),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()),
                                    )
                                  },
                                  child: Text(
                                    'Registrovat se',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 203, 105),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            ResponsiveUtils.getBodyFontSize(
                                                context)),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: ResponsiveUtils.getSpacingSmall(context),
                            ),
                            Text(
                              'Přihlásit se',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveUtils.getHeadingFontSize(
                                          context) *
                                      1.2,
                                  color: Colors.white),
                            ),
                            Text(
                              'Vítejte zpět!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    ResponsiveUtils.getBodyFontSize(context),
                                color: Color.fromARGB(255, 255, 203, 105),
                              ),
                            ),
                            SizedBox(
                              height: ResponsiveUtils.getSpacingLarge(context),
                            ),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FormInput(
                                      controller: email,
                                      labelText: 'EMAIL',
                                      icon: Icons.check,
                                      iconColor: emailValid,
                                      righText: emailError,
                                      rightTextColor: Colors.red,
                                    ),
                                    SizedBox(
                                      height: ResponsiveUtils.getSpacingMedium(
                                          context),
                                    ),
                                    FormInput(
                                      labelText: 'HESLO',
                                      controller: password,
                                      obscureText: true,
                                      showObscureText: true,
                                      changePassword: true,
                                      iconColor: passwordValid,
                                      righText: passwordError,
                                      rightTextColor: Colors.red,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveUtils.getSpacingMedium(context),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () =>
                              login(email.text, password.text, context),
                          child: Container(
                            width: ResponsiveUtils.getLoginButtonWidth(context),
                            height: ResponsiveUtils.getButtonHeight(context),
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
                                  'Přihlásit se',
                                  style: TextStyle(
                                    fontSize:
                                        ResponsiveUtils.getSubtitleFontSize(
                                            context),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      ResponsiveUtils.getSpacingSmall(context),
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
                      ),
                      SizedBox(
                        height: ResponsiveUtils.getSpacingLarge(context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: ResponsiveUtils.getResponsiveWidth(
                              context,
                              mobile: screenWidth * 0.25,
                              tablet: screenWidth * 0.3,
                              desktop: screenWidth * 0.35,
                            ),
                            height: 1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'nebo pokračovat',
                            style: TextStyle(
                              wordSpacing: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  ResponsiveUtils.getBodyFontSize(context),
                            ),
                          ),
                          Container(
                            width: ResponsiveUtils.getResponsiveWidth(
                              context,
                              mobile: screenWidth * 0.25,
                              tablet: screenWidth * 0.3,
                              desktop: screenWidth * 0.35,
                            ),
                            height: 1,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: ResponsiveUtils.getSpacingMedium(context),
                      ),
                      // Social buttons in responsive layout
                      ResponsiveUtils.isSmallScreen(context)
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      bottom: ResponsiveUtils.getSpacingSmall(
                                          context)),
                                  child: SocialButton(
                                    color: Color.fromARGB(255, 66, 95, 131),
                                    onPressed: () => (),
                                    text: 'Facebook',
                                    brand: Brand(Brands.facebook),
                                  ),
                                ),
                                SocialButton(
                                  text: 'Google',
                                  brand: Brand(Brands.google),
                                  color: Color.fromARGB(255, 44, 105, 61),
                                  onPressed: () => loginWithGoogle(context),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SocialButton(
                                  color: Color.fromARGB(255, 66, 95, 131),
                                  onPressed: () => (),
                                  text: 'Facebook',
                                  brand: Brand(Brands.facebook),
                                ),
                                SocialButton(
                                  text: 'Google',
                                  brand: Brand(Brands.google),
                                  color: Color.fromARGB(255, 44, 105, 61),
                                  onPressed: () => loginWithGoogle(context),
                                ),
                              ],
                            ),
                      SizedBox(
                          height: ResponsiveUtils.getSpacingLarge(context) *
                              2), // Space for the dots at bottom
                    ],
                  ),
                  Positioned(
                    bottom: ResponsiveUtils.getSpacingMedium(context),
                    left: 0,
                    right: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BottomDots(currentIndex: 1, totalDots: 3),
                        SizedBox(
                          height: ResponsiveUtils.getSpacingMedium(context),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future<bool> validateLogin(String email, String password) async {
    bool isValid = true;
    setState(() {
      // Validate email
      if (email.isEmpty) {
        emailError = "Nezadal si email";
        emailValid = Colors.red;
        isValid = false;
      } else if (!EmailValidator.validate(email)) {
        emailError = "Email není validní";
        emailValid = Colors.red;
        isValid = false;
      } else {
        emailError = "";
        emailValid = Colors.green;
      }

      // Validate password
      if (password.isEmpty) {
        passwordError = "Nezadal si heslo";
        passwordValid = Colors.red;
        isValid = false;
      } else if (password.length < 6) {
        passwordError = "Heslo musí mít alespoň 6 znaků";
        passwordValid = Colors.red;
        isValid = false;
      } else {
        passwordError = "";
        passwordValid = Colors.green;
      }
    });
    return isValid;
  }

  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    bool isValid = await validateLogin(email, password);
    if (!isValid) {
      String errorMessage = emailError.isNotEmpty
          ? emailError
          : passwordError.isNotEmpty
              ? passwordError
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
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 255, 203, 105),
            ),
          );
        },
      );

      // Nejprve provedeme přihlášení
      await AuthService().logInUserWithEmailAndPassword(email, password);

      // Zavřeme dialog s indikátorem načítání
      Navigator.of(context).pop();
      await Future.delayed(Duration(milliseconds: 100));

      // Až po úspěšném přihlášení rozhodneme, kam uživatele přesměrovat
      final targetPage = await NavigationUtils.getNavigation();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => targetPage),
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Chyba při přihlášení: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 255, 203, 105),
            ),
          );
        },
      );

      // Nejprve provedeme přihlášení přes Google
      print("LoginForm: Starting Google authentication");
      await AuthService().loginWithGoogle();
      print("LoginForm: Google authentication successful");

      // Zavřeme dialog s indikátorem načítání
      print("LoginForm: Closing Google login loading dialog");
      Navigator.of(context).pop();

      // Malá pauza pro stabilizaci UI
      await Future.delayed(Duration(milliseconds: 100));

      // Až po úspěšném přihlášení rozhodneme, kam uživatele přesměrovat
      print("LoginForm: Getting post-login page");
      final targetPage = await NavigationUtils.getNavigation();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => targetPage),
      );
      print("LoginForm: Google navigation completed");
    } catch (e) {
      // Close loading dialog
      Navigator.of(context).pop();

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Chyba při Google přihlášení: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );

      print("Google login error: ${e.toString()}");
    }
  }
}
