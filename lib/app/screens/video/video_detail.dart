import 'package:Celebrare/app/bottom_nav.dart';
import 'package:Celebrare/app/utils/youtube_player.dart';
import 'package:Celebrare/app/widgets/homepage_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

// ignore: must_be_immutable
class VideoDetails extends StatefulWidget {
  String videoCardId;
  String videolink;
  String photo1;
  String photo2;
  String photo3;
  String offPrice;
  String discountPrice;
  String price;
  String title;
  String videoId;

  VideoDetails({
    super.key,
    required this.videoCardId,
    required this.videolink,
    required this.photo1,
    required this.photo2,
    required this.photo3,
    required this.offPrice,
    required this.discountPrice,
    required this.price,
    required this.title,
    required this.videoId,
  });

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  final PageController _pageController = PageController(initialPage: 0);
  final PageController _pageHearFromUsersController =
      PageController(initialPage: 0);
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;
  int _currentHearFromUsersPage = 0;
  int selectedIdx = 1;
  String price = '';
  String thumbnailUrl = '';
  bool isPlayed = false;
  bool isSecondVideoPlayed = false;
  bool showSizedBox = false;
  bool isExpanded = false;
  // int currentlyExpandedIndex = -1;
  late List<bool> isExpandedList;
  final CarouselController cardcarouselController = CarouselController();
  int currentIndex = 0;
  bool istextwhatsappEnabled = true;
  bool isbuttonwhatsappEnabled = true;
  bool ismainbuttonEnabled = true;
  bool isShare = true;
  bool isCreateOnline = true;
  bool isPurchaseNow = true;

  List cardimageList = [
    {
      "id": 1,
      "userimg": 'assets/reviews/play_user1.webp',
      "name": "Manish Mehra",
      "message":
          "An platform offering tools to design wedding Invitations and personalised greeting cards."
    },
    {
      "id": 2,
      "userimg": 'assets/reviews/play_user2.webp',
      "name": "Tanisha Singh",
      "message":
          "An platform offering tools to design wedding Invitations and personalised greeting cards."
    },
    {
      "id": 3,
      "userimg": 'assets/reviews/play_user3.webp',
      "name": "Raj Gupta",
      "message":
          "An platform offering tools to design wedding Invitations and personalised greeting cards."
    },
  ];

  List<Map<String, String>> faqData = [
    {
      "question": "Customize song possible ?",
      "answer":
          "It's a super easy process to create a wedding invitation with Celebrare:\n1. Select the template\n2. Click on \"Try this card\"\n3. Fill the form with your details\n4. Click on the \"Share\" button\n5. Make the payment and download the card",
    },
    {
      "question": "Faces in general videos or eyes. can be added ?",
      "answer":
          "Yes, it's possible. After filling the form, you can edit each page. Simply select the page and click on 'Edit this page' to add a new text with your event name and details."
    },
    {
      "question":
          "I am not able to write full names due to the word limit. Is there any solution ?",
      "answer":
          "Yes, you can fill the first name in the form, and after that, you will get an option to edit the page where you can add the full name."
    },
    {
      "question":
          "How much time will it take to download the card after payment ?",
      "answer": "You will get your card instantly once you make the payment."
    },
    {
      "question": "Can I add my own photos to the invitations ?",
      "answer":
          "Yes, you can add your photos to the card. After filling the details, you will get an option to edit the card where you can add your photos using the 'Add Image' button.",
    },
  ];

  List userReview = [
    {
      "content":
          "Thank you for understanding I am actually very busy these days. Thank you for these special videos.",
      "name": "Varsha Sudarshan",
      "image": "assets/reviews/play_user1.webp",
    },
    {
      "content": "Thank you for creating my invitation video so wonderfully.",
      "name": "Nishant Sharma",
      "image": "assets/reviews/play_user3.webp",
    },
    {
      "content": "This is perfect, thanks for all the efforts.",
      "name": "Mohini Tyagi",
      "image": "assets/reviews/play_user2.webp",
    },
    {
      "content":
          "Your invitations video and pdf cards are so amazing. Thank you so much.",
      "name": "Ritik Verma",
      "image": "assets/reviews/play_user1.webp",
    },
  ];

  void _onButtonTap(String urlValue, bool button) async {
    String url = urlValue;
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
    price = widget.price;
    thumbnailUrl = 'https://img.youtube.com/vi/${widget.videoId}/0.jpg';
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          MediaQuery.of(context).size.height * 0.7) {
        setState(() {
          showSizedBox = true;
        });
      } else {
        setState(() {
          showSizedBox = false;
        });
      }
    });
    isExpandedList = List<bool>.generate(faqData.length, (index) => false);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      appBar: buildAppBar(),
      body: Container(
        color: Colors.white,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            buildDiscountBanner(),

            //--------------------------------------path----------------------------------------------//
            buildPath(),
            //--------------------------------------video cards---------------------------------------//
            buildVideoCard(),
            //--------------------------------------title and price-----------------------------------//
            Container(
              width: size.width,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 15, bottom: 15),
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //----------------------------title--------------------//
                  SizedBox(
                    width: size.width,
                    child: Text(
                      widget.title,
                      maxLines: 2,
                      style: GoogleFonts.getFont(
                        'Roboto',
                        textStyle: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  //---------------------------price and details--------------------------//
                  buildPriceAndOfferDetails(),
                  const SizedBox(height: 20),
                  //----------------------------banner and share button--------------------------//
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // const Text(
                      //   'Your voucher of Rs 100 is applied',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 14,
                      //     fontFamily: 'Roboto',
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50, top: 3, bottom: 3),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/discount.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Best Price offered',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.getFont(
                              'Roboto',
                              textStyle: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: !isShare
                            ? null
                            : () async {
                               
                                final RenderBox box =
                                    context.findRenderObject() as RenderBox;

                                setState(() {
                                  isShare = false;
                                });

                                try {
                                  // Share.share(
                                  //   'https://celebrare.in/video-invitation/product-page?videoID=${widget.videoCardId}',
                                  //   sharePositionOrigin:
                                  //       box.localToGlobal(Offset.zero) &
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
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 204, 222, 218),
                          ),
                          child: const Icon(
                            Icons.share,
                            color: Color(0xFF007663),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  //---------------------------------------------------------------------------//
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  //-----------------------------------------------------------------------------//
                  const SizedBox(height: 10),
                  //-----------------------------select the no. of fn/event---------------------------------//
                  Text(
                    'Select the number of function/events',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  //---------------------------function number selection-----------------------------//
                  buildFunctionNoSelection(),
                  const SizedBox(height: 10),
                  //--------------------------------------------------------------------------------//
                  const Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  //---------------------------------------------------------------------------------//
                  const SizedBox(height: 30),
                ],
              ),
            ),
            //--------------------------------------build Video Invite Player-------------------------//
            buildVideoInvitePlayer(),
            //--------------------------------------order process-------------------------------------//
            buildOrderProcess(),
            //--------------------------------------order on whatsapp button--------------------------//
            buildOrderOnWhatsappButton(),
            //-------------------------------------Hear From Our Users--------------------------------//
            buildHearFromOurUsers(),
            //-------------------------------------know More-----------------------------------------//
            buildknowMore(),
            //-------------------------------------F A Q---------------------------------------------//
            buildFAQ(),
            //-------------------------------------Create It Online Beta-----------------------------//
            buildCreateItOnlineBeta(),
            //-------------------------------------Similar Photos-------------------------------------//
            buildSimilarPhotos(),
            //-------------------------------------Message On Whatsapp--------------------------------//
            buildMessageOnWhatsapp(),
          ],
        ),
      ),
      bottomSheet: showSizedBox ? const SizedBox() : _showBottomSheet(),
    );
  }

  //----------------------------------appbar---------------------------//
  PreferredSizeWidget? buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      // title: const Text(
      //   'All video invites',
      //   style: TextStyle(
      //     fontSize: 16,
      //     fontWeight: FontWeight.w600,
      //     fontFamily: 'Montserrat',
      //     color: Color.fromRGBO(38, 38, 38, 1),
      //   ),
      // ),
      // centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute<void>(
          //     builder: (BuildContext context) => BottomNav(
          //       initialIndex: 1,
          //     ),
          //   ),
          // );
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
    );
  }

  //==========================================================================================//
  //----------------------------------top banner-------------------------//
  Widget buildDiscountBanner() {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 71,
          width: size.width,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star_border,
                        color: Color.fromRGBO(55, 113, 200, 1),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Holiday Sale',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(23, 22, 22, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Get ',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(23, 22, 22, 1),
                          ),
                        ),
                      ),
                      Text(
                        '10% OFF',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(23, 22, 22, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                        child: Text(
                          ' on your order',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            textStyle: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(23, 22, 22, 1),
                            ),
                          ),
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
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  //=========================================================================================//
  //----------------------------------path----------------------------------//
  Widget buildPath() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          BottomNav(initialIndex: 0),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  'Home > ',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(23, 22, 22, 1),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          BottomNav(initialIndex: 2),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  'Video Invitations > ',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(23, 22, 22, 1),
                    ),
                  ),
                ),
              ),
              Text(
                'Video ${widget.videoCardId}',
                style: GoogleFonts.getFont(
                  'Roboto',
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF007663),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  //===========================================================================================//
  //----------------------------------video card sub--------------------------------------//
  Widget buildVideoCard() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: Column(
        children: [
          //------------------------- big pages ----------------------------//
          buildBigPages(),

          const SizedBox(height: 10),

          //------------------------------dots-----------------------------//
          buildDots(),

          const SizedBox(height: 10),
          //----------------------------------------down images------------------------------------//
          buildSmallPages(),
        ],
      ),
    );
  }

  //---------------------------------video and photos with pagination-----------------------//
  Widget buildBigPages() {
    Size size = MediaQuery.of(context).size;
    List photoList = [widget.photo1, widget.photo2, widget.photo3];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: _currentPage == 0
              ? null
              : () {
                  setState(() {
                    _currentPage = _currentPage - 1;
                  });
                  _pageController.jumpToPage(_currentPage);
                },
          child: Icon(
            Icons.arrow_back_ios_new,
            color: _currentPage == 0
                ? const Color.fromARGB(255, 196, 230, 224)
                : const Color(0xFF007663),
          ),
        ),
        SizedBox(
          width: size.width * 0.7,
          height: size.height * 0.53,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 4,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
                isPlayed = false;
              });
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                // Page 1: Video
                return isPlayed == true
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        width: size.width * 0.62,
                        height: size.height * 0.53,
                        child: YouTubePlayerDemo(
                         
                          aspectRatio: 9 / 16,
                          vedioUrl: widget.videolink,
                        ),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        fit: StackFit.passthrough,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            width: size.width * 0.62,
                            height: size.height * 0.53,
                            child: CachedNetworkImage(
                              imageUrl: thumbnailUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error_outline,
                                color: Color.fromRGBO(0, 118, 99, 1),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isPlayed = true;
                              });
                            },
                            child: Center(
                              child: Container(
                                height: 45,
                                width: 75,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF007663),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              } else {
                return SizedBox(
                  height: size.height * 0.20,
                  width: size.width,
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: CachedNetworkImage(
                      imageUrl: photoList[index - 1],
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error_outline,
                        color: Color.fromRGBO(0, 118, 99, 1),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
        GestureDetector(
          onTap: _currentPage == 3
              ? null
              : () {
                  setState(() {
                    _currentPage = _currentPage + 1;
                  });
                  _pageController.jumpToPage(_currentPage);
                },
          child: Icon(
            Icons.arrow_forward_ios,
            color: _currentPage == 3
                ? const Color.fromARGB(255, 196, 230, 224)
                : const Color(0xFF007663),
          ),
        ),
      ],
    );
  }

  //----------------------------------dots-----------------------------------//
  Widget buildDots() {
    return SizedBox(
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List<Widget>.generate(
          4,
          (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Icon(
                index == 0 ? Icons.play_arrow_sharp : Icons.circle,
                color: _currentPage != index
                    ? Colors.grey
                    : const Color(0xFF007663),
                size: _currentPage == index
                    ? index == 0
                        ? 20
                        : 15
                    : index == 0
                        ? 12
                        : 8,
              ),
            );
          },
        ),
      ),
    );
  }

  //---------------------------------small pages-----------------------------//
  Widget buildSmallPages() {
    Size size = MediaQuery.of(context).size;
    List photoList = [widget.photo1, widget.photo2, widget.photo3];
    return SizedBox(
      height: size.height * 0.20,
      width: size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photoList.length + 1,
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          bool isSelected = _currentPage == index;
          double opacity = isSelected ? 1.0 : 0.5;

          if (index == 0) {
            // Video item
            return GestureDetector(
              onTap: () async {
                setState(() {
                  _currentPage = index;
                  isPlayed = false;
                });
                _pageController.jumpToPage(index);
              },
              child: Opacity(
                opacity: opacity,
                child: Stack(
                  alignment: Alignment.center,
                  fit: StackFit.passthrough,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      width: size.width * 0.25,
                      height: size.height * 0.18,
                      child: AspectRatio(
                        aspectRatio: 9 / 16,
                        child: CachedNetworkImage(
                          imageUrl: thumbnailUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 25,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF007663),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Image items
            return GestureDetector(
              onTap: () {
                setState(() {
                  _currentPage = index;
                });
                _pageController.jumpToPage(index);
              },
              child: Opacity(
                opacity: opacity,
                child: SizedBox(
                  width: size.width * 0.25,
                  height: size.height * 0.18,
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: CachedNetworkImage(
                      imageUrl: photoList[index - 1],
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error_outline,
                        color: Color.fromRGBO(0, 118, 99, 1),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  //=========================================================================================//
  //--------------------------------price and offers-----------------------------//
  Widget buildPriceAndOfferDetails() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade200,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Offers',
            style: GoogleFonts.getFont(
              'Roboto',
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Save 50%',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF007663),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      // ' ${widget.discountPrice}',
                      '₹${1799 + (selectedIdx * 200)}',
                      style: GoogleFonts.getFont(
                        'Roboto',
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(147, 146, 146, 1),
                        ),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: 30,
                      color: const Color.fromRGBO(147, 146, 146, 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              // Text(
              //   '$price',
              Text(
                '₹${int.parse(widget.offPrice) + (selectedIdx * 100)}',
                style: GoogleFonts.getFont(
                  'Roboto',
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF161515),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            selectedIdx == 4
                ? '(${selectedIdx + 1}+ functions in the video invitation)'
                : '(${selectedIdx + 1} functions in the video invitation)',
            style: GoogleFonts.getFont(
              'Roboto',
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //---------------------------------functions number selection---------------------------//
  Widget buildFunctionNoSelection() {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 140,
      width: size.width,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(0),
        itemCount: 5,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 8);
        },
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIdx = index;
                price = '₹${int.parse(widget.price) + (index * 200)}';
              });
            },
            child: Row(
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: selectedIdx == index
                        ? const Color(0xFF007663)
                        : Colors.white,
                    border: Border.all(
                        color: selectedIdx == index
                            ? Colors.transparent
                            : Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: selectedIdx == index
                      ? const Center(
                          child: Icon(
                            Icons.check,
                            size: 12,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 12),
                Text(
                  index == 4
                      ? '${index + 1}+ function in the video invitation    (₹${int.parse(widget.discountPrice) + (index * 200)})'
                      : '${index + 1} function in the video invitation    (₹${int.parse(widget.discountPrice) + (index * 200)})',
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: selectedIdx == index ? Colors.black : Colors.grey,
                      fontSize: selectedIdx == index ? 14 : 13,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //==========================================================================================//
  //---------------------------------build Video Invite Player------------------------------//
  Widget buildVideoInvitePlayer() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's make your invite together",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 20),
          isSecondVideoPlayed == true
              ? const YouTubePlayerDemo(
                  aspectRatio: 16 / 9,
                  vedioUrl: 'https://www.youtube.com/watch?v=2elXPVXOkqQ',
                )
              : Stack(
                  alignment: Alignment.center,
                  fit: StackFit.passthrough,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://img.youtube.com/vi/2elXPVXOkqQ/0.jpg',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          color: Color.fromRGBO(0, 118, 99, 1),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSecondVideoPlayed = true;
                        });
                      },
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            color: const Color(0xFF007663),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  //---------------------------------build Order Process------------------------------//
  Widget buildOrderProcess() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Once your order is finalized the Process is very easy",
            style: GoogleFonts.getFont(
              'Roboto',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "01.     ",
                style: GoogleFonts.getFont(
                  'Roboto',
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.82,
                child: Text(
                  "Send the content via WhatsApp.",
                  maxLines: 2,
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "02.     ",
                style: GoogleFonts.getFont(
                  'Roboto',
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.82,
                child: Text(
                  "You'll recieve a design draft as a static image for your content approval.",
                  maxLines: 2,
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "03.     ",
                style: GoogleFonts.getFont(
                  'Roboto',
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.82,
                child: Text(
                  "After that final video will shared to you for approvals.",
                  maxLines: 2,
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //---------------------------------build Order On Whatsapp Button------------------------------//
  Widget buildOrderOnWhatsappButton() {
  

    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(left: 45, right: 15, top: 45, bottom: 30),
      child: GestureDetector(
       onTap: !istextwhatsappEnabled
            ? null
            : () async {
             
                _onButtonTap(
                  "https://api.whatsapp.com/send/?phone=&text=Hello+I+'+d+like+to+place+an+order+for+the+video+with+video+ID+1100+and+I+have+a+few+questions+to+ask.&type=phone_number&app_absent=0",
                  istextwhatsappEnabled,
                );

                // Add a 3-second delay

                setState(() {
                  istextwhatsappEnabled = false;
                });
                await Future.delayed(const Duration(seconds: 3));
                setState(() {
                  istextwhatsappEnabled = true;
                });
              },
        child: Text(
          "Order on whats app ->",
          style: GoogleFonts.getFont(
            'Roboto',
            textStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Color(0xFF007663),
              fontSize: 17,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.solid,
              decorationColor: Color(0xFF007663),
            ),
          ),
        ),
      ),
    );
  }

  //---------------------------------build Hear From Our Users------------------------------//
  Widget buildHearFromOurUsers() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Hear from our users",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "See what our users say",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: _currentHearFromUsersPage == 0
                    ? null
                    : () {
                        setState(() {
                          _currentHearFromUsersPage =
                              _currentHearFromUsersPage - 1;
                        });
                        _pageHearFromUsersController.animateToPage(
                          _currentHearFromUsersPage,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear,
                        );
                      },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _currentHearFromUsersPage == 0
                          ? const Color.fromARGB(255, 196, 230, 224)
                          : const Color(0xFF007663),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: _currentHearFromUsersPage == 0
                          ? const Color.fromARGB(255, 196, 230, 224)
                          : const Color(0xFF007663),
                      size: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 270,
                width: size.width * 0.75,
                child: PageView.builder(
                    controller: _pageHearFromUsersController,
                    itemCount: userReview.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentHearFromUsersPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        height: 270,
                        width: size.width * 0.75,
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          // color: isActive ? const Color(0xff007663) : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: size.width * 0.3,
                                  child: Text(
                                    userReview[index]['content'],
                                    maxLines: 5,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.getFont(
                                      'Roboto',
                                      textStyle: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xdd444343),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                    userReview[index]['image'],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  userReview[index]['name'],
                                  style: GoogleFonts.getFont(
                                    'Roboto',
                                    textStyle: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xdd444343),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.star_outline_rounded,
                                      color: Color(0xffFAD515),
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.star_outline_rounded,
                                      color: Color(0xffFAD515),
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.star_outline_rounded,
                                      color: Color(0xffFAD515),
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.star_outline_rounded,
                                      color: Color(0xffFAD515),
                                      size: 14,
                                    ),
                                    Icon(
                                      Icons.star_outline_rounded,
                                      color: Color(0xffFAD515),
                                      size: 14,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Image.asset(
                              "assets/screenshot.png",
                              fit: BoxFit.cover,
                              width: size.width * 0.35,
                            )
                          ],
                        ),
                      );
                    }),
              ),
              GestureDetector(
                onTap: _currentHearFromUsersPage == userReview.length - 1
                    ? null
                    : () {
                        setState(() {
                          _currentHearFromUsersPage =
                              _currentHearFromUsersPage + 1;
                        });
                        _pageHearFromUsersController.animateToPage(
                          _currentHearFromUsersPage,
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear,
                        );
                      },
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _currentHearFromUsersPage == userReview.length - 1
                          ? const Color.fromARGB(255, 196, 230, 224)
                          : const Color(0xFF007663),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward,
                      color: _currentHearFromUsersPage == userReview.length - 1
                          ? const Color.fromARGB(255, 196, 230, 224)
                          : const Color(0xFF007663),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //---------------------------------build know More------------------------------------------//
  Widget buildknowMore() {
    return SizedBox(
      // padding: EdgeInsets.all(18),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /////////////////////////////////////
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Want to know more?",
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Here from our customers",
                    style: GoogleFonts.getFont(
                      'Roboto',
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xff4D4D4D),
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          //////////////////////////////////////
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //------------------------------google play icon-----------------------------//
                SizedBox(
                  height: 30,
                  child: Image.asset(
                    "assets/google_play.png",
                  ),
                ),
                const SizedBox(height: 12),
                //-------------------------------rating stars and review------------------------//
                Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: Row(
                    children: [
                      Text(
                        "4.5",
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff605F5F),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xffFAD515),
                            size: 15,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xffFAD515),
                            size: 15,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xffFAD515),
                            size: 15,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xffFAD515),
                            size: 15,
                          ),
                          Icon(
                            Icons.star_half_rounded,
                            color: Color(0xffFAD515),
                            size: 15,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "3K+ Reviews",
                        style: GoogleFonts.getFont(
                          'Roboto',
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xff605F5F),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          //////////////////////////////////////
          Stack(
            children: [
              CarouselSlider(
                items: cardimageList
                    .map(
                      (item) => cardTestinomial(item, context),
                    )
                    .toList(),
                carouselController: cardcarouselController,
                options: CarouselOptions(
                  height: 350,
                  scrollPhysics: const BouncingScrollPhysics(),
                  autoPlay: false,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              Positioned(
                top: 90,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          // Move to the previous slide
                          cardcarouselController.previousPage();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          // Move to the next slide
                          cardcarouselController.nextPage();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 180,
                bottom: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: cardimageList.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () =>
                            cardcarouselController.animateToPage(entry.key),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
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
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  //---------------------------------build F A Q---------------------------------------------//
  Widget buildFAQ() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(left: 15, right: 15, top: 40, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Frequently Asked Questions",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 21,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            width: size.width,
            padding: const EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: faqData
                  .asMap()
                  .entries
                  .map(
                    (entry) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ExpansionTile(
                            expandedAlignment: Alignment.centerLeft,
                            shape: Border.all(color: Colors.transparent),
                            collapsedIconColor: Colors.black,
                            iconColor: const Color(0xFF007663),
                            clipBehavior: Clip.antiAlias,
                            controlAffinity: ListTileControlAffinity.trailing,
                            maintainState: false,
                            initiallyExpanded: false,
                            onExpansionChanged: (bool expanded) {
                              setState(() {
                                isExpandedList = List<bool>.generate(
                                    faqData.length, (index) => false);
                                isExpandedList[entry.key] = expanded;
                              });
                            },
                            trailing: isExpandedList[entry.key]
                                ? const Icon(
                                    Icons.remove_circle_outline_outlined)
                                : const Icon(Icons.add_circle_outline_outlined),
                            title: Text(
                              entry.value["question"]!,
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: isExpandedList[entry.key]
                                      ? const Color(0xFF007663)
                                      : Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 10),
                                child: Text(
                                  entry.value["answer"]!,
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          thickness: 0.3,
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  //---------------------------------build Create It Online Beta-----------------------------//
  Widget buildCreateItOnlineBeta() {
    Size size = MediaQuery.of(context).size;
   
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  "Beta",
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.red,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: size.width * 0.85,
            child: Text(
              "Create video wedding Invitation online",
              maxLines: 2,
              style: GoogleFonts.getFont(
                'Montserrat',
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Beta Version",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.red,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "     •  Select the template",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "     •  Fill the basic details",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "     •  Download it and share",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
          
            onTap: !isCreateOnline
                ? null
                : () async {
                
                    _onButtonTap(
                      'https://celebrare.in/video-invitation/product-page?videoID=${widget.videoCardId}',
                      isCreateOnline,
                    );

                    // Add a 3-second delay

                    setState(() {
                      isCreateOnline = false;
                    });
                    await Future.delayed(const Duration(seconds: 3));
                    setState(() {
                      isCreateOnline = true;
                    });
                  },
            child: Container(
              height: 45,
              width: 180,
              decoration: BoxDecoration(
                color: const Color(0xFF007663),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  "Create it Online",
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //---------------------------------build Similar Photos-----------------------------//
  Widget buildSimilarPhotos() {
    Size size = MediaQuery.of(context).size;
    List photoList = [widget.photo1, widget.photo2, widget.photo3];
    return Container(
      width: size.width,
      margin: const EdgeInsets.only(left: 15, right: 15, bottom: 60),
      child: SizedBox(
        height: size.height * 0.24,
        width: size.width,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: photoList.length,
            separatorBuilder: (context, index) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: CachedNetworkImage(
                    imageUrl: photoList[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline,
                      color: Color.fromRGBO(0, 118, 99, 1),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  //---------------------------------build Message On Whatsapp---------------------------------------------//
  Widget buildMessageOnWhatsapp() {
    

    Size size = MediaQuery.of(context).size;
    return Container(
      color: const Color.fromARGB(255, 241, 249, 247),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            "Got more questions ? feel free to ask\nus",
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            "Let's Chat and create Dreem invitation together",
            style: GoogleFonts.getFont(
              'Montserrat',
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          GestureDetector(
        onTap: !isbuttonwhatsappEnabled
                ? null
                : () async {
                    _onButtonTap(
                      "https://api.whatsapp.com/send/?phone=&text=Hello+I+'+d+like+to+place+an+order+for+the+video+with+video+ID+${widget.videoCardId}+and+I+have+a+few+questions+to+ask.&type=phone_number&app_absent=0",
                      isbuttonwhatsappEnabled,
                    );

                    // Add a 3-second delay

                    setState(() {
                      isbuttonwhatsappEnabled = false;
                    });
                    await Future.delayed(const Duration(seconds: 3));
                    setState(() {
                      isbuttonwhatsappEnabled = true;
                    });
                  },
            child: Container(
              height: 45,
              width: 250,
              decoration: BoxDecoration(
                color: const Color(0xFF007663),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  "Message on Whatsapp",
                  style: GoogleFonts.getFont(
                    'Roboto',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  //=========================================================================================//
  //---------------------------------  - bottom buttons---------------------------------//
  Widget _showBottomSheet() {
 

    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(2),
      height: 74,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 1),
        boxShadow: [],
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                  
                    onTap: !ismainbuttonEnabled
                        ? null
                        : () async {
                            _onButtonTap(
                              "https://api.whatsapp.com/send/?phone=&text=Hello+I+'+d+like+to+place+an+order+for+the+video+with+video+ID+${widget.videoCardId}+and+I+have+a+few+questions+to+ask.&type=phone_number&app_absent=0",
                              ismainbuttonEnabled,
                            );

                            // Add a 3-second delay

                            setState(() {
                              ismainbuttonEnabled = false;
                            });
                            await Future.delayed(const Duration(seconds: 3));
                            setState(() {
                              ismainbuttonEnabled = true;
                            });
                          },
                    child: Container(
                      height: 70,
                      width: size.width * 0.49,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFF007663),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Order on WhatsApp',
                        style: GoogleFonts.getFont(
                          'Inter',
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF007663),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                  
                    onTap: !isPurchaseNow
                        ? null
                        : () async {
                            _onButtonTap(
                              'https://celebrare.in/video-invitation/product-page?videoID=${widget.videoCardId}',
                              isPurchaseNow,
                            );

                            // Add a 3-second delay

                            setState(() {
                              isPurchaseNow = false;
                            });
                            await Future.delayed(const Duration(seconds: 3));
                            setState(() {
                              isPurchaseNow = true;
                            });
                          },
                    child: Container(
                      height: 70,
                      width: size.width * 0.49,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFF007663),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Purchase Now',
                        style: GoogleFonts.getFont(
                          'Inter',
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
