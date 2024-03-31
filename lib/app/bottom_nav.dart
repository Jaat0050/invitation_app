// ignore_for_file: deprecated_member_use

import 'package:Celebrare/app/screens/cards/all_card_invites.dart';
import 'package:Celebrare/app/screens/home/homepage.dart';
import 'package:Celebrare/app/screens/video/all_video_invites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class BottomNav extends StatefulWidget {
  int initialIndex;
  BottomNav({
    super.key,
    required this.initialIndex,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentindex = 0;

  List<Widget> screens = [
    const Homepage(),
    const AllCardsInvites(
      categoryParameter: 'all',
      index: 0,
      fromSelectedCategory: false,
    ),
    const VideoInvites(),
    // const ProfileScreen()
  ];

  void _onItemTapped(int index) async {
    if (index >= 0 && index < screens.length) {
      setState(() {
        currentindex = index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    currentindex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = const Color(0xff2EB691);
    return Scaffold(
      body: screens.elementAt(currentindex),
      bottomNavigationBar: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 39.40,
              offset: Offset(0, -7),
              spreadRadius: 0,
            )
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          iconSize: 24,
          selectedItemColor: selectedColor,
          unselectedItemColor: Colors.black,
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          selectedIconTheme: IconThemeData(color: selectedColor),
          unselectedLabelStyle: const TextStyle(
            color: Colors.black,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            fontSize: 10,
          ),
          selectedLabelStyle: TextStyle(
            color: selectedColor,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500,
            fontSize: 10,
          ),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/bottombar/home_icon.svg',
                color: currentindex == 0 ? selectedColor : Colors.grey.shade800,
                width: 25,
                height: 25,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/bottombar/cards_icon.svg',
                color: currentindex == 1 ? selectedColor : Colors.grey.shade800,
                width: 25,
                height: 25,
              ),
              label: 'Card Invite',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/bottombar/vedio_icon.svg',
                color: currentindex == 2 ? selectedColor : Colors.grey.shade800,
                width: 25,
                height: 25,
              ),
              label: 'Video Invite',
            ),
            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     'assets/bottombar/profile_icon.svg',
            //     color: currentindex == 3 ? selectedColor : Colors.grey.shade800,
            //     width: 25,
            //     height: 25,
            //   ),
            //   label: 'Profile',
            // ),
          ],
          currentIndex: currentindex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
