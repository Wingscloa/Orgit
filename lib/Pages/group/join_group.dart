import 'package:orgit/Components/Modals/mdl_group_create.dart';
import 'package:orgit/Components/Modals/mdl_group_join.dart';
import 'package:flutter/material.dart';
import 'package:orgit/Components/Feature/bottom_dots.dart';
import 'package:orgit/Components/Button/default_button.dart';
import 'package:orgit/global_vars.dart';

class Joingroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.background,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              const Image(
                image: AssetImage('assets/map.png'),
              ),
              Text(
                'Vítej v orgitu',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 203, 105),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 296,
                child: Text(
                  'poslední krok, který tě čeká. Musíš se přihlásit buď do již existující skupiny, nebo ji sám můžeš vytvořit',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Defaultbutton(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Mdlgroupcreate();
                          });
                    },
                    color: Color.fromARGB(255, 255, 203, 105),
                    text: 'Vytvořit skupinu',
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Defaultbutton(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Mdlgroupjoin();
                          });
                    },
                    text: 'Připojit se ke skupině',
                    color: Color.fromARGB(255, 60, 60, 60),
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BottomDots(currentIndex: 2, totalDots: 3),
              SizedBox(
                height: 18,
              )
            ],
          )
        ],
      ),
    );
  }
}
