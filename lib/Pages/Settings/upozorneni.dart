import 'package:flutter/material.dart';
import 'package:my_awesome_namer/constants.dart';
import '../../Components/Backgrounds/BckMain.dart';

class Upozorneni extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MainBackground(),
          Container(
            margin: EdgeInsets.only(top: 50, left: 40),
            child: Text(
              'Upozornění',
              style: TextStyle(
                color: Color.fromARGB(255, 107, 66, 38),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 330,
                      height: 330,
                      child: Column(
                        children: [
                          CustomButton(
                              header: 'Tichý režim',
                              onTap: () => {print('Tichy rezim')}),
                          SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              header: 'Akce', onTap: () => {print('Akce')}),
                          SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              header: 'To Do', onTap: () => {print('To Do')})
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
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
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Text(header,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15))
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white,
            )
          ]),
          SizedBox(
            height: 0.5,
          ),
          Container(
            height: 1,
            width: 330,
            decoration: BoxDecoration(color: Color.fromARGB(255, 107, 66, 38)),
          )
        ],
      ),
    );
  }
}
