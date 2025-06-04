import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final Color confirmButtonColor;
  final Color cancelButtonColor;

  const ConfirmationModal({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
    this.onCancel,
    this.confirmText = "Ano",
    this.cancelText = "Ne",
    this.confirmButtonColor = const Color.fromARGB(255, 255, 203, 105),
    this.cancelButtonColor = const Color.fromARGB(255, 26, 27, 29),
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Color(0xFF131416),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.getPaddingHorizontal(context)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: ResponsiveUtils.getSpacingMedium(context)),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveUtils.getSubtitleFontSize(context),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveUtils.getSpacingMedium(context)),
            Text(
              message,
              style: TextStyle(
                color: Colors.white70,
                fontSize: ResponsiveUtils.getBodyTextFontSize(context),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveUtils.getSpacingLarge(context)),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onCancel ?? () => Navigator.of(context).pop(),
                    child: Container(
                      height: ResponsiveUtils.getButtonHeight(context) * 0.8,
                      decoration: BoxDecoration(
                        color: cancelButtonColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: Center(
                        child: Text(
                          cancelText,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                ResponsiveUtils.getBodyTextFontSize(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ResponsiveUtils.getSpacingMedium(context)),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    child: Container(
                      height: ResponsiveUtils.getButtonHeight(context) * 0.8,
                      decoration: BoxDecoration(
                        color: confirmButtonColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          confirmText,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize:
                                ResponsiveUtils.getBodyTextFontSize(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ResponsiveUtils.getSpacingMedium(context)),
          ],
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmText = "Ano",
    String cancelText = "Ne",
    Color confirmButtonColor = const Color.fromARGB(255, 255, 203, 105),
    Color cancelButtonColor = const Color.fromARGB(255, 26, 27, 29),
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ConfirmationModal(
        title: title,
        message: message,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmButtonColor: confirmButtonColor,
        cancelButtonColor: cancelButtonColor,
      ),
    );
  }
}
