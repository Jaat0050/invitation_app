import 'package:Celebrare/app/screens/video/video_detail.dart';
import 'package:Celebrare/app/utils/youtube_player.dart';
import 'package:Celebrare/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

class VideoInvites extends StatefulWidget {
  const VideoInvites({super.key});

  @override
  State<VideoInvites> createState() => _VideoInvitesState();
}

class _VideoInvitesState extends State<VideoInvites> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> responseData = [];
  List<Map<String, dynamic>> localResponseData = [];
  List<Map<String, dynamic>> limittedToTwenty = [];
  List<int> favIndices = [];

  int selectedIdx = -1;

  int currentPage = 0;
  bool isLastPage = false;

  //--------------------------------------------data fetching for other category--------------------------------//
  Future<void> fetchData() async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('video_invite').doc('allVideos').get();

      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
        
          setState(() {
            responseData = data.entries
                .map((entry) => {
                      'imageUrl': entry.value['imageUrl'],
                      'Price': entry.value['price'],
                      'productId': entry.value['productId'],
                      'title': entry.value['title'],
                      'videoUrl': entry.value['ytLink']
                    })
                .toList();
          });

          await box1.put('invitationsVideoBox', responseData);
          setState(() {
            localResponseData = box1.get('invitationsVideoBox');
          });

          limittedToTwenty = localResponseData.sublist(0, 5);
        } else {
       
        }
      } else {
    
      }
    } catch (error) {
    
    }
  }

  void loadMore() {
    if (!isLastPage) {
      int lower = (currentPage + 1) * 5;
      int upper = (currentPage + 2) * 5;

      if (upper <= responseData.length) {
        setState(() {
          currentPage++;
          limittedToTwenty.addAll(responseData.sublist(lower, upper));
        });
      } else {
        setState(() {
          limittedToTwenty.addAll(responseData.sublist(lower));
          isLastPage = true;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User has reached the end of the list, load more data
        loadMore();
      }
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            // controller: _scrollController,
            children: [
              //--------------------------------------discount banner---------------------------------//
              buildDiscountBanner(),
              //--------------------------------------list of video cards--------------------------------//
              buildVideoCards(),
              //-------------------------------------load more button-------------------------------------//
              if (limittedToTwenty.isNotEmpty)
                if (isLastPage != true) buildLoadMoreButton(),
            ],
          ),
        ),
      ),
    );
  }

  //---------------------------------------app bar-----------------------------------------------//
  PreferredSizeWidget? buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: const Text(
        'All video invites',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
          color: Color.fromRGBO(38, 38, 38, 1),
        ),
      ),
      centerTitle: true,
    );
  }

  //---------------------------------------discount container-------------------------------------//
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
                  const Row(
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
                      const Text(
                        'Get ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(23, 22, 22, 1),
                        ),
                      ),
                      const Text(
                        '10% OFF',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Montserrat',
                          color: Color.fromRGBO(23, 22, 22, 1),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.2,
                        child: const Text(
                          ' on your order',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat',
                            color: Color.fromRGBO(23, 22, 22, 1),
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
        const SizedBox(height: 16),
      ],
    );
  }

  //---------------------------------------video cards--------------------------------------------//
  Widget buildVideoCards() {
    return ListView.builder(
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      itemCount: limittedToTwenty.isEmpty ? 0 : limittedToTwenty.length * 2 - 1,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index % 2 == 1) {
          // Build separator
          if (index == 3) {
            return cardholidaySaveWidget(context);
          } else {
            return const SizedBox(
              height: 15,
            );
          }
        } else {
          // Build item
          int itemIndex = index ~/ 2;

          return buildVideoCard(itemIndex);
        }
      },
    );
  }

  //----------------------------------video card sub--------------------------------------//
  Widget buildVideoCard(int itemIndex) {
    Size size = MediaQuery.of(context).size;
    List image1 = limittedToTwenty[itemIndex]['imageUrl'].split('₹');
    String extractVideoId(String youtubeUrl) {
      RegExp regExp = RegExp(
        r'^https?:\/\/(?:www\.)?youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      );
      RegExpMatch? match =
          regExp.firstMatch(youtubeUrl) ?? RegExp('').firstMatch('');
      return match!.group(1) ?? '';
    }

    String vedioId = extractVideoId(limittedToTwenty[itemIndex]['videoUrl']);

    String thumbnailUrl1 = 'https://img.youtube.com/vi/$vedioId/0.jpg';

  

    return Stack(
      fit: StackFit.passthrough,
      alignment: Alignment.topRight,
      children: [
        Container(
          width: size.width,
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(194, 197, 196, 1),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              //----------------------------------------video and photo card---------------------------------------------//
              SizedBox(
                height: size.height * 0.53,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    selectedIdx == itemIndex
                        ? SizedBox(
                            width: size.width * 0.62,
                            height: size.height * 0.53,
                            child: YouTubePlayerDemo(
                              //   controller: YoutubePlayerController(
                              //     initialVideoId: vedioId,
                              //     flags: const YoutubePlayerFlags(
                              //       autoPlay: true,
                              //       mute: false,
                              //       disableDragSeek: true,
                              //       showLiveFullscreenButton: false,
                              //       controlsVisibleAtStart: false,
                              //     ),
                              //   ),
                              //   aspectRatio: 9 / 16,
                              //   showVideoProgressIndicator: false,
                              //   progressIndicatorColor: Colors.blueAccent,
                              //   controlsTimeOut: const Duration(seconds: 2),
                              //   onEnded: (metaData) {
                              //     setState(() {
                              //       selectedIdx = -1;
                              //     });
                              //   },
                              // ),
                              aspectRatio: 9 / 16,
                              vedioUrl: limittedToTwenty[itemIndex]['videoUrl'],
                            ),
                          )
                        : Stack(
                            alignment: Alignment.center,
                            fit: StackFit.passthrough,
                            children: [
                              SizedBox(
                                width: size.width * 0.62,
                                height: size.height * 0.53,
                                child: CachedNetworkImage(
                                  imageUrl: thumbnailUrl1,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error_outline,
                                    color: Color.fromRGBO(0, 118, 99, 1),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIdx = itemIndex;
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
                          ),
                    //----------------------------------------side images------------------------------------//
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.22,
                          height: size.height * 0.17,
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: CachedNetworkImage(
                              imageUrl: '${image1[0]}',
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
                        SizedBox(
                          width: size.width * 0.22,
                          height: size.height * 0.17,
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: CachedNetworkImage(
                              imageUrl: '${image1[1]}',
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
                        SizedBox(
                          width: size.width * 0.22,
                          height: size.height * 0.17,
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: CachedNetworkImage(
                              imageUrl: '${image1[2]}',
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
                      ],
                    ),
                  ],
                ),
              ),
              //-----------------------------bottom text and details button--------------------------------//
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            limittedToTwenty[itemIndex]['title'],
                            maxLines: 2,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 2),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Text(
                                      limittedToTwenty[itemIndex]['Price'] ==
                                              '999'
                                          ? '₹1998'
                                          : '₹3498',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(147, 146, 146, 1),
                                        fontSize: 14,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      width: 30,
                                      color: const Color.fromRGBO(
                                          147, 146, 146, 1),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Text(
                                '₹${limittedToTwenty[itemIndex]['Price']}',
                                style: const TextStyle(
                                  color: Color(0xFF161515),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 55,
                                height: 16,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/discount.png',
                                    ),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    '50% OFF',
                                    style: TextStyle(
                                      color: Color.fromRGBO(198, 88, 53, 1),
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                       
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => VideoDetails(
                              videoId: vedioId,
                              videolink: limittedToTwenty[itemIndex]
                                  ['videoUrl'],
                              videoCardId: limittedToTwenty[itemIndex]
                                  ['productId'],
                              photo1: image1[0],
                              photo2: image1[1],
                              photo3: image1[2],
                              discountPrice:
                                  limittedToTwenty[itemIndex]['Price'] == 999
                                      ? '1799'
                                      : '3299',
                              offPrice:
                                  limittedToTwenty[itemIndex]['Price'] == 999
                                      ? '899'
                                      : '1649',
                              price: '${limittedToTwenty[itemIndex]['Price']}',
                              title: limittedToTwenty[itemIndex]['title'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 106,
                        height: 42,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1.50, color: Color(0xFF007663)),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'View Details ',
                              style: TextStyle(
                                color: Color(0xFF007663),
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                height: 0.11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        //----------------------------------fav icon----------------------------------------//
        Positioned(
          top: 18,
          right: 30,
          child: GestureDetector(
            onTap: () {
              setState(() {
                if (favIndices.contains(itemIndex)) {
                  favIndices.remove(itemIndex);
                } else {
                  favIndices.add(itemIndex);
                }
              });
            },
            child: Container(
              height: 38,
              width: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(235, 243, 238, 1),
              ),
              child: Center(
                child: Icon(
                  favIndices.contains(itemIndex)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: const Color.fromRGBO(0, 118, 99, 1),
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //----------------------------------------poster--------------------------------------//
  Widget cardholidaySaveWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, top: 10),
      color: const Color(0xffF1DAD3),
      // padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
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

  //---------------------------------------load more button---------------------------------------//
  Widget buildLoadMoreButton() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 20),
      width: size.width,
      child: GestureDetector(
        onTap: () {
          loadMore();
        },
        child: const SizedBox(
          height: 40,
          width: 80,
          child: Icon(
            Icons.keyboard_double_arrow_down_rounded,
            color: Color.fromRGBO(0, 118, 99, 1),
            shadows: [
              BoxShadow(
                color: Color(0x0F0D230A), // Shadow color
                blurRadius: 50,
                spreadRadius: 0,
                offset: Offset(10, 24),
              ),
            ],
            size: 40,
          ),
        ),
      ),
    );
  }
}
