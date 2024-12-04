import 'package:flutter/material.dart';
import 'package:my_awesome_namer/app_dimensions.dart';
import 'Components/Layout.dart';
import 'app_dimensions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Be Scout App",
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFFFBE79F),
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFFBE79F)),
        ),
        debugShowCheckedModeBanner: false,
        // home: MainLayout(),
        home: Builder(
          builder: (context) {
            AppDimensions.initialize(context);
            return MainLayout();
          },
        ));
  }
}
