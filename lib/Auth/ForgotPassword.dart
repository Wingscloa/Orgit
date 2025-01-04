// import 'dart:developer';
// import 'Registrace.dart';
// import 'package:flutter/material.dart';
// import 'package:my_awesome_namer/Pages/Auth/Auth.dart';
// import '../../../constants.dart';
// import '../../Components/LogInRegister/LoginInput.dart';
// import '../../Components/LogInRegister/LoginSubmit.dart';
// import '../../Components/Backgrounds/BckLogin.dart';

// class Forgotpassword extends StatefulWidget {
//   const Forgotpassword({
//     super.key,
//   });

//   @override
//   State<Forgotpassword> createState() => _ForgotpasswordState();
// }

// class _ForgotpasswordState extends State<Forgotpassword> {
//   final _auth = AuthService();

//   var user;
//   final _email = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           LoginPageBackground(
//             position: 160,
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 110, left: 40),
//             child: Text(
//               'Změnit heslo',
//               style: TextStyle(
//                 color: Color.fromARGB(255, 107, 66, 38),
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Center(
//                 child: Container(
//                   height: 350,
//                   width: 350,
//                   padding: EdgeInsets.all(32),
//                   decoration: BoxDecoration(
//                       color: Color(0x1A142131),
//                       border: Border.all(
//                         color: Color(0x1AFFFFFF),
//                         width: 1,
//                       ),
//                       borderRadius: BorderRadius.circular(32)),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Logininput(
//                         title: EmailTitle,
//                         hint: EmailHint,
//                         password: false,
//                         controller: _email,
//                       ),
//                       SizedBox(
//                         height: 27,
//                       ),
//                       BackButton(
//                         onTap: () => {_auth.ChangePassword(_email.text)},
//                         nazev: 'Změnit heslo',
//                         color: Color(0x26203145),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       BackButton(
//                         onTap: () => {goToRegistration(context)},
//                         nazev: 'Zpět',
//                         color: Color.fromARGB(37, 190, 206, 224),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   goToRegistration(BuildContext context) => Navigator.push(
//       context, MaterialPageRoute(builder: (context) => Registration()));
// }

// class BackButton extends StatelessWidget {
//   final VoidCallback onTap;
//   final String nazev;
//   final Color color;

//   const BackButton(
//       {required this.onTap, required this.nazev, required this.color, Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 350, // Šířka
//         height: 70, // Výška
//         decoration: BoxDecoration(
//           color: color, // Barva s 15 % neprůhledností
//           borderRadius: BorderRadius.circular(12), // Zaoblení rohů
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Text(
//                 nazev,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
