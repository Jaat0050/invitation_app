import 'package:Celebrare/app/screens/profile/about_us.dart';
import 'package:Celebrare/app/screens/profile/feedback.dart';
import 'package:Celebrare/app/screens/profile/my_draft.dart';
import 'package:Celebrare/app/screens/profile/my_order.dart';
import 'package:Celebrare/app/screens/profile/privacy_policy.dart';
import 'package:Celebrare/app/screens/profile/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Profile",
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                color: Color(0xff605F5F),
                fontSize: 16)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 53,
                  height: 53,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                        image: AssetImage('assets/BG.png'), fit: BoxFit.cover),
                  ),
                ),
                const Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Smruti Tiwari",
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "09 6543 3221",
                            style: TextStyle(
                                color: Color(0xff909090),
                                fontFamily: 'Montserrat',
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            settingContainer(
              () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const OrderScreen(),
                  ),
                );
              },
              'My Orders',
              "assets/profile_icons/my_orders.svg",
              // isSelected: true,
            ),
            settingContainer(
              () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const DraftScreen(),
                  ),
                );
              },
              'My Draft',
              "assets/profile_icons/my_draft.svg",
            ),
            settingContainer(
              () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const WishlistScreen(),
                  ),
                );
              },
              'Your Wishlist',
              "assets/profile_icons/wishlist.svg",
            ),
            settingContainer(
              () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const AboutUs(),
                  ),
                );
              },
              'About US',
              "assets/profile_icons/about_us.svg",
            ),
            settingContainer(
              () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const feedBack(),
                  ),
                );
              },
              'Feedback',
              "assets/profile_icons/feedback.svg",
            ),
            settingContainer(
              () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const PrivacyPolicy(),
                  ),
                );
              },
              'Privacy Policy',
              "assets/profile_icons/privacy.svg",
            ),
            settingContainer(
              () {},
              'Logout',
              "assets/profile_icons/log_out.svg",
            ),
          ],
        ),
      ),
    );
  }

  Widget settingContainer(VoidCallback onTap, String text, String svg,
      {bool isSelected = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F0D230A), // Shadow color
                blurRadius: 50,
                spreadRadius: 0,
                offset: Offset(10, 24),
              ),
            ]),
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                // decoration: BoxDecoration(
                //     color: appColor, borderRadius: BorderRadius.circular(5)),
                child: SvgPicture.asset(
                  svg,
                  // ignore: deprecated_member_use
                  color: isSelected
                      ? const Color(0xff007663)
                      : const Color(0xff666666),
                  width: 24,
                  height: 24,
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  text,
                  style: TextStyle(
                      color: isSelected
                          ? const Color(0xff007663)
                          : const Color(0xff666666),
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xff007663),
            )
          ],
        ),
      ),
    );
  }
}
