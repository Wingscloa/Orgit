// import 'dart:developer';
// import 'Login.dart';
// import 'package:flutter/material.dart';
// import 'package:my_awesome_namer/Pages/Auth/Auth.dart';
// import '../../../constants.dart';
// import '../../Components/LogInRegister/LoginInput.dart';
// import '../../Components/LogInRegister/LoginSubmit.dart';
// import '../../Components/Backgrounds/BckLogin.dart';
// import 'ForgotPassword.dart';

// class Registration extends StatefulWidget {
//   const Registration({
//     super.key,
//   });

//   @override
//   State<Registration> createState() => _RegistrationState();
// }

// class _RegistrationState extends State<Registration> {
//   final _auth = AuthService();

//   final _email = TextEditingController();
//   final _password = TextEditingController();
//   final _passwordVerification = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           children: [
//             LoginPageBackground(
//               position: 100,
//             ),
//             Container(
//               margin: EdgeInsets.only(top: 50, left: 40),
//               child: Text(
//                 'Registrace',
//                 style: TextStyle(
//                   color: Color.fromARGB(255, 107, 66, 38),
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Container(
//                       height: 460,
//                       width: 350,
//                       padding: EdgeInsets.all(32),
//                       decoration: BoxDecoration(
//                           color: Color(0x1A142131),
//                           border: Border.all(
//                             color: Color(0x1AFFFFFF),
//                             width: 1,
//                           ),
//                           borderRadius: BorderRadius.circular(32)),
//                       child: Column(
//                         children: [
//                           Logininput(
//                             title: EmailTitle,
//                             hint: EmailHint,
//                             password: false,
//                             controller: _email,
//                           ),
//                           SizedBox(
//                             height: 13.5,
//                           ),
//                           Logininput(
//                             title: PasswordTitle,
//                             hint: PasswordHint,
//                             password: true,
//                             controller: _password,
//                           ),
//                           SizedBox(
//                             height: 13.5,
//                           ),
//                           Logininput(
//                             title: PasswordTitleVer,
//                             hint: PasswordHintVer,
//                             password: true,
//                             controller: _passwordVerification,
//                           ),
//                           SizedBox(
//                             height: 27,
//                           ),
//                           LogInSubmit(
//                             register: true,
//                             onTap: signUp,
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Máš už účet?',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               InkWell(
//                                 onTap: () =>
//                                     {print('Login'), goToPage(context)},
//                                 child: Text(
//                                   'Přihlaš se!',
//                                   style: TextStyle(
//                                     color: Color.fromARGB(255, 255, 241, 173),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'Nepamatuješ si heslo?',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(width: 5),
//                               InkWell(
//                                 onTap: () =>
//                                     {print('Login'), goToChangePass(context)},
//                                 child: Text(
//                                   'Změň si ho!',
//                                   style: TextStyle(
//                                     color: Color.fromARGB(255, 255, 241, 173),
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       )),
//                 )
//               ],
//             )
//           ],
//         ));
//   }

//   signUp() async {
//     log(_email.text.length.toString());
//     log(_password.text.length.toString());
//     final user =
//         await _auth.createUserWithEmailAndPassword(_email.text, _password.text);

//     if (user == null) {
//       log('Registrace se nezdařila');
//     } else {
//       log('Registrace probehla úspěšné');
//     }
//   }

//   goToPage(BuildContext context) =>
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));

//   goToChangePass(BuildContext context) => Navigator.push(
//       context, MaterialPageRoute(builder: (context) => Forgotpassword()));
// }
