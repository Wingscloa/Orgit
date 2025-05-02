import 'package:flutter/material.dart';

abstract class StatefulOverlay extends StatefulWidget {
  late final GestureTapCallback? onClose;
  StatefulOverlay({
    super.key,
    this.onClose,
  });
}

abstract class StatelessOverlay extends StatelessWidget {
  late final Function? onClose;
  StatelessOverlay({super.key, this.onClose});
}
