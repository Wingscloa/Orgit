import 'package:flutter/material.dart';
import 'package:my_awesome_namer/Pages/Settings/hesloZabezpeceni.dart';
import 'package:my_awesome_namer/Pages/Settings/upravitInformace.dart';
import '../../Components/Backgrounds/BckMain.dart';

class Account extends StatelessWidget {
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
                'Osobní údaje',
                style: TextStyle(
                  color: Color.fromARGB(255, 107, 66, 38),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Container(
            margin: EdgeInsets.only(top: 125),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AccountInformations(
                      Name: 'Lukáš Buriánek',
                      Birthday: '27. února 2007',
                      Address: 'Družstevní 63/4 Děčín',
                      Contact: 'muj.Email@gmail.com, +420 704 030 733',
                      Section: '3. oddíl vodních skautů, Úsvit Děčín',
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 110,
                      width: 330,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(66, 255, 255, 255),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            CustomButton(
                              icon: Icons.person,
                              header: 'Upravit informace o účtě',
                              onTap: () => {goToProfileEdit(context)},
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              icon: Icons.security,
                              header: 'Heslo a zabezpečení',
                              onTap: () => {goToPassword(context)},
                            )
                          ],
                        ),
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

  goToPassword(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Heslozabezpeceni()));
  }

  goToProfileEdit(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Upravitinformace()));
  }
}

class InfoText extends StatelessWidget {
  final String header;
  final String note;
  const InfoText({required this.header, required this.note});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 1.5,
        ),
        Text(
          note,
          style: TextStyle(
            color: Colors.white.withOpacity(0.46),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class AccountInformations extends StatelessWidget {
  final String Name;
  final String Birthday;
  final String Address;
  final String Contact;
  final String Section;
  const AccountInformations({
    required this.Name,
    required this.Address,
    required this.Birthday,
    required this.Contact,
    required this.Section,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      width: 330,
      decoration: BoxDecoration(
          color: Color.fromARGB(66, 255, 255, 255),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoText(header: 'Jméno a příjmení', note: Name),
            SizedBox(
              height: 15,
            ),
            InfoText(header: 'Datum narození', note: Birthday),
            SizedBox(
              height: 15,
            ),
            InfoText(header: 'Místo bydliště', note: Address),
            SizedBox(
              height: 15,
            ),
            InfoText(header: 'Kontaktní údaje', note: Contact),
            SizedBox(
              height: 15,
            ),
            InfoText(header: 'Oddíl a středisko', note: Section),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String header;
  final GestureTapCallback onTap;
  const CustomButton(
      {required this.icon, required this.header, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white.withOpacity(0.5),
                ),
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
