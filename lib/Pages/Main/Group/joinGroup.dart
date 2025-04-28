import 'package:Orgit/Components/Modals/Group/mdlGroupCreate.dart';
import 'package:Orgit/Components/Modals/Group/mdlGroupJoin.dart';
import 'package:flutter/material.dart';
import 'package:Orgit/Components/Feature/BottomDots.dart';
import 'package:Orgit/Components/Button/defaultButton.dart';
import 'package:Orgit/statics.dart';

class Joingroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Statics.background,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              const Image(
                image: AssetImage('assets/map.png'),
              ),
              Text(
                'Vítej v Orgitu',
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
