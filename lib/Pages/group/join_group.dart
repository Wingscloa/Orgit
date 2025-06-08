import 'package:orgit/components/modals/mdl_group_create.dart';
import 'package:orgit/components/modals/mdl_group_join.dart';
import 'package:orgit/Components/Modals/confirmation_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orgit/Components/Feature/bottom_dots.dart';
import 'package:orgit/Components/Button/default_button.dart';
import 'package:orgit/Pages/Auth/Register.dart';
import 'package:orgit/global_vars.dart';

class Joingroup extends StatelessWidget {
  void _showSignOutConfirmation(BuildContext context) {
    ConfirmationModal.show(
      context,
      title: "Odhlášení",
      message:
          "Opravdu se chcete odhlásit? Budete přesměrováni na přihlašovací stránku.",
      confirmText: "Ano, odhlásit",
      cancelText: "Zrušit",
      onConfirm: () async {
        try {
          await FirebaseAuth.instance.signOut();
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => Register()),
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Global.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Image(
                  image: AssetImage('assets/backgroundMap.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.08,
                  right: screenWidth * 0.08,
                  top: screenHeight * 0.1,
                  bottom: screenHeight * 0.15,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vítej v orgitu',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 203, 105),
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Container(
                      width: screenWidth * 0.8,
                      child: Text(
                        'poslední krok, který tě čeká. Musíš se přihlásit buď do již existující skupiny, nebo ji sám můžeš vytvořit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.3),
                    Column(
                      children: [
                        Defaultbutton(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.065,
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return MdlGroupCreate();
                              },
                            );
                          },
                          color: Color.fromARGB(255, 255, 203, 105),
                          text: 'Vytvořit skupinu',
                          textColor: Colors.black,
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        Defaultbutton(
                          width: screenWidth * 0.6,
                          height: screenHeight * 0.065,
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                                return Mdlgroupjoin();
                              },
                            );
                          },
                          text: 'Připojit se ke skupině',
                          color: Color.fromARGB(255, 60, 60, 60),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: screenHeight * 0.04,
              left: 0,
              right: 0,
              child: BottomDots(currentIndex: 2, totalDots: 3),
            ),
            Positioned(
              top: screenHeight * 0.02,
              left: screenWidth * 0.05,
              child: InkWell(
                onTap: () => _showSignOutConfirmation(context),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
