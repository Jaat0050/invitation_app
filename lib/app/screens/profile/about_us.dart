import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'About us',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(38, 38, 38, 1),
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const SizedBox(
            width: 25,
            height: 25,
            child: Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ),
      body: const SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(left: 15, right: 15, top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'We have a wide range of Royal Indian wedding cards. So if you are looking for Digital Invite, you are at the Right Place. Wondering what else we can help you with? So here we are with our Greeting Cards that can make it easy for you to express your feelings to loved ones. We tried to bring the feel of opening a real greeting card in a Digital one. On top of everything, we want to have a customer relation like Tata and Zappos.',
              style: TextStyle(
                color: Color(0xFF605F5F),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 1.8,
              ),
            ),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
