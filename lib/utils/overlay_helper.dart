import 'package:flutter/material.dart';
import 'package:orgit/components/overlays/overlay.dart';

class OverlayHelper {
  static void showOverlay(BuildContext context, StatefulOverlay widget) {
    final overlay = Overlay.of(context, rootOverlay: true);
    late OverlayEntry overlayEntry;
    widget.onClose = () => overlayEntry.remove();
    overlayEntry = OverlayEntry(builder: (context) => widget);
    overlay.insert(overlayEntry);
  }
}
