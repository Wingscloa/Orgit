import 'package:flutter/material.dart';
import 'package:orgit/components/bar/slide_bar.dart';

class TopBarDown extends StatelessWidget {
  const TopBarDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onVerticalDragUpdate: (details) => {
              if (details.delta.dy > 0)
                {print("tahas dolu")}
              else
                {print("tahas nahoru")}
            },
        child: Container(
          color: Colors.white,
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
