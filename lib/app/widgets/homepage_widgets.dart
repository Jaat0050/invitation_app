import 'package:Celebrare/app/bottom_nav.dart';
import 'package:Celebrare/app/screens/home/homepage.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:gif_view/gif_view.dart';
// import 'package:shimmer/shimmer.dart';

Widget cardTestinomial(Map<String, dynamic> item, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChatBubble(
          margin: const EdgeInsets.only(right: 15),
          clipper: ChatBubbleClipper6(type: BubbleType.receiverBubble),
          alignment: Alignment.topRight,

          // margin: EdgeInsets.only(top: 20),
          backGroundColor: const Color(0xffEBF3EE),
          child: SizedBox(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "An platform offering tools to design wedding Invitations and personalised greeting cards.",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  color: Color(0xdd605F5F),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 18),
                height: 60,
                child: Image.asset("assets/play_posted.jpg"),
              )
            ],
          )),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundImage: AssetImage(item["userimg"]),
                // minRadius: 26,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                item["name"],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  color: Color(0xdd444343),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: Color(0xffFAD515),
                    size: 16,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Color(0xffFAD515),
                    size: 16,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Color(0xffFAD515),
                    size: 16,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Color(0xffFAD515),
                    size: 16,
                  ),
                  Icon(
                    Icons.star_rounded,
                    color: Color(0xffFAD515),
                    size: 16,
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

// Widget vedioTestinomial() {
//   return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: const DecorationImage(
//               image: AssetImage("assets/BG.png"), fit: BoxFit.cover),
//           border: Border.all(
//             color: const Color(0xff007663),
//             width: 0.2,
//           ),
//           borderRadius: BorderRadius.circular(26),
//         ),
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(26),
//               gradient: const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     Colors.transparent,
//                     Colors.transparent,
//                     Colors.black
//                   ])),
//           child: const Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   'Priya Joshi',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Montserrat',
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   'Trusted us with Video Invite',
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     // fontFamily: 'Montserrat',
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ));
// }

Widget createInvitationButton(
  String text,
  void Function()? onTap, {
  bool isArrow = false,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 54,
      // width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20, right: 20),

      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment(1.00, -0.03),
          end: Alignment(-1, 0.03),
          colors: [
            Color(0xff029A82),
            Color(0xff2CCEC1),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              fontFamily: 'Roboto',
              color: Colors.white,
            ),
          ),
          isArrow
              ? const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(
                      minRadius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Color(0xff029A82),
                      ),
                    ),
                  ],
                )
              : Container()
        ],
      ),
    ),
  );
}

Widget topBanner(BuildContext context) {
  return Container(
    height: 71,
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.only(left: 20, right: 20),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromRGBO(203, 255, 251, 0.54),
          Color.fromRGBO(69, 154, 245, 1),
        ],
      ),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.star_border,
                  color: Color.fromRGBO(55, 113, 200, 1),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Holiday Sale',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(23, 22, 22, 1),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  'Get ',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(23, 22, 22, 1),
                  ),
                ),
                Text(
                  '10% OFF',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(23, 22, 22, 1),
                  ),
                ),
                Text(
                  ' on your order',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Montserrat',
                    color: Color.fromRGBO(23, 22, 22, 1),
                  ),
                ),
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: () {
            Fluttertoast.showToast(
              msg: "Coupon Code Copied",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color(0xFF007663),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          },
          child: Container(
            height: 25,
            width: 123,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                'GRAB DISCOUNT',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(19, 86, 210, 1),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}


Widget cardholidaySaveWidget(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(
      top: 38,
    ),
    color: const Color(0xffF1DAD3),
    height: 117,
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Holiday Sale',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  color: Color(0xff740006),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Row(
                children: [
                  Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat',
                      color: Color(0xff171616),
                    ),
                  ),
                  Text(
                    ' Upto 10%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                      color: Color(0xff171616),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03595A),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                  ),
                  minimumSize: const Size(60, 27),
                ),
                child: const Text(
                  'Shop Now',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
            width: 150,
            height: 117,
            child: Image.asset(
              "assets/saleBg.png",
              fit: BoxFit.fill,
            ))
      ],
    ),
  );
}

Widget watchOnYoutube(
  BuildContext context, {
  required String item,
  required String bgImage,
  required String caption,
}) {
  return SizedBox(
    width: MediaQuery.of(context).size.width,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(left: 45, right: 45),
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
          child: Column(
            children: [
              const Text(
                "How to create Wedding Invitation ?",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat',
                  color: Color(0xff605F5F),
                ),
              ),
              GestureDetector(
           
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDiaVideolog(
                        item: item,
                        bgImage: bgImage,
                        caption: caption,
                      );
                    },
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 66, vertical: 14),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png?20220706172052',
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Watch Video',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          color: Color(0xff605F5F),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Text homepageHeading(String text, {double fontSize = 16}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      fontFamily: 'Montserrat',
      color: const Color(0xff171616),
    ),
  );
}

Widget videoCatatlogue(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 27),
    child: Column(
      children: [
        const Row(
          children: [
            Text(
              'Looking For',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                color: Color(0xff171616),
              ),
            ),
            Text(
              ' Invitation Card ?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                color: Color(0xff007663),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 0.6,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/video_tutorial_bg.png"),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: homepageHeading("Video Invitation"),
                ),
                const Text(
                  "Wedding Video invites with stunning designs, personalized songs & fast 1-2 day delivery.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                    color: Color(0xff5E5E5E),
                  ),
                ),
                createInvitationButton("Let’s Create Your Invitation", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Map<String, String>>(
                      builder: (BuildContext context) => BottomNav(
                        initialIndex: 2,
                      ),
                    ),
                  );
                }),
              ],
            ))
      ],
    ),
  );
}

Widget cardCatatlogue(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 27),
    child: Column(
      children: [
        const Row(
          children: [
            Text(
              'Looking For',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                color: Color(0xff171616),
              ),
            ),
            Text(
              ' E-Card pdf?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
                color: Color(0xff007663),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 0.6,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/card_catalogue.webp"),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: homepageHeading("PDF Invitation"),
                ),
                const Text(
                  "Wedding Card invites with stunning designs, personalized songs & fast 1-2 day delivery.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Montserrat',
                    color: Color(0xff5E5E5E),
                  ),
                ),
                createInvitationButton("Let’s Create Your Invitation", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => BottomNav(
                        initialIndex: 1,
                      ),
                    ),
                  );
                }),
              ],
            ))
      ],
    ),
  );
}
