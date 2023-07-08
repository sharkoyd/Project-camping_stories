import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'ControllerBottomNavigation.dart';
import 'CreatePage.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';

class MotherScreen extends StatelessWidget {
  const MotherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controllerNav = Get.put(ControllerBottomNavigation());
    return SafeArea(
      child: PersistentTabView(
        context,
        controller: controllerNav.controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: const Color(0xff1d113c), // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(0.0),
          colorBehindNavBar: const Color(0xff1d113c),
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      ),
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const HomePage(),
    const CreatePage(),
    const ProfilePage(),
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(
        CupertinoIcons.add,
        color: Color(0xffFD6F40),
        size: 50,
      ),
      title: ("Create"),
      activeColorPrimary: const Color(0xff1d113c),
      inactiveColorPrimary: const Color(0xff1d113c),
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.person),
      title: ("Profile"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}
