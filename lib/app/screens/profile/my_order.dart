import 'package:Celebrare/app/bottom_nav.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'My Orders',
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
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text(
              'Uh oh!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF444343),
                fontSize: 24,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                height: 0.05,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'You dont have any recent orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF605F5F),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        BottomNav(initialIndex: 0),
                  ),
                );
              },
              child: Container(
                width: 200,
                height: 48,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: ShapeDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(1.00, -0.03),
                    end: Alignment(-1, 0.03),
                    colors: [Color(0xFF019A81), Color(0xFF2CCEC1)],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Continue ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.08,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            const SizedBox(
              width: 231,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text:
                          'If your purchased and invite is not visible here then please',
                      style: TextStyle(
                        color: Color(0xFF605F5F),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    TextSpan(
                      text: ' ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'contact us on 8005993442',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF007663),
                fontSize: 16,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF007663),
                height: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
