import 'package:flutter/material.dart';
import 'package:Orgit/Components/Inputs/TitleInput.dart';

void showModalInput(BuildContext context, TextEditingController controller,
    String hintText, GlobalKey<TitleInputState> targeKey) {
  OverlayState overlayState = Overlay.of(context);

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.black54,
        elevation: 12,
        child: InkWell(
          onTap: () {
            // targeKey.currentState?.updateIcon();
            entry.remove();
          },
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onSubmitted: (value) {
                    entry.remove();
                  },
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.white24,
                      decoration: TextDecoration.none,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  cursorColor: Colors.white,
                  cursorErrorColor: Colors.white,
                  style: TextStyle(
                      fontSize: 32,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(entry);
}
