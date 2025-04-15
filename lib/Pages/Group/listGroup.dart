import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Orgit/Components/Background/MenuBckg.dart';

class listGroup extends StatelessWidget {
  final TextEditingController search = TextEditingController();
  @override
  
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; 
    return Scaffold(
      body: Stack(
        children: [
          MenuBckg(),
          Positioned.fill(child: Column(
            children: [
              const Image(
                image: AssetImage('assets/map.png'),
              ),
            ],
          ),),
          Padding(
            padding: const EdgeInsets.only(top: 90),
            child: Container(
              decoration: BoxDecoration(
              color: Color.fromARGB(255, 41, 43, 47),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              border: Border(top: BorderSide(color: Color.fromARGB(255, 60, 60, 60)))),
              width: double.infinity,
              height: double.infinity,
              child: 
              Stack(
                children:[
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth - 70, top: 22),
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 26, 25, 25),
                        borderRadius: BorderRadius.all(Radius.circular(8))
                      ),
                      child: ImageIcon(AssetImage("assets/cancel.png"), color: Colors.white60),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 88),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Připojit se ke skupině', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26)),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 105),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       SearchBar(width: 300, height: 37.5, borderColor: const Color.fromARGB(255, 255, 255, 255), controller: search, textColor: Colors.white,),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],),
  );}
}

class SearchBar extends StatelessWidget{
  final TextEditingController controller;
  final double? width;
  final double? height;
  final Color borderColor;
  final Color textColor;
  
  SearchBar({
    required this.controller, 
    required this.borderColor,
    required this.height,
    required this.width,
    required this.textColor
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: width,
      height: height,
      child: 
      TextField(
        enabled: true,
        buildCounter: null,
        textCapitalization: TextCapitalization.none,
        maxLength: 16,
        maxLines: 1,
        controller: controller,
        textAlign: TextAlign.start,
        cursorHeight: height !- 18,
        style: TextStyle(
          fontSize: 16,
          color: textColor,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white),
          isDense: true,
          labelStyle: TextStyle(
            fontSize: 12,
            color: Colors.white
          ),
          labelText: "Hledat skupinu",
          counterText: "",
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color : Color.fromARGB(255, 60, 60, 60)
            ),
            borderRadius: BorderRadius.all(Radius.circular(8))
          ),
          focusedBorder: 
          const OutlineInputBorder(
            borderSide: BorderSide(
              color : Color.fromARGB(255, 90, 90, 90)
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
      ),
    );
  }
}