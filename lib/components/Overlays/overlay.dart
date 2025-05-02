import 'package:flutter/material.dart';

abstract class StatefulOverlay extends StatefulWidget {
  final GestureTapCallback? onClose;
  StatefulOverlay({
    super.key,
    this.onClose,
  });
}

abstract class StatelessOverlay extends StatelessWidget {
  final Function? onClose;
  StatelessOverlay({super.key, this.onClose});
}
