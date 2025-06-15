import 'dart:ui';
import 'package:orgit/Pages/role/role.dart';
import 'package:orgit/Components/Button/default_button.dart';
import 'package:orgit/components/icons/role_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/components/overlays/overlay.dart';
import 'package:orgit/components/header/ovr_header.dart';
import 'package:orgit/utils/responsive_utils.dart';
import 'dart:math';

class OverlayRoleCreate extends StatefulOverlay {
  OverlayRoleCreate({super.key});
  @override
  OverlayRoleCreateState createState() => OverlayRoleCreateState();
}

class OverlayRoleCreateState extends State<OverlayRoleCreate> {
  List<Role> roles = [
    Role(
        name: "Majitel",
        backgroundColor: Colors.red,
        icon: Icons.kayaking,
        iconColor: Colors.white,
        count: 1),
    Role(
        name: "Group moderátor",
        backgroundColor: Colors.green,
        icon: Icons.group,
        iconColor: Colors.white,
        count: 3),
    Role(
        name: "Report operátor",
        backgroundColor: Colors.black,
        icon: Icons.warning_outlined,
        iconColor: Colors.yellow,
        count: 1),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5),
    Role(
        name: "Kormidelník",
        backgroundColor: Colors.blue,
        icon: Icons.wheelchair_pickup,
        iconColor: Colors.yellow,
        count: 5)
  ];
  @override
  Widget build(BuildContext context) {
    final topRadius = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 40.0,
      tablet: 50.0,
      desktop: 60.0,
    );

    final headerPadding = EdgeInsets.only(
        top: ResponsiveUtils.getSpacingSmall(context) * 2,
        left: ResponsiveUtils.getPaddingHorizontal(context));

    final columnSpacing = ResponsiveUtils.getSpacingMedium(context);

    return Positioned(
      top: 55,
      bottom: 0,
      left: 0,
      right: 0,
      child: Material(
        animationDuration: 0.ms,
        borderOnForeground: false,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
        ),
        elevation: 20,
        color: Global.settings,
        child: Column(
          children: [
            Padding(
              padding: headerPadding,
              child: OverlayHeader(
                label: "Role skupiny",
                onTap: widget.onClose,
              ),
            ),
            SizedBox(height: columnSpacing),
            Expanded(
              child:
                  roles.isNotEmpty ? RoleGroup(roles: roles) : RoleGroupNull(),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleGroupNull extends StatelessWidget {
  const RoleGroupNull({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidth = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: MediaQuery.of(context).size.width * 0.7,
      tablet: MediaQuery.of(context).size.width * 0.5,
      desktop: MediaQuery.of(context).size.width * 0.4,
    );

    final titleFontSize = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: ResponsiveUtils.getHeadingFontSize(context),
      tablet: ResponsiveUtils.getHeadingFontSize(context) * 1.1,
      desktop: ResponsiveUtils.getTitleFontSize(context),
    );

    final descriptionFontSize = ResponsiveUtils.getBodyFontSize(context);

    final buttonWidth = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: MediaQuery.of(context).size.width * 0.85,
      tablet: MediaQuery.of(context).size.width * 0.7,
      desktop: MediaQuery.of(context).size.width * 0.5,
    );

    final buttonHeight = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 40.0,
      tablet: 45.0,
      desktop: 50.0,
    );

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.getSpacingMedium(context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: imageWidth,
              child: Image(
                image: AssetImage(
                  'assets/RoleGroupBackground.png',
                ),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: ResponsiveUtils.getSpacingMedium(context)),
            Column(
              children: [
                Text(
                  "Rozděl práci mezi ostatní",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 203, 105),
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.getSpacingSmall(context)),
                Container(
                  width: ResponsiveUtils.getResponsiveWidth(
                    context,
                    mobile: MediaQuery.of(context).size.width * 0.8,
                    tablet: MediaQuery.of(context).size.width * 0.6,
                    desktop: MediaQuery.of(context).size.width * 0.4,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Rozdělování práce je základ každého dobrého organizování. Používej role k jednoduššímu rozdělení prací. ",
                    style: TextStyle(
                      color: Global.settingsDescription,
                      fontSize: descriptionFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ResponsiveUtils.getSpacingLarge(context)),
            Defaultbutton(
              text: "Vytvořit roli",
              color: Color.fromARGB(255, 255, 203, 105),
              onTap: () => print("Vytvořit roli"),
              width: buttonWidth,
              textColor: Colors.black,
              height: buttonHeight,
            ),
          ],
        ),
      ),
    );
  }
}

class RoleGroup extends StatelessWidget {
  const RoleGroup({
    super.key,
    required this.roles,
  });

  final List<Role> roles;
  @override
  Widget build(BuildContext context) {
    final titleFontSize = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: ResponsiveUtils.getHeadingFontSize(context),
      tablet: ResponsiveUtils.getHeadingFontSize(context) * 1.1,
      desktop: ResponsiveUtils.getTitleFontSize(context),
    );

    final descriptionFontSize = ResponsiveUtils.getBodyFontSize(context);

    final descriptionWidth = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: MediaQuery.of(context).size.width * 0.7,
      tablet: MediaQuery.of(context).size.width * 0.6,
      desktop: MediaQuery.of(context).size.width * 0.4,
    );

    final buttonWidth = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: MediaQuery.of(context).size.width * 0.85,
      tablet: MediaQuery.of(context).size.width * 0.7,
      desktop: MediaQuery.of(context).size.width * 0.5,
    );
    final buttonHeight = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 40.0,
      tablet: 45.0,
      desktop: 50.0,
    );

    return Column(
      children: [
        // Hlavička - nadpis a popis
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getPaddingHorizontal(context) * 0.5,
            vertical: ResponsiveUtils.getSpacingSmall(context),
          ),
          child: Column(
            children: [
              Text(
                "Rozděl práci mezi ostatní",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 203, 105),
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: ResponsiveUtils.getSpacingSmall(context)),
              SizedBox(
                width: descriptionWidth,
                child: Text(
                  textAlign: TextAlign.center,
                  "Rozdělování práce je základ každého dobrého organizování. Používej role k jednoduššímu rozdělení prací. ",
                  style: TextStyle(
                    color: Colors.grey.withAlpha(125),
                    fontSize: descriptionFontSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Seznam rolí - v Expanded s SingleChildScrollView, aby se správně scrolloval
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.getPaddingHorizontal(context) * 0.5,
              ),
              child: Column(
                children: roles.map((role) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: ResponsiveUtils.getSpacingSmall(context),
                    ),
                    child: RoleContainer(
                      header: role.name,
                      count: role.count,
                      icon: role.icon,
                      iconColor: role.iconColor,
                      iconBackground: role.backgroundColor,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        // Tlačítko pro vytvoření nové role
        Padding(
          padding: EdgeInsets.only(
            bottom: ResponsiveUtils.getSpacingMedium(context),
            top: ResponsiveUtils.getSpacingSmall(context),
          ),
          child: Defaultbutton(
            text: "Vytvořit novou roli",
            color: Color.fromARGB(255, 255, 203, 105),
            onTap: () => print("Vytvorit novou roli"),
            width: buttonWidth,
            textColor: Colors.black,
            height: buttonHeight,
          ),
        ),
      ],
    );
  }
}

class RoleContainer extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String header;
  final int count;
  const RoleContainer({
    required this.header,
    required this.count,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final containerHeight = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 60.0,
      tablet: 65.0,
      desktop: 70.0,
    );

    final borderRadius = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 6.0,
      tablet: 8.0,
      desktop: 10.0,
    );

    final containerPadding = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 8.0,
      tablet: 10.0,
      desktop: 12.0,
    );

    final iconSpacing = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 15.0,
      tablet: 18.0,
      desktop: 20.0,
    );

    final headerFontSize = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 16.0,
      tablet: 18.0,
      desktop: 20.0,
    );

    final countFontSize = ResponsiveUtils.getResponsiveWidth(
      context,
      mobile: 13.0,
      tablet: 14.0,
      desktop: 15.0,
    );

    return GestureDetector(
      onTap: () => print("neco se ma stat"),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: containerHeight,
        decoration: BoxDecoration(
          color: Global.settingsButton,
          border: Border.all(
            color: Colors.white.withAlpha(20),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: ResponsiveUtils.isSmallScreen(context) ? 2 : 4,
              color: Colors.white.withAlpha(10),
              offset: Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(containerPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                spacing: iconSpacing,
                children: [
                  RoleIcon(
                    color: iconBackground,
                    icon: icon,
                    iconColor: iconColor,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        header,
                        style: TextStyle(
                          fontSize: headerFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        countToText(count),
                        style: TextStyle(
                          fontSize: countFontSize,
                          color: Colors.grey.withAlpha(140),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ResponsiveUtils.getSpacingSmall(context)),
                child: Transform.rotate(
                  angle: pi,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: ResponsiveUtils.getIconSize(context) * 0.7,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String countToText(int count) {
    if (count == 1) {
      return "$count člen";
    } else if (count < 5) {
      return "$count členové";
    } else {
      return "$count členu";
    }
  }
}
