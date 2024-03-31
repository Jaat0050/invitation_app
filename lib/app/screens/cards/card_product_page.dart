import 'package:Celebrare/app/models/custom_fonts.dart';
import 'package:Celebrare/app/screens/cards/all_card_invites.dart';
import 'package:Celebrare/app/widgets/homepage_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Celebrare/app/utils/editting_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProductScreen extends StatefulWidget {
  final Map<String, dynamic> cardTemplate;

  const ProductScreen({super.key, required this.cardTemplate});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final CarouselController cardcarouselController = CarouselController();
  int currentIndex = 0;
  List<Map<String, dynamic>> loadData = [];
  final String _brideName = 'Bride';
  final String _groomName = 'Groom';
  List<int> favIndices = [];
  List<Map<String, dynamic>> limittedToTwenty = [];
  String _category = 'all';
  bool isFav = false;
  bool isShare = true;
  bool isTryCard = true;
  bool isContactUs = true;

  List<Map<String, dynamic>> mainCardData = [];
  List videoReviewList = [];

  Map<String, int> indexIndicator = {
    "all": 0,
    "general": 1,
    "hindu": 2,
    "muslim": 3,
    "sikh": 4,
    "bengali": 5,
    "marathi": 6,
    "buddha": 7,
    "south_indian": 8,
    "christian": 9,
    "other": 10,
    "engagement": 11,
  };

  Future<List<Map<String, dynamic>>> fetchDataforCurrent(String cardId) async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot = await firestore
          .collection('weddinginvitations')
          .doc('allcard')
          .collection('cards')
          .doc(cardId)
          .get();
      if (snapshot.exists) {
     
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          setState(() {
            mainCardData.clear();
          });

          // data.forEach((key, value) {
          setState(() {
            mainCardData.add({
              'imageurl1': data['smallImgFrontLink'],
              'imageurl2': data['smallImgBackLink'],
              'cardarea': data['cardArea'],
              'text': data['text1'],
            });
          });
       

         
        } else {
         
        }
      } else {
       
      }
    } catch (error) {
    
    }
    return mainCardData;
  }

  //------------------------------similaritems......---------------------------------//
  Future<List<Map<String, dynamic>>> fetchDataforAll(
      String category, int index) async {
 
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      if (category == 'all' || category == 'general') {
        DocumentSnapshot snapshot = await firestore
            .collection('weddinginvitations')
            .doc(category)
            .collection('cards')
            .doc(index.toString())
            .get();
        if (snapshot.exists) {
         
          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
          if (data != null) {
            setState(() {
              loadData.clear();
            });

            data.forEach((key, value) {
              setState(() {
                loadData.add(
                  {
                    'imageUrl': value[0],
                    'cardId': value[1],
                    'tags': value[2],
                    'textstyle': value[3],
                    'category': value[4],
                  },
                );
              });
            });

            if (loadData.length > 10) {
              setState(() {
                limittedToTwenty.clear();
                limittedToTwenty = loadData.sublist(0, 10);
              });
            } else {
              setState(() {
                limittedToTwenty.clear();
                limittedToTwenty = loadData.sublist(0, loadData.length);
              });
            }
          } else {
         
          }
        } else {
         
        }
      } else {
        DocumentSnapshot snapshot = await firestore
            .collection('weddinginvitations')
            .doc(category) // Use the category variable here
            .get();
        if (snapshot.exists) {
         
          Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
          if (data != null) {
            setState(() {
              loadData.clear();
            });

            data.forEach((key, value) {
              setState(() {
                loadData.add(
                  {
                    'imageUrl': value[0],
                    'cardId': value[1],
                    'tags': value[2],
                    'textstyle': value[3],
                    'category': value[4],
                  },
                );
              });
            });
            if (loadData.length > 10) {
              setState(() {
                limittedToTwenty.clear();
                limittedToTwenty = loadData.sublist(0, 10);
              });
            } else {
              setState(() {
                limittedToTwenty.clear();
                limittedToTwenty = loadData.sublist(0, loadData.length);
              });
            }
          } else {
          
          }
        } else {
     
        }
      }
    } catch (error) {
   
    }
    return loadData;
  }

  void _onButtonTap(String urlValue, bool button) async {
    String url = urlValue;
    // "https://api.whatsapp.com/send/?phone=&text=Hello+I+'+d+like+to+place+an+order+for+the+video+with+video+ID+${widget.videoCardId}+and+I+have+a+few+questions+to+ask.&type=phone_number&app_absent=0";
    final encodedUrl = Uri.encodeFull(url);
    Uri uri = Uri.parse(encodedUrl);

    setState(() {
      button = false;
    });

    try {
      // await launchUrl(uri);
    } catch (e) {
    
    } finally {
      await Future.delayed(const Duration(seconds: 3));
      setState(() {
        button = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _category = widget.cardTemplate['category'];
    fetchDataforAll(_category, 1);
    fetchDataforCurrent(widget.cardTemplate['cardId']).then((_) {
      List<dynamic> cardDetails = mainCardData[0]['cardarea'].split(',');

      List<dynamic> cardFont1 = cardDetails[2].split('-');
      List<dynamic> cardFont2 = cardDetails[3].split('-');

      setState(() {
        videoReviewList = [
          {
            "id": 1,
            "textStyle": mainCardData[0]['text'],
            // "elsie,50,#285830,309,0,0,0=cookie,74,#F85800,389,-562,0,0=elsie,40,#285830,411,0,0,0=cookie,74,#F85800,387,555,0,0=elsie,36,#285830,499,0,0,0",
            "imageUrl": mainCardData[0]['imageurl1'],
            // 'https://firebasestorage.googleapis.com/v0/b/celebrare-b43da.appspot.com/o/weddinginvitations%2FSmall%2FFront%2Fa01f.jpg?alt=media&token=71e88260-78a0-4f92-aa47-84c92201a6ae',
            "content": [
              "Wedding Invitation",
              "Groom",
              "weds",
              "Bride",
              "28/12/2023",
            ],
          },
          {
            "id": 2,
            "textStyle":
                // "font2,94,color2,62,0=font1,102,color1,274,0=font2,58,color2,482,0=font2,58,color2,705,0=font1,102,color1,823,0=font2,58,color2,1031,0=font1,47,color1,1391,0",

                "${cardFont2[0]},80,${cardDetails[1]},62,0=${cardFont1[0]},95,${cardDetails[0]},258,0=${cardFont2[0]},48,${cardDetails[1]},420,0=${cardFont2[0]},48,${cardDetails[1]},740,0=${cardFont1[0]},95,${cardDetails[0]},825,0=${cardFont2[0]},48,${cardDetails[1]},980,0=${cardFont1[0]},45,${cardDetails[0]},1351,0",
            "imageUrl": mainCardData[0]['imageurl2'],
            // "https://firebasestorage.googleapis.com/v0/b/celebrare-b43da.appspot.com/o/weddinginvitations%2FMedium%2FBack%2Fa01b.jpg?alt=media&token=5d269a5c-7e75-4f3f-9a0d-067324fce512",
            "content": [
              "Wedding Ceremony",
              "Groom",
              "Son of\nFather Name & Mother Name\nGrandson of\nnames of grandparents will be here",
              "With",
              "Bride",
              "Daughter of\nFather Name and Mother Name\nGranddaughter of\nnames of grandparents will be here",
              "You are cordially invited to bless\nand we request honour\nof your presence",
            ],
          },
          {
            "id": 3,
            "textStyle":
                // "font2,54,color2,102,0=font1,102,color1,294,0=font2,58,color2,482,0=font1,102,color1,705,0=font2,58,color2,823,0=font1,102,color1,1031,0=font2,58,color2,1191,0",

                "${cardFont2[0]},50,${cardDetails[1]},95,0=${cardFont1[0]},102,${cardDetails[0]},238,0=${cardFont2[0]},46,${cardDetails[1]},410,0=${cardFont1[0]},95,${cardDetails[0]},590,0=${cardFont2[0]},46,${cardDetails[1]},762,0=${cardFont1[0]},95,${cardDetails[0]},960,0=${cardFont2[0]},46,${cardDetails[1]},1132,0",
            "imageUrl": mainCardData[0]['imageurl2'],
            // "https://firebasestorage.googleapis.com/v0/b/celebrare-b43da.appspot.com/o/weddinginvitations%2FMedium%2FBack%2Fa01b.jpg?alt=media&token=5d269a5c-7e75-4f3f-9a0d-067324fce512",
            "content": [
              "Wedding Functions",
              "Sangeet",
              "13th November 2021, 7 pm onwards\nHere the address of venue will come",
              "Tilak",
              "14th November 2021, 1 pm onwards \n Here the address of venue will come",
              "Milni",
              "14th November 2021, 1 pm onwards \n Here the address of venue will come",
            ],
            'carddetail': [
              cardDetails[4],
              cardDetails[5],
              cardDetails[6],
              cardDetails[7],
            ],
          },
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
      
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
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //====================================================================//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //------------------------------cards-------------------------//
                    SizedBox(
                      width: size.width,
                      height: 450,
                      child: CarouselSlider(
                        items: videoReviewList.isEmpty
                            ? null
                            : videoReviewList
                                .map(
                                  (item) =>
                                      mainCard(videoReviewList.indexOf(item)),
                                )
                                .toList(),
                        carouselController: cardcarouselController,
                        options: CarouselOptions(
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          height: 430,
                          enlargeCenterPage: true,
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: false,
                          enableInfiniteScroll: false,
                          aspectRatio: 2 / 3,
                          viewportFraction: 0.77,
                          onPageChanged: (index, reason) {
                            currentIndex = index;
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    //------------------------------dots---------------------------//
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: videoReviewList.asMap().entries.map((entry) {
                          return GestureDetector(
                            onTap: () => cardcarouselController.animateToPage(
                                curve: Curves.bounceInOut,
                                duration: const Duration(milliseconds: 20),
                                entry.key),
                            child: Container(
                              width: currentIndex == entry.key ? 12 : 7,
                              height: 7.0,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: currentIndex == entry.key
                                      ? const Color(0xff007663)
                                      : const Color(0xffD9D9D9)),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              //====================================================================//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      // height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 50),
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            // width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.cardTemplate['tags'] == 'normal'
                                      ? '₹299'
                                      : widget.cardTemplate['tags'] == 'premium'
                                          ? '₹399'
                                          : widget.cardTemplate['tags'] ==
                                                  'royal'
                                              ? '₹499'
                                              : '600',
                                  style: GoogleFonts.getFont(
                                    'Lora',
                                    textStyle: const TextStyle(
                                      // color: Color.fromRGBO(23, 22, 22, 1),
                                      color: Color.fromRGBO(147, 146, 146, 1),
                                      fontSize: 22,
                                      // fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 0.09,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                      widget.cardTemplate['tags'] == 'normal'
                                          ? '₹340'
                                          : widget.cardTemplate['tags'] ==
                                                  'premium'
                                              ? '₹440'
                                              : widget.cardTemplate['tags'] ==
                                                      'royal'
                                                  ? '₹540'
                                                  : '640',
                                      style: GoogleFonts.getFont(
                                        'Lora',
                                        textStyle: const TextStyle(
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                          decorationColor:
                                              Color.fromRGBO(147, 146, 146, 1),
                                          decorationThickness: 2,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          color:
                                              Color.fromRGBO(147, 146, 146, 1),
                                          fontSize: 16,
                                          // fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300,
                                          height: 0.09,
                                        ),
                                      )),
                                ),
                                const Spacer(),
                                Text(
                                  '60% OFF',
                                  style: GoogleFonts.getFont(
                                    'Lora',
                                    textStyle: const TextStyle(
                                      color: Color(0xff007663),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      height: 0.12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 28, vertical: 24),
                            child: Divider(
                                // indent: 20,
                                // endIndent: 20,
                                ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text(
                                  'Card Language:',
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '  English',
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: const TextStyle(
                                      color: Color(0xff007663),
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isFav = !isFav;
                                    });
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                          isFav
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: isFav
                                              ? const Color(0xff007663)
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                
                                  onTap: !isShare
                                      ? null
                                      : () async {
                                         
                                          final RenderBox box = context
                                              .findRenderObject() as RenderBox;

                                          setState(() {
                                            isShare = false;
                                          });

                                          try {
                                            // Share.share(
                                            //   'https://celebrare.in/product-page?cardID=${widget.cardTemplate['cardId']}',
                                            //   sharePositionOrigin:
                                            //       box.localToGlobal(
                                            //               Offset.zero) &
                                            //           box.size,
                                            // );
                                          } catch (e) {
                                          
                                          } finally {
                                            await Future.delayed(
                                                const Duration(seconds: 1));
                                            setState(() {
                                              isShare = true;
                                            });
                                          }
                                        },
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(55.0),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Icon(Icons.share),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    createInvitationButton(
                      'Try this card for Free',
                    
                      !isTryCard
                          ? null
                          : () async {
                             
                              _onButtonTap(
                                'https://celebrare.in/product-page?cardID=${widget.cardTemplate['cardId']}',
                                isTryCard,
                              );

                              // Add a 3-second delay

                              setState(() {
                                isTryCard = false;
                              });
                              await Future.delayed(const Duration(seconds: 3));
                              setState(() {
                                isTryCard = true;
                              });
                            },
                      isArrow: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //==================================================================//
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 180,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Want',
                              style: TextStyle(
                                color: Color(0xFF605F5F),
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: ' experts ',
                              style: TextStyle(
                                color: Color(0xFF019A81),
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: 'to create your invite?',
                              style: TextStyle(
                                color: Color(0xFF605F5F),
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    GestureDetector(
                     
                      onTap: !isContactUs
                          ? null
                          : () async {
                             
                              _onButtonTap(
                                'https://api.whatsapp.com/send/?phone=&text=Hey+Need+help&type=phone_number&app_absent=0',
                                isContactUs,
                              );

                              // Add a 3-second delay

                              setState(() {
                                isContactUs = false;
                              });
                              await Future.delayed(const Duration(seconds: 3));
                              setState(() {
                                isContactUs = true;
                              });
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 50),
                        // margin: const EdgeInsets.symmetric(
                        //     horizontal: 66, vertical: 14),

                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF019A81),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(58.0),
                        ),
                        child: const Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                            color: Color(0xFF019A81),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //====================================================================//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: homepageHeading("Check out these similar Invitations",
                    fontSize: 22),
              ),
              const SizedBox(height: 20),
              //====================================================================//
              similarCards(),
              //=====================================================================//
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: createInvitationButton(
                  'Explore all wedding invites',
                  () {
                   
                    Navigator.push(
                      context,
                      MaterialPageRoute<Map<String, String>>(
                        builder: (BuildContext context) => AllCardsInvites(
                          categoryParameter: _category,
                          fromSelectedCategory: true,
                          index: indexIndicator[_category] ?? 0,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainCard(
    int itemIndex,
  ) {
    // DateTime now = DateTime.now();
    // String formattedDate = DateFormat('dd\'th\' MMM, yyyy').format(now);
    List<TextStyleValues> basic = [];
    List<String> contentList = videoReviewList[itemIndex]['content'];

    if (itemIndex == 0) {
      basic = TextStyleParser.parseTextStyle(videoReviewList[0]['textStyle']);
    } else {
      basic = convertJsonToTextStyle(videoReviewList[itemIndex]['textStyle']);
    }

    return GestureDetector(
      onTap: () async {},
      child: FutureBuilder(
        future: precacheImage(
          CachedNetworkImageProvider(
            '${videoReviewList[itemIndex]['imageUrl']}',
          ),
          context,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                          0.5), // Adjust the shadow color as needed
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    AspectRatio(
                      aspectRatio: 2 / 3,
                      child: CachedNetworkImage(
                        imageUrl: '${videoReviewList[itemIndex]['imageUrl']}',
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          color: Color.fromRGBO(0, 118, 99, 1),
                        ),
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    ...List.generate(
                      basic.length,
                      (index) {
                        final textStyleValue =
                            TextStyleParser.scaleValues(basic[index]);

                        String fontFamily =
                            customizeFonts[textStyleValue.fontFamily]?[0] ?? "";

                        //-----------------------date-----------------------------------------------//
                        // DateTime now = DateTime.now();
                        // String formattedDate =
                        //     DateFormat('dd\'th\' MMM, yyyy').format(now);

                        //-------------------------data seperation from list--------------------------//
                        //----------------------------------------------------------------------------//

                        List<dynamic> textStyleValueslist;

                        List<dynamic> textStyleValues1;
                        List<dynamic> textStyleValues2;
                        List<dynamic> textStyleValues3;
                        List<dynamic> textStyleValues4;
                        List<dynamic> textStyleValues5;
                        List<dynamic> textStyleValues6;
                        List<dynamic> textStyleValues7;

                        //------------------------------------------------------------------------------//

                        String? fontFamily1;
                        String? fontFamily2;
                        String? fontFamily3;
                        String? fontFamily4;
                        String? fontFamily5;
                        String? fontFamily6;
                        String? fontFamily7;

                        double? originalFontSize1;
                        double? originalFontSize2;
                        double? originalFontSize3;
                        double? originalFontSize4;
                        double? originalFontSize5;
                        double? originalFontSize6;
                        double? originalFontSize7;

                        Color? color1;
                        Color? color2;
                        Color? color3;
                        Color? color4;
                        Color? color5;
                        Color? color6;
                        Color? color7;

                        double? originalTop1;
                        double? originalTop2;
                        double? originalTop3;
                        double? originalTop4;
                        double? originalTop5;
                        double? originalTop6;
                        double? originalTop7;

                        double? originalLeft1;
                        double? originalLeft2;
                        double? originalLeft3;
                        double? originalLeft4;
                        double? originalLeft5;
                        double? originalLeft6;
                        double? originalLeft7;

                        //-------------------------------------------------------------------------------//

                        double? scaledTop1;
                        double? scaledTop2;
                        double? scaledTop3;
                        double? scaledTop4;
                        double? scaledTop5;
                        double? scaledTop6;
                        double? scaledTop7;

                        double? scaledLeft1;
                        double? scaledLeft2;
                        double? scaledLeft3;
                        double? scaledLeft4;
                        double? scaledLeft5;
                        double? scaledLeft6;
                        double? scaledLeft7;

                        double? scaledFontSize1;
                        double? scaledFontSize2;
                        double? scaledFontSize3;
                        double? scaledFontSize4;
                        double? scaledFontSize5;
                        double? scaledFontSize6;
                        double? scaledFontSize7;

                        TextStyle? textStyle1;
                        TextStyle? textStyle2;
                        TextStyle? textStyle3;
                        TextStyle? textStyle4;
                        TextStyle? textStyle5;
                        TextStyle? textStyle6;
                        TextStyle? textStyle7;

                        double? height;
                        double? width;

                        double? top;
                        double? left;

                        if (itemIndex > 0) {
                          textStyleValueslist = videoReviewList[itemIndex]
                                  ['textStyle']
                              .split('=');

                          textStyleValues1 = textStyleValueslist[0].split(',');
                          textStyleValues2 = textStyleValueslist[1].split(',');
                          textStyleValues3 = textStyleValueslist[2].split(',');
                          textStyleValues4 = textStyleValueslist[3].split(',');
                          textStyleValues5 = textStyleValueslist[4].split(',');
                          textStyleValues6 = textStyleValueslist[5].split(',');
                          textStyleValues7 = textStyleValueslist[6].split(',');


                          //----------------------fetched font family value------------------------//
                          fontFamily1 = textStyleValues1[0];
                          fontFamily2 = textStyleValues2[0];
                          fontFamily3 = textStyleValues3[0];
                          fontFamily4 = textStyleValues4[0];
                          fontFamily5 = textStyleValues5[0];
                          fontFamily6 = textStyleValues6[0];
                          fontFamily7 = textStyleValues7[0];

                          //----------------------fetched font-------------------------------------//
                          originalFontSize1 = double.parse(textStyleValues1[1]);
                          originalFontSize2 = double.parse(textStyleValues2[1]);
                          originalFontSize3 = double.parse(textStyleValues3[1]);
                          originalFontSize4 = double.parse(textStyleValues4[1]);
                          originalFontSize5 = double.parse(textStyleValues5[1]);
                          originalFontSize6 = double.parse(textStyleValues6[1]);
                          originalFontSize7 = double.parse(textStyleValues7[1]);

                          //----------------------fetched color value------------------------------//
                          color1 = convertHexToColor(textStyleValues1[2]);
                          color2 = convertHexToColor(textStyleValues2[2]);
                          color3 = convertHexToColor(textStyleValues3[2]);
                          color4 = convertHexToColor(textStyleValues4[2]);
                          color5 = convertHexToColor(textStyleValues5[2]);
                          color6 = convertHexToColor(textStyleValues6[2]);
                          color7 = convertHexToColor(textStyleValues7[2]);

                          //----------------------fetched top value------------------------------//
                          //---------------------------------------------------------------------//
                          originalTop1 = double.parse(textStyleValues1[3]);
                          originalTop2 = double.parse(textStyleValues2[3]);
                          originalTop3 = double.parse(textStyleValues3[3]);
                          originalTop4 = double.parse(textStyleValues4[3]);
                          originalTop5 = double.parse(textStyleValues5[3]);
                          originalTop6 = double.parse(textStyleValues6[3]);
                          originalTop7 = double.parse(textStyleValues7[3]);

                          //----------------------fetched left value-----------------------------//
                          originalLeft1 = double.parse(textStyleValues1[4]);
                          originalLeft2 = double.parse(textStyleValues2[4]);
                          originalLeft3 = double.parse(textStyleValues3[4]);
                          originalLeft4 = double.parse(textStyleValues4[4]);
                          originalLeft5 = double.parse(textStyleValues5[4]);
                          originalLeft6 = double.parse(textStyleValues6[4]);
                          originalLeft7 = double.parse(textStyleValues7[4]);

                          //----------------------textstyle-------------------------------------//

                          textStyle1 = getTextStyle(0);
                          textStyle2 = getTextStyle(0);
                          textStyle3 = getTextStyle(0);
                          textStyle4 = getTextStyle(0);
                          textStyle5 = getTextStyle(0);
                          textStyle6 = getTextStyle(0);
                          textStyle7 = getTextStyle(0);

                          //------------------------calculation logic-------------------------------//

                          double heightScalingFactor = 430 / 1500;
                          double widthScalingFactor = 275 / 1000;

                          height = double.parse(
                                  videoReviewList[2]['carddetail'][0]) *
                              heightScalingFactor;
                          width = double.parse(
                                  videoReviewList[2]['carddetail'][1]) *
                              widthScalingFactor;

                          top = double.parse(
                                  videoReviewList[2]['carddetail'][2]) *
                              heightScalingFactor;
                          left = double.parse(
                                  videoReviewList[2]['carddetail'][3]) *
                              widthScalingFactor;

                          double heightScaling = height / 1500;
                          double widthScaling = width / 1000;

                          //-------------------------------------------------------------------------//
                          //-----------------------calculated top value------------------------------//
                          scaledTop1 = originalTop1 * heightScaling - 10;
                          scaledTop2 = originalTop2 * heightScaling - 10;
                          scaledTop3 = originalTop3 * heightScaling - 10;
                          scaledTop4 = originalTop4 * heightScaling - 10;
                          scaledTop5 = originalTop5 * heightScaling - 10;
                          scaledTop6 = originalTop6 * heightScaling - 10;
                          scaledTop7 = originalTop7 * heightScaling - 10;

                          //-----------------------calculated top value------------------------------//
                          scaledLeft1 = originalLeft1 * widthScaling;
                          scaledLeft2 = originalLeft2 * widthScaling;
                          scaledLeft3 = originalLeft3 * widthScaling;
                          scaledLeft4 = originalLeft4 * widthScaling;
                          scaledLeft5 = originalLeft5 * widthScaling;
                          scaledLeft6 = originalLeft6 * widthScaling;
                          scaledLeft7 = originalLeft7 * widthScaling;

                          //-------------------------calculated fontsize--------------------------//
                          scaledFontSize1 = originalFontSize1 * widthScaling;
                          scaledFontSize2 = originalFontSize2 * widthScaling;
                          scaledFontSize3 = originalFontSize3 * widthScaling;
                          scaledFontSize4 = originalFontSize4 * widthScaling;
                          scaledFontSize5 = originalFontSize5 * widthScaling;
                          scaledFontSize6 = originalFontSize6 * widthScaling;
                          scaledFontSize7 = originalFontSize7 * widthScaling;
                        }
                        // double heightScalingFactor = 420 / 1500;
                        // double widthScalingFactor = 265 / 1000;

                        return itemIndex == 0
                            ? Positioned(
                                top: textStyleValue.originalTop,
                                left: textStyleValue.originalLeft,
                                height: 420,
                                width: 275,
                                child: Text(
                                  contentList[index],
                                  textAlign: textStyleValue.originalLeft == 0
                                      ? TextAlign.center
                                      : textStyleValue.originalLeft < 0
                                          ? TextAlign.right
                                          : TextAlign.left,
                                  style: GoogleFonts.getFont(
                                    // customizeFonts[textStyleValue.fontFamily]![0],
                                    fontFamily,
                                    textStyle: TextStyle(
                                      // fontFamily: textStyleValue.fontFamily,
                                      fontSize: textStyleValue.fontSize,
                                      color: textStyleValue.color,
                                      fontStyle:
                                          textStyleValue.textStyle.fontStyle,
                                      decoration:
                                          textStyleValue.textStyle.decoration,
                                      fontWeight:
                                          textStyleValue.textStyle.fontWeight,
                                    ),
                                  ),
                                ),
                              )
                            : Positioned(
                               
                                top: top!,
                                left: left,
                                height: height! + 10,
                                width: width,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: scaledTop1,
                                      left: scaledLeft1,
                                      width: width,
                                      height: height,
                                      child: Text(
                                        videoReviewList[itemIndex]['content']
                                            [0],
                                        textAlign:
                                           
                                            TextAlign.center,
                                       style: GoogleFonts.getFont(
                                          customizeFonts[fontFamily1]![0],
                                          textStyle: TextStyle(
                                            fontSize: scaledFontSize1,
                                            color: color1,
                                            fontStyle: textStyle1?.fontStyle,
                                            decoration: textStyle1?.decoration,
                                            fontWeight: textStyle1?.fontWeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: scaledTop2,
                                      left: scaledLeft2,
                                      width: width,
                                      height: height,
                                      child: Text(
                                        videoReviewList[itemIndex]['content']
                                            [1],
                                        textAlign:
                                            // scaledLeft1 == 0
                                            //     ?
                                            TextAlign.center,
                                        // : scaledLeft1 < 0
                                        //     ? TextAlign.right
                                        //     : TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          customizeFonts[fontFamily2]![0],
                                          // 'Roboto',
                                          textStyle: TextStyle(
                                            // fontFamily: fontFamily1,
                                            fontSize: scaledFontSize2,
                                            color: color2,
                                            fontStyle: textStyle2?.fontStyle,
                                            decoration: textStyle2?.decoration,
                                            fontWeight: textStyle2?.fontWeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: scaledTop3,
                                      left: scaledLeft3,
                                      width: width,
                                      height: height,
                                      child: Text(
                                        videoReviewList[itemIndex]['content']
                                            [2],
                                        textAlign:
                                            // scaledLeft1 == 0
                                            //     ?
                                            TextAlign.center,
                                        // : scaledLeft1 < 0
                                        //     ? TextAlign.right
                                        //     : TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          customizeFonts[fontFamily3]![0],
                                          // 'Roboto',
                                          textStyle: TextStyle(
                                            // fontFamily: fontFamily1,
                                            fontSize: scaledFontSize3,
                                            color: color3,

                                            fontStyle: textStyle3?.fontStyle,
                                            decoration: textStyle3?.decoration,
                                            fontWeight: textStyle3?.fontWeight,
                                            height: 1.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: scaledTop4,
                                      left: scaledLeft4,
                                      width: width,
                                      height: height,
                                      child: Text(
                                        videoReviewList[itemIndex]['content']
                                            [3],
                                        textAlign:
                                            // scaledLeft1 == 0
                                            //     ?
                                            TextAlign.center,
                                        // : scaledLeft1 < 0
                                        //     ? TextAlign.right
                                        //     : TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          customizeFonts[fontFamily4]![0],
                                          // 'Roboto',
                                          textStyle: TextStyle(
                                            // fontFamily: fontFamily1,
                                            fontSize: scaledFontSize4,
                                            color: color4,
                                            fontStyle: textStyle4?.fontStyle,
                                            decoration: textStyle4?.decoration,
                                            fontWeight: textStyle4?.fontWeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: scaledTop5,
                                      left: scaledLeft5,
                                      width: width,
                                      height: height,
                                      child: Text(
                                        videoReviewList[itemIndex]['content']
                                            [4],
                                        textAlign:
                                            // scaledLeft1 == 0
                                            //     ?
                                            TextAlign.center,
                                        // : scaledLeft1 < 0
                                        //     ? TextAlign.right
                                        //     : TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          customizeFonts[fontFamily5]![0],
                                          // 'Roboto',
                                          textStyle: TextStyle(
                                            // fontFamily: fontFamily1,
                                            fontSize: scaledFontSize5,
                                            color: color5,
                                            fontStyle: textStyle5?.fontStyle,
                                            decoration: textStyle5?.decoration,
                                            fontWeight: textStyle5?.fontWeight,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: scaledTop6,
                                      left: scaledLeft6,
                                      width: width,
                                      height: height,
                                      child: Text(
                                        videoReviewList[itemIndex]['content']
                                            [5],
                                        textAlign:
                                            // scaledLeft1 == 0
                                            //     ?
                                            TextAlign.center,
                                        // : scaledLeft1 < 0
                                        //     ? TextAlign.right
                                        //     : TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          customizeFonts[fontFamily6]![0],
                                          // 'Roboto',
                                          textStyle: TextStyle(
                                            // fontFamily: fontFamily1,
                                            fontSize: scaledFontSize6,
                                            color: color6,
                                            fontStyle: textStyle6?.fontStyle,
                                            decoration: textStyle6?.decoration,
                                            fontWeight: textStyle6?.fontWeight,
                                            height: 1.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: scaledTop7,
                                      left: scaledLeft7,
                                      width: width,
                                      height: height,
                                      child: Text(
                                        videoReviewList[itemIndex]['content']
                                            [6],
                                        textAlign:
                                            // scaledLeft1 == 0
                                            //     ?
                                            TextAlign.center,
                                        // : scaledLeft1 < 0
                                        //     ? TextAlign.right
                                        //     : TextAlign.left,
                                        style: GoogleFonts.getFont(
                                          customizeFonts[fontFamily7]![0],
                                          // 'Roboto',
                                          textStyle: TextStyle(
                                            // fontFamily: fontFamily1,
                                            fontSize: scaledFontSize7,
                                            color: color7,
                                            fontStyle: textStyle7?.fontStyle,
                                            decoration: textStyle7?.decoration,
                                            fontWeight: textStyle7?.fontWeight,
                                            height: 1.3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    ),
                  ],
                ));
          } else {
            // return Shimmer.fromColors(
            //   baseColor: Colors.grey[300]!,
            //   highlightColor: Colors.grey[100]!,
            //   child: Container(
            //     color: Colors.white,
            //   ),
            // );
            return Container(
              margin: const EdgeInsets.all(20),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget similarCards() {
    return GridView.builder(
      addAutomaticKeepAlives: true,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 305,
      ),
      itemCount: limittedToTwenty.length,
      itemBuilder: (BuildContext context, int index) {
        //-----------------------date-----------------------------------------------//
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd\'th\' MMM, yyyy').format(now);

        //-------------------------data seperation from list--------------------------//
        //----------------------------------------------------------------------------//
        List<dynamic> textStyleValueslist =
            limittedToTwenty[index]['textstyle'].split('=');

        List<dynamic> textStyleValues1 = [];
        List<dynamic> textStyleValues2 = [];
        List<dynamic> textStyleValues3 = [];
        List<dynamic> textStyleValues4 = [];
        List<dynamic> textStyleValues5 = [];

        textStyleValues1 = textStyleValueslist[0].split(',');
        textStyleValues2 = textStyleValueslist[1].split(',');
        textStyleValues3 = textStyleValueslist[2].split(',');
        textStyleValues4 = textStyleValueslist[3].split(',');
        textStyleValues5 = textStyleValueslist[4].split(',');

        //----------------------fetched top value------------------------------//
        //---------------------------------------------------------------------//
        double originalTop1 = double.parse(textStyleValues1[3]);
        double originalTop2 = double.parse(textStyleValues2[3]);
        double originalTop3 = double.parse(textStyleValues3[3]);
        double originalTop4 = double.parse(textStyleValues4[3]);
        double originalTop5 = double.parse(textStyleValues5[3]);

        //----------------------fetched left value-----------------------------//
        double originalLeft1 = double.parse(textStyleValues1[4]);
        double originalLeft2 = double.parse(textStyleValues2[4]);
        double originalLeft3 = double.parse(textStyleValues3[4]);
        double originalLeft4 = double.parse(textStyleValues4[4]);
        double originalLeft5 = double.parse(textStyleValues5[4]);

        //----------------------fetched font family value------------------------//
        String fontFamily1 = textStyleValues1[0];
        String fontFamily2 = textStyleValues2[0];
        String fontFamily3 = textStyleValues3[0];
        String fontFamily4 = textStyleValues4[0];
        String fontFamily5 = textStyleValues5[0];

        //----------------------fetched color value------------------------------//

        Color color1 = convertHexToColor(textStyleValues1[2]);
        Color color2 = convertHexToColor(textStyleValues2[2]);
        Color color3 = convertHexToColor(textStyleValues3[2]);
        Color color4 = convertHexToColor(textStyleValues4[2]);
        Color color5 = convertHexToColor(textStyleValues5[2]);

        //----------------------fetched font-------------------------------------//
        double originalFontSize1 = double.parse(textStyleValues1[1]);
        double originalFontSize2 = double.parse(textStyleValues2[1]);
        double originalFontSize3 = double.parse(textStyleValues3[1]);
        double originalFontSize4 = double.parse(textStyleValues4[1]);
        double originalFontSize5 = double.parse(textStyleValues5[1]);

        //----------------------textstyle-------------------------------------//

        TextStyle textStyle1 = getTextStyle(int.parse(textStyleValues1[6]));
        TextStyle textStyle2 = getTextStyle(int.parse(textStyleValues2[6]));
        TextStyle textStyle3 = getTextStyle(int.parse(textStyleValues3[6]));
        TextStyle textStyle4 = getTextStyle(int.parse(textStyleValues4[6]));
        TextStyle textStyle5 = getTextStyle(int.parse(textStyleValues5[6]));

        //------------------------calculation logic-------------------------------//
        double heightScalingFactor = 262 / 1500;
        double widthScalingFactor = 165 / 1000;

        //-------------------------------------------------------------------------//
        //-----------------------calculated top value------------------------------//
        double scaledTop1 = originalTop1 * heightScalingFactor;
        double scaledTop2 = originalTop2 * heightScalingFactor;
        double scaledTop3 = originalTop3 * heightScalingFactor;

        double scaledTop4 = originalTop4 * heightScalingFactor;
        double scaledTop5 = originalTop5 * heightScalingFactor;

        //-----------------------calculated top value------------------------------//
        double scaledLeft1 = originalLeft1 * widthScalingFactor;
        double scaledLeft2 = originalLeft2 * widthScalingFactor;
        double scaledLeft3 = originalLeft3 * widthScalingFactor;
        double scaledLeft4 = originalLeft4 * widthScalingFactor;
        double scaledLeft5 = originalLeft5 * widthScalingFactor;

        //-------------------------calculated fontsize--------------------------//
        double scaledFontSize1 = originalFontSize1 * heightScalingFactor;
        double scaledFontSize2 = originalFontSize2 * heightScalingFactor;
        double scaledFontSize3 = originalFontSize3 * heightScalingFactor;
        double scaledFontSize4 = originalFontSize4 * heightScalingFactor;
        double scaledFontSize5 = originalFontSize5 * heightScalingFactor;

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                  color: Color.fromRGBO(194, 197, 196, 1), width: 0.7),
              right: BorderSide(
                  color: Color.fromRGBO(194, 197, 196, 1), width: 0.7),
              bottom: BorderSide(
                  color: Color.fromRGBO(194, 197, 196, 1), width: 0.7),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<Map<String, String>>(
                      builder: (BuildContext context) => ProductScreen(
                        cardTemplate: limittedToTwenty[index],
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: 270,
                  width: 165,
                  child: FutureBuilder(
                    future: precacheImage(
                      CachedNetworkImageProvider(
                        '${limittedToTwenty[index]['imageUrl']}',
                      ),
                      context,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return Stack(
                          fit: StackFit.passthrough,
                          children: [
                            AspectRatio(
                              aspectRatio: 2 / 3,
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${limittedToTwenty[index]['imageUrl']}',
                                fit: BoxFit.contain,
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                  Icons.error_outline,
                                  color: Color.fromRGBO(0, 118, 99, 1),
                                ),
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 7,
                              right: 3,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (favIndices.contains(index)) {
                                      favIndices.remove(index);
                                    } else {
                                      favIndices.add(index);
                                    }
                                  });
                                },
                                child: Container(
                                  height: 27,
                                  width: 27,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      favIndices.contains(index)
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color:
                                          const Color.fromRGBO(0, 118, 99, 1),
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: scaledTop1,
                              left: scaledLeft1,
                              width: 165,
                              child: Text(
                                'Wedding Invitation',
                                textAlign: scaledLeft1 == 0
                                    ? TextAlign.center
                                    : scaledLeft1 < 0
                                        ? TextAlign.right
                                        : TextAlign.left,
                                style: GoogleFonts.getFont(
                                  customizeFonts[fontFamily1]![0],
                                  textStyle: TextStyle(
                                    // fontFamily: fontFamily1,
                                    fontSize: scaledFontSize1,
                                    color: color1,
                                    fontStyle: textStyle1.fontStyle,
                                    decoration: textStyle1.decoration,
                                    fontWeight: textStyle1.fontWeight,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: scaledTop2,
                              left: scaledLeft2,
                              width: 165,
                              child: Text(
                                _groomName,
                                textAlign: scaledLeft2 == 0
                                    ? TextAlign.center
                                    : scaledLeft2 < 0
                                        ? TextAlign.right
                                        : TextAlign.left,
                                style: GoogleFonts.getFont(
                                  customizeFonts[fontFamily2]![0],
                                  textStyle: TextStyle(
                                    // fontFamily: fontFamily2,
                                    fontSize: scaledFontSize2,
                                    color: color2,
                                    fontStyle: textStyle2.fontStyle,
                                    decoration: textStyle2.decoration,
                                    fontWeight: textStyle2.fontWeight,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: scaledTop3,
                              left: scaledLeft3,
                              width: 165,
                              child: Text(
                                'Weds',
                                textAlign: scaledLeft3 == 0
                                    ? TextAlign.center
                                    : scaledLeft3 < 0
                                        ? TextAlign.right
                                        : TextAlign.left,
                                style: GoogleFonts.getFont(
                                  customizeFonts[fontFamily3]![0],
                                  textStyle: TextStyle(
                                    // fontFamily: fontFamily3,
                                    fontSize: scaledFontSize3,
                                    color: color3,
                                    fontStyle: textStyle3.fontStyle,
                                    decoration: textStyle3.decoration,
                                    fontWeight: textStyle3.fontWeight,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: scaledTop4,
                              left: scaledLeft4,
                              width: 165,
                              child: Text(
                                _brideName,
                                textAlign: scaledLeft4 == 0
                                    ? TextAlign.center
                                    : scaledLeft4 < 0
                                        ? TextAlign.right
                                        : TextAlign.left,
                                style: GoogleFonts.getFont(
                                  customizeFonts[fontFamily4]![0],
                                  textStyle: TextStyle(
                                    // fontFamily: fontFamily4,
                                    fontSize: scaledFontSize4,
                                    color: color4,
                                    fontStyle: textStyle4.fontStyle,
                                    decoration: textStyle4.decoration,
                                    fontWeight: textStyle4.fontWeight,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: scaledTop5,
                              left: scaledLeft5,
                              width: 165,
                              child: Text(
                                formattedDate,
                                textAlign: scaledLeft5 == 0
                                    ? TextAlign.center
                                    : scaledLeft5 < 0
                                        ? TextAlign.right
                                        : TextAlign.left,
                                style: GoogleFonts.getFont(
                                  customizeFonts[fontFamily5]![0],
                                  textStyle: TextStyle(
                                    // fontFamily: fontFamily5,
                                    fontSize: scaledFontSize5,
                                    color: color5,
                                    fontStyle: textStyle5.fontStyle,
                                    decoration: textStyle5.decoration,
                                    fontWeight: textStyle5.fontWeight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),

           ],
          ),
        );
      },
    );
  }
}
