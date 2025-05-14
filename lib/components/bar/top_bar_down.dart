import 'package:flutter/material.dart';
import 'package:orgit/components/bar/slide_bar.dart';
import 'package:orgit/global_vars.dart';

class TopBarDown extends StatelessWidget {
  const TopBarDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) async {
          if (details.delta.dy > 0) {
            bool? result = await showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: Global.settings,
                title: Text(
                  'Opravdu chcete odejít?',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Text(
                  'Veškerý postup bude ztracen.',
                  style: TextStyle(
                    color: Colors.white.withAlpha(122),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(
                      'Ne',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 203, 105),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      'Ano',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );

            if (result == true) {
              Navigator.pushReplacementNamed(context, '/');
            }
          }
        },
        child: Container(
          color: Global.settings,
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              SlideBar(),
              SizedBox(
                height: 4,
              ),
              SlideBar()
            ],
          ),
        ));
  }
}
