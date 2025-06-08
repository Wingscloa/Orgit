import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';

class TelephoneInput extends StatefulWidget {
  const TelephoneInput({
    super.key,
    required this.prefixController,
    required this.phoneController,
  });

  final TextEditingController prefixController;
  final TextEditingController phoneController;

  @override
  State<TelephoneInput> createState() => _TelephoneInputState();
}

class _TelephoneInputState extends State<TelephoneInput> {
  Color checkIconColor = Colors.white;

  @override
  void initState() {
    super.initState();
    widget.prefixController.addListener(_validateInput);
    widget.phoneController.addListener(_validateInput);
  }

  @override
  void dispose() {
    widget.prefixController.removeListener(_validateInput);
    widget.phoneController.removeListener(_validateInput);
    super.dispose();
  }

  void _validateInput() {
    String prefix = widget.prefixController.text.trim();
    String phone = widget.phoneController.text.trim();

    // Remove + from prefix if present
    if (prefix.startsWith('+')) {
      prefix = prefix.substring(1);
    }

    setState(() {
      bool isPrefixValid =
          prefix.length == 3 && RegExp(r'^\d{3}$').hasMatch(prefix);
      bool isPhoneValid =
          phone.length == 9 && RegExp(r'^\d{9}$').hasMatch(phone);

      if (isPrefixValid && isPhoneValid) {
        checkIconColor = Colors.green;
      } else if (prefix.isNotEmpty || phone.isNotEmpty) {
        checkIconColor = Colors.red;
      } else {
        checkIconColor = Colors.white;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: ResponsiveUtils.getSpacingSmall(context) * 0.25,
            left: ResponsiveUtils.getSpacingSmall(context),
            right: ResponsiveUtils.getSpacingLarge(context),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Telefon',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveUtils.getBodyTextFontSize(context) * 0.8,
                  color: Color.fromARGB(255, 87, 88, 90),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: ResponsiveUtils.isSmallScreen(context) ? 55 : 70,
              height: ResponsiveUtils.getButtonHeight(context) * 0.75,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    bottomLeft: Radius.circular(6)),
              ),
              child: Padding(
                padding:
                    EdgeInsets.all(ResponsiveUtils.getSpacingSmall(context)),
                child: TextField(
                  decoration: null,
                  controller: widget.prefixController,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.getBodyTextFontSize(context),
                  ),
                  cursorHeight: 25,
                  cursorColor: Colors.white.withAlpha(125),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Container(
              width: ResponsiveUtils.isSmallScreen(context)
                  ? MediaQuery.of(context).size.width * 0.45
                  : 215,
              height: ResponsiveUtils.getButtonHeight(context) * 0.75,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 27, 29),
                  border: Border.all(color: Colors.white, width: 0.05)),
              child: Padding(
                padding:
                    EdgeInsets.all(ResponsiveUtils.getSpacingSmall(context)),
                child: TextField(
                  decoration: null,
                  controller: widget.phoneController,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveUtils.getBodyTextFontSize(context),
                  ),
                  cursorHeight: 25,
                  cursorColor: Colors.white.withAlpha(125),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            Container(
              width: 30,
              height: ResponsiveUtils.getButtonHeight(context) * 0.75,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 27, 29),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(6),
                    bottomRight: Radius.circular(6)),
              ),
              child: InkWell(
                child: Icon(
                  Icons.check,
                  color: checkIconColor,
                  size: ResponsiveUtils.getIconSize(context) * 0.7,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
