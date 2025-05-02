import 'package:flutter/material.dart';
import 'package:orgit/global_vars.dart';

class SectionSwitch extends StatelessWidget {
  final bool value;
  final Function(bool) onTap;
  SectionSwitch({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pozastavit vše",
                style: Global.defaultStyle(19, false),
              ),
              Text(
                "Dočasné pozastavení upozornění",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.withAlpha(200),
                ),
              ),
            ],
          ),
          Switch(
              splashRadius: 4,
              activeColor: Color.fromARGB(255, 224, 176, 29),
              inactiveTrackColor: Color.fromARGB(255, 118, 118, 119),
              thumbColor: WidgetStatePropertyAll(Colors.white),
              value: value,
              onChanged: (bool value) => onTap(value)),
        ],
      ),
    );
  }
}
