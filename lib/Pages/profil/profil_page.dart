import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:orgit/utils/responsive_utils.dart';

class Profilpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Blur(
          blur: 4,
          blurColor: Color.fromARGB(255, 100, 100, 100),
          child: const Image(
            image: AssetImage('assets/backgroundMap.png'),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.getPaddingHorizontal(context),
                  vertical: ResponsiveUtils.getSpacingMedium(context),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: ResponsiveUtils.getIconSize(context),
                    ),
                    Text(
                      "Profil",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.getHeadingFontSize(context),
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: ResponsiveUtils.getIconSize(context),
                    )
                  ],
                ),
              ),
              SizedBox(height: ResponsiveUtils.getSpacingLarge(context)),
              // Profile picture
              Center(
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    border: Border.all(
                      color: Color.fromARGB(255, 224, 176, 29),
                      width: 2,
                    ),
                  ),
                  height: ResponsiveUtils.isSmallScreen(context) ? 120 : 140,
                  width: ResponsiveUtils.isSmallScreen(context) ? 120 : 140,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/profileIcon.png"),
                    backgroundColor: Color.fromARGB(255, 53, 54, 55),
                  ),
                ),
              ),

              SizedBox(height: ResponsiveUtils.getSpacingSmall(context)),

              // Nickname
              Text(
                "Víčko",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: ResponsiveUtils.getHeadingFontSize(context) * 1.2,
                  letterSpacing: 4,
                ),
              ),

              SizedBox(height: ResponsiveUtils.getSpacingSmall(context) * 0.5),

              // Full name
              Text(
                "Šimon Bumba",
                style: TextStyle(
                  color: Color.fromARGB(255, 170, 140, 80),
                  fontSize: ResponsiveUtils.getSubtitleFontSize(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3.5,
                ),
              ),

              SizedBox(height: ResponsiveUtils.getSpacingLarge(context)),

              // Menu section
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 37, 39),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: ResponsiveUtils.getSpacingLarge(context),
                    ),
                    child: Column(
                      children: [
                        ProfilPageButton(
                          icon: Icons.edit,
                          label: "upravit profil",
                          onTap: () => {print("mam upravit profil")},
                        ),
                        SizedBox(
                            height: ResponsiveUtils.getSpacingLarge(context)),
                        ProfilPageButton(
                          onTap: () => {
                            print("mam ukazat todolist"),
                          },
                          label: "todo list",
                          icon: Icons.checklist,
                        ),
                        SizedBox(
                            height: ResponsiveUtils.getSpacingLarge(context)),
                        ProfilPageButton(
                          onTap: () => {
                            print("mam spravovat dochazku"),
                          },
                          label: "docházka",
                          icon: Icons.person_pin_rounded,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfilPageButton extends StatelessWidget {
  const ProfilPageButton({
    required this.onTap,
    required this.label,
    required this.icon,
    super.key,
  });

  final GestureTapCallback onTap;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: ResponsiveUtils.getButtonWidth(context),
        height: ResponsiveUtils.getButtonHeight(context),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(255),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4),
            )
          ],
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 26, 27, 29),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.getSpacingMedium(context),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: ResponsiveUtils.getIconSize(context),
              ),
              SizedBox(width: ResponsiveUtils.getSpacingMedium(context)),
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: ResponsiveUtils.getSubtitleFontSize(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
