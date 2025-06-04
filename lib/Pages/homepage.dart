import 'package:flutter/material.dart';
import 'package:orgit/pages/Calendar/calendar_page.dart';
import 'package:orgit/pages/Event/event_page.dart';
import 'package:orgit/pages/Group/group_page.dart';
import 'package:orgit/pages/profil/profil_page.dart';
import 'package:orgit/pages/Todo/todo_page.dart';
import 'package:orgit/global_vars.dart';
import 'package:orgit/utils/responsive_utils.dart';

class Homepage extends StatefulWidget {
  final int initPage;

  Homepage({required this.initPage});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _pageController = PageController();
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initPage;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(widget.initPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Global.background,
      bottomNavigationBar: Container(
        height: ResponsiveUtils.isSmallScreen(context) ? 60 : 70,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
          color: Color.fromARGB(255, 35, 35, 35),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(0, Icons.calendar_month),
            _buildNavItem(1, Icons.event),
            _buildNavItem(2, Icons.group),
            _buildNavItem(3, Icons.checklist),
            _buildNavItem(4, Icons.person),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            children: <Widget>[
              Calendarpage(),
              Eventpage(),
              Grouppage(),
              Todolistpage(),
              Profilpage(),
            ],
            onPageChanged: (page) {
              setState(() {
                selectedIndex = page;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon) {
    final isSelected = selectedIndex == index;
    return InkWell(
      onTap: () => onTapItem(index),
      child: Container(
        padding: EdgeInsets.all(ResponsiveUtils.getSpacingSmall(context)),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 255, 203, 105).withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: isSelected ? Color.fromARGB(255, 255, 203, 105) : Colors.white,
          size: ResponsiveUtils.getIconSize(context),
        ),
      ),
    );
  }

  void onTapItem(int value) {
    setState(() {
      selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
