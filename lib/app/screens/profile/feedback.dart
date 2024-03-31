import 'package:flutter/material.dart';

// ignore: camel_case_types
class feedBack extends StatefulWidget {
  const feedBack({super.key});

  @override
  State<feedBack> createState() => _feedBackState();
}

// ignore: camel_case_types
class _feedBackState extends State<feedBack> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Feedback',
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
    );
  }
}
