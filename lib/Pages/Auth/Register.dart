import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:orgit/Components/Feature/bottom_dots.dart";
import "package:orgit/Components/Inputs/from_input.dart";
import "package:icons_plus/icons_plus.dart";
import "package:orgit/Components/Button/social_button.dart";
import "package:logger/logger.dart";
import "dart:developer";
import "package:orgit/services/auth/auth.dart";
import "package:orgit/global_vars.dart";
import "package:orgit/services/api/api_client.dart";
import "package:orgit/models/user.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:orgit/Pages/Auth/login_form.dart";

class Register extends StatefulWidget {
  Register() {}

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailCont = TextEditingController();
  String emailError = "";
  Color emailValid = Colors.white;

  TextEditingController passwordCont = TextEditingController();
  String passwordError = "";
  Color passwordValid = Colors.white;

  TextEditingController repeatPasswordCont = TextEditingController();
  String repeatPasswordError = "";
  Color repeatPasswordValid = Colors.white;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive layout
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;
    final double screenHeight = screenSize.height;

    // Calculate responsive values
    final double paddingHorizontal = screenWidth * 0.06;
    final double paddingVertical = screenHeight * 0.03;
    final double headingFontSize = screenWidth * 0.08;
    final double subtitleFontSize = screenWidth * 0.035;
    final double buttonWidth = screenWidth * 0.6;
    final double buttonHeight = screenHeight * 0.08;
    final double spacingSmall = screenHeight * 0.01;
    final double spacingMedium = screenHeight * 0.025;
    final double spacingLarge = screenHeight * 0.04;
    final double iconSize = screenWidth * 0.1;

    return Scaffold(
      backgroundColor: Global.background,
      resizeToAvoidBottomInset:
          true, // Changed to true for keyboard adjustments
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: paddingHorizontal,
                        vertical: paddingVertical,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenHeight * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () =>
                                    throw new Exception('Not implemented'),
                                child: Text(
                                  "Přihlásit se",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 203, 105),
                                      fontWeight: FontWeight.bold,
                                      fontSize: subtitleFontSize),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: spacingSmall,
                          ),
                          Text(
                            "Registrovat se",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: headingFontSize,
                                letterSpacing: 2,
                                color: Colors.white),
                          ),
                          Text(
                            "Vítejte v orgitu!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: subtitleFontSize,
                              color: Color.fromARGB(255, 255, 203, 105),
                            ),
                          ),
                          SizedBox(
                            height: spacingLarge,
                          ),
                          LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  FormInput(
                                    controller: emailCont,
                                    labelText: "EMAIL",
                                    icon: Icons.check,
                                    iconColor: emailValid,
                                    righText: emailError,
                                    rightTextColor: Colors.red,
                                  ),
                                  SizedBox(
                                    height: spacingMedium,
                                  ),
                                  FormInput(
                                    labelText: "HESLO",
                                    controller: passwordCont,
                                    obscureText: true,
                                    showObscureText: true,
                                    iconColor: passwordValid,
                                    righText: passwordError,
                                    rightTextColor: Colors.red,
                                  ),
                                  SizedBox(
                                    height: spacingMedium,
                                  ),
                                  FormInput(
                                    labelText: "HESLO ZNOVU",
                                    controller: repeatPasswordCont,
                                    obscureText: true,
                                    showObscureText: false,
                                    iconColor: repeatPasswordValid,
                                    righText: repeatPasswordError,
                                    rightTextColor: Colors.red,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => register(emailCont.text, passwordCont.text,
                            repeatPasswordCont.text, context),
                        child: Container(
                          width: buttonWidth,
                          height: buttonHeight,
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
                                "Registrovat se",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Icon(
                                Icons.arrow_right_alt_rounded,
                                size: iconSize,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: spacingMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: screenWidth * 0.25,
                          height: 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "nebo pokračovat",
                          style: TextStyle(
                            wordSpacing: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: subtitleFontSize,
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.25,
                          height: 1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: spacingMedium,
                    ),
                    // Social buttons in responsive layout
                    screenWidth > 600
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SocialButton(
                                color: Color.fromARGB(255, 66, 95, 131),
                                onPressed: () => signInWithFacebook(context),
                                text: "Facebook",
                                brand: Brand(Brands.facebook),
                              ),
                              SocialButton(
                                text: "Google",
                                brand: Brand(Brands.google),
                                color: Color.fromARGB(255, 44, 105, 61),
                                onPressed: () => signInWithGoogle(context),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: spacingSmall),
                                child: SocialButton(
                                  color: Color.fromARGB(255, 66, 95, 131),
                                  onPressed: () => signInWithFacebook(context),
                                  text: "Facebook",
                                  brand: Brand(Brands.facebook),
                                ),
                              ),
                              SocialButton(
                                text: "Google",
                                brand: Brand(Brands.google),
                                color: Color.fromARGB(255, 44, 105, 61),
                                onPressed: () => signInWithGoogle(context),
                              ),
                            ],
                          ),
                    SizedBox(height: 60), // Space for the dots at bottom
                  ],
                ),
                Positioned(
                  bottom: 18,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      BottomDots(currentIndex: 1, totalDots: 3),
                      SizedBox(
                        height: 18,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> emailValidation(String email) async {
    if (email.isEmpty) {
      setState(() {
        emailError = "Nezadal si email";
        emailValid = Colors.red;
      });
      return false;
    } else if (!EmailValidator.validate(email)) {
      setState(() {
        emailError = "Email není validní";
        emailValid = Colors.red;
      });
      return false;
    }
    // check if email already exists
    ApiClient _api = ApiClient();
    bool doesExists = await _api.getWithParams(
      "/email/",
      {"email": email},
    );
    if (doesExists) {
      setState(() {
        emailError = "Email již existuje";
        emailValid = Colors.red;
      });
      return false;
    }

    // Alls good
    setState(() {
      emailError = "";
      emailValid = Colors.green;
    });

    return true;
  }

  Future<bool> passwordValidation(
      String password, String repeatPassword) async {
    if (repeatPassword.isEmpty) {
      setState(() {
        repeatPasswordError = "Nezadal si heslo";
        repeatPasswordValid = Colors.red;
      });
    } else {
      setState(() {
        repeatPasswordError = "";
      });
    }

    RegExp regExp = RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]{};:"\\|,.<>\/\?]');
    // password is empty
    if (password.isEmpty) {
      setState(() {
        passwordError = "Nezadal si heslo";
        passwordValid = Colors.red;
      });
      return false;
      // password doesnt have special symbol
    } else if (!regExp.hasMatch(password)) {
      setState(() {
        passwordError = "Heslo neobsahuje speciální znak";
        passwordValid = Colors.red;
      });
      return false;
      // password doesnt match with repeat password
    } else if (password != repeatPassword) {
      setState(() {
        passwordError = "Hesla se neshodují";
        repeatPasswordError = "Hesla se neshodují";
        passwordValid = Colors.red;
        repeatPasswordValid = Colors.red;
      });
      return false;
    }

    setState(() {
      passwordError = "";
      passwordValid = Colors.green;
      repeatPasswordValid = Colors.green;
    });
    return true;
  }

  Future<void> register(
    String email,
    String password,
    String repeatPassword,
    BuildContext context,
  ) async {
    log("Email: $email");
    log("Password: $password");
    log("Repeat Password: $repeatPassword");
    try {
      bool isValidEmail = await emailValidation(email);
      bool isValidPassword = await passwordValidation(password, repeatPassword);

      if (isValidEmail && isValidPassword) {
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

        try {
          // Register with Firebase
          User? user = await AuthService()
              .createUserWithEmailAndPassword(email, password);

          if (user != null) {
            // Create user in database
            UserRegister userModel = UserRegister(
              useruid: user.uid,
              email: email,
            );

            try {
              await ApiClient().post("/User/", userModel.toJson());

              // Close loading dialog
              Navigator.of(context).pop();

              // Show success message and navigate
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Registrace proběhla úspěšně"),
                  backgroundColor: Colors.green,
                ),
              );

              // Call the onRegister callback to navigate
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginForm()),
              );
            } catch (apiError) {
              // API call failed, but Firebase user was created
              // We should delete the Firebase user to avoid orphaned accounts
              try {
                await user.delete();
              } catch (deleteError) {
                Logger().e(
                    "Couldn't delete Firebase user after API error: $deleteError");
              }

              // Close loading dialog
              Navigator.of(context).pop();

              // Show API error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      "Chyba při ukládání uživatele do databáze: ${apiError.toString()}"),
                  backgroundColor: Colors.red,
                ),
              );

              Logger log = Logger();
              log.e(apiError);
            }
          } else {
            // Close loading dialog
            Navigator.of(context).pop();

            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Registrace selhala. Zkuste to prosím znovu."),
                backgroundColor: Colors.red,
              ),
            );
          }
        } catch (e) {
          // Close loading dialog
          Navigator.of(context).pop();

          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Chyba: ${e.toString()}"),
              backgroundColor: Colors.red,
            ),
          );

          Logger log = Logger();
          log.e(e);
        }
      }
    } catch (e) {
      log(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Došlo k chybě: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
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

      // Sign in with Google
      UserCredential? userCredential = await AuthService().loginWithGoogle();

      if (userCredential != null && userCredential.user != null) {
        User user = userCredential.user!;

        // Check if user already exists in your database
        try {
          bool userExists = await checkUserExists(user.uid);

          if (!userExists) {
            // Create user in database if it doesn't exist
            UserRegister userModel = UserRegister(
              useruid: user.uid,
              email: user.email ?? "",
            );

            await ApiClient().post("/User/", userModel.toJson());
          }

          // Close loading dialog
          Navigator.of(context).pop();

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Google přihlášení proběhlo úspěšně"),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to the next screen
          throw new Exception('Not implemented');
        } catch (e) {
          // Close loading dialog
          Navigator.of(context).pop();

          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Chyba při ukládání uživatele: ${e.toString()}"),
              backgroundColor: Colors.red,
            ),
          );

          Logger log = Logger();
          log.e(e);
        }
      } else {
        // Close loading dialog
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Google přihlášení selhalo"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if it's open
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Chyba při Google přihlášení: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );

      Logger log = Logger();
      log.e(e);
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
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

      // Sign in with Facebook
      UserCredential? userCredential = await AuthService().loginWithFacebook();

      if (userCredential != null && userCredential.user != null) {
        User user = userCredential.user!;

        // Check if user already exists in your database
        try {
          bool userExists = await checkUserExists(user.uid);

          if (!userExists) {
            // Create user in database if it doesn't exist
            UserRegister userModel = UserRegister(
              useruid: user.uid,
              email: user.email ?? "",
            );

            await ApiClient().post("/User/", userModel.toJson());
          }

          // Close loading dialog
          Navigator.of(context).pop();

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Facebook přihlášení proběhlo úspěšně"),
              backgroundColor: Colors.green,
            ),
          );

          // Navigate to the next screen
          throw new Exception('Not implemented');
        } catch (e) {
          // Close loading dialog
          Navigator.of(context).pop();

          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Chyba při ukládání uživatele: ${e.toString()}"),
              backgroundColor: Colors.red,
            ),
          );

          Logger log = Logger();
          log.e(e);
        }
      } else {
        // Close loading dialog
        Navigator.of(context).pop();

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Facebook přihlášení selhalo"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if it's open
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Chyba při Facebook přihlášení: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );

      Logger log = Logger();
      log.e(e);
    }
  }

  Future<bool> checkUserExists(String useruid) async {
    try {
      // Check if user exists in database
      final response = await ApiClient().getWithParams(
        "/User/exists/",
        {"useruid": useruid},
      );
      return response ?? false;
    } catch (e) {
      log("Error checking if user exists: $e");
      return false;
    }
  }
}
