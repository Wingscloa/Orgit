import 'package:flutter/material.dart';
import 'package:my_awesome_namer/constants.dart';
import '../../Components/Backgrounds/BckMain.dart';

class Heslozabezpeceni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MainBackground(),
          Container(
            margin: EdgeInsets.only(top: 50, left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Heslo a',
                  style: TextStyle(
                    color: Color.fromARGB(255, 107, 66, 38),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'zabezpečení',
                  style: TextStyle(
                    color: Color.fromARGB(255, 107, 66, 38),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Heslo a zabezpečení',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 330,
                    height: 330,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(66, 255, 255, 255),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          CustomButton(
                              header: 'Změna hesla',
                              onTap: () => {print('Zmena hesla')}),
                          SizedBox(
                            height: 16,
                          ),
                          CustomButton(
                              header: 'Dvoufázové ověření',
                              onTap: () => {print('Dvoufazove overeni')})
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String header;
  final GestureTapCallback onTap;
  const CustomButton({required this.header, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(header,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
            Icon(
              Icons.chevron_right,
              color: Colors.white,
            )
          ]),
          SizedBox(
            height: 0.5,
          ),
          Container(
            height: 1.5,
            width: 330,
            decoration: BoxDecoration(color: Color.fromARGB(255, 107, 66, 38)),
          )
        ],
      ),
    );
  }
}
