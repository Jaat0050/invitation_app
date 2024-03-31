import 'package:Celebrare/app/bottom_nav.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
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
          'My Wishlist',
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
              'Your Wishlist is empty!',
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
              height: 30,
            ),
            const Text(
              'Continue to explore and add items in wishlist',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF605F5F),
                fontSize: 13.14,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            const SizedBox(
              height: 50,
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
                      'Continue Shopping',
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
            )
          ],
        ),
      ),
    );
  }
}
