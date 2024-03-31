import 'package:Celebrare/app/utils/tutorial_player.dart';
import 'package:Celebrare/app/widgets/homepage_widgets.dart';
import 'package:Celebrare/app/widgets/staggered.dart';
import 'package:Celebrare/app/widgets/step_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Celebrare/app/bottom_nav.dart';
import 'package:Celebrare/app/screens/cards/all_card_invites.dart';
import 'package:Celebrare/app/models/category_model.dart';
import 'package:Celebrare/app/utils/review_player.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// import 'package:gif/gif.dart';
// import 'package:gif_view/gif_view.dart';
// import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

bool isCardActive = true;

Category buddha = Category(
  imageUrl: "assets/categories/buddha.png",
  title: 'Buddha',
  isMore: false,
  parameter: "buddha",
);

List<Category> categoriesList = [
  Category(
      imageUrl: "assets/categories/all.png",
      title: 'All',
      isMore: false,
      parameter: "all"),
  Category(
    imageUrl: "assets/categories/general.png",
    title: 'General',
    isMore: false,
  ),
  Category(
    imageUrl: "assets/categories/hindu.png",
    title: 'Hindu',
    isMore: false,
  ),
  Category(
    imageUrl: 'assets/categories/muslim.png',
    title: 'Muslim',
    isMore: false,
  ),
  Category(
    imageUrl: "assets/categories/punjabi.png",
    title: 'punjabi',
    isMore: false,
  ),
  Category(
    imageUrl: 'assets/categories/bengali.png',
    title: 'Bengali',
    isMore: false,
  ),
  Category(
    imageUrl: "assets/categories/marathi.png",
    title: 'Marathi',
    isMore: false,
  ),

  Category(
      imageUrl: 'https://cdn-icons-png.flaticon.com/128/5459/5459354.png',
      title: 'More',
      isMore: true,
      parameter: "more"),
  Category(
    imageUrl: "assets/categories/south.png",
    title: 'South',
    isMore: false,
  ),
  Category(
    imageUrl: "assets/categories/christian.png",
    title: 'Christian',
    isMore: false,
  ),
  Category(
    imageUrl: "assets/categories/other.png",
    title: 'Other',
    isMore: false,
  ),
  Category(
    imageUrl: "assets/categories/engagement.png",
    title: 'Engagement',
    isMore: false,
  ),
  // Add more categories as needed
];

class _HomepageState extends State<Homepage> {
  final CarouselController cardcarouselController = CarouselController();
  late List<VideoPlayerController> allControllers;
  bool showAllItems = false;
  int selectedIdx = -1;
  int currentIndex = 0;

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

  List videoReviewList = [
    {
      "id": 1,
      "videoUrl": "assets/reviews/manisha.webm",
      "name": "Manisha Mehra",
    },
    {
      "id": 2,
      "videoUrl": "assets/reviews/raj.webm",
      "name": "Raj Gupta",
    },
    {
      "id": 3,
      "videoUrl": "assets/reviews/mansi.webm",
      "name": "Mansi Singh",
    },
    {
      "id": 4,
      "videoUrl": "assets/reviews/anjali.webm",
      "name": "Anjali Sharma",
    },
    {
      "id": 5,
      "videoUrl": "assets/reviews/arun.webm",
      "name": "Arun Singh",
    },
  ];

  List<VideoPlayerController> _getVideoControllersFromHive() {
    try {
      final controllers = videoReviewList.map((item) {
        return VideoPlayerController.asset(
          item["videoUrl"],
        )..initialize().then((_) {
            setState(() {});
          });
      }).toList();
      return controllers;
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    allControllers = _getVideoControllersFromHive();
  }

  @override
  void dispose() {
    for (var controller in allControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.4,
                      blurRadius: 3,
                      offset: const Offset(0, 4.0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    topBanner(context),
                    celebrareTextLogo(),
                    // createNowWidget(context),
                    optionBar(),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              isCardActive ? cardInviteSide() : vedioInviteSide()
            ],
          ),
        ),
      ),
    );
  }

  Padding optionBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                isCardActive = true;
              });
            },
            child: optionTab("Card Invites", "assets/card.png", isCardActive),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isCardActive = false;
              });
            },
            child:
                optionTab("Video Invites", "assets/video.png", !isCardActive),
          ),
        ],
      ),
    );
  }

  Widget celebrareTextLogo() {
    return Container(
      width: 140,
      // height: 32,
      padding: const EdgeInsets.all(8.0),
      child: Image.asset("assets/celebrare-wed.webp"),
    );
  }

  Widget youtubeVideoListview() {
    List images = [
      "https://www.youtube.com/watch?v=mZcfy_Heu7o",
      "https://www.youtube.com/embed/KqZFEOfxCMA?si=Yrf8X5y7RUzTqZyO",
      "https://www.youtube.com/embed/2AztsJtJg7E?si=ZoUjMQ_FCvrHv_vg",
      "https://www.youtube.com/embed/huCuyswT7xQ?si=SZPrYWtU44etu5f9",
    ];
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                homepageHeading('All video invites'),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<Map<String, String>>(
                        builder: (BuildContext context) => BottomNav(
                          initialIndex: 2,
                        ),
                      ),
                    );
                  },
                  child: const Row(
                    children: [
                      Text(
                        "View All",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xdd007663),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                          color: Color(0xdd007663),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xdd007663),
                        size: 16,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
            width: MediaQuery.of(context).size.width,
            height: 270,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: images.length,
              itemBuilder: (context, index) {
                String extractVideoId(String youtubeUrl) {
                  RegExp regExp = RegExp(
                    r'^https?:\/\/(?:www\.)?youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=|youtu\.be\/)([a-zA-Z0-9_-]{11})',
                  );
                  RegExpMatch? match = regExp.firstMatch(youtubeUrl) ??
                      RegExp('').firstMatch('');
                  return match!.group(1) ?? '';
                }

                String videoId = extractVideoId(images[index]);

                return selectedIdx == index
                    ? SizedBox(
                        width: 145,
                        child: YoutubePlayer(
                          controller: YoutubePlayerController.fromVideoId(
                            videoId: videoId,
                            autoPlay: true,
                            params: const YoutubePlayerParams(
                              enableJavaScript: true,
                              showFullscreenButton: false,
                            ),
                          ),
                          aspectRatio: 9 / 16,
                          enableFullScreenOnVerticalDrag: false,
                        ),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        fit: StackFit.passthrough,
                        children: [
                          SizedBox(
                            width: 145,
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://img.youtube.com/vi/$videoId/0.jpg',
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
                                selectedIdx = index;
                              });
                            },
                            child: Center(
                              child: Container(
                                height: 35,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF007663),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Map<String, String>>(
                  builder: (BuildContext context) => BottomNav(initialIndex: 1),
                ),
              );
            },
            child: createInvitationButton('View all video Invites', () {
              Navigator.push(
                context,
                MaterialPageRoute<Map<String, String>>(
                  builder: (BuildContext context) => BottomNav(
                    initialIndex: 2,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget cardInviteSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 400,
                      child: Image.asset(
                        "assets/curve_bg.png",
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 30),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: const MovingGrid()),
                ),
              ),
              Positioned(
                bottom: 0,
                child: watchOnYoutube(
                  context,
                  item: "assets/celebraretutorial.mp4",
                  bgImage: "assets/video_tutorial_bg.png",
                  caption: "Watch how to make your E- wedding\nInvite",
                ),
              ),
            ],
          ),
        ),

        createInvitationButton('Let’s Create Your Invitation', () {
          Navigator.push(
            context,
            MaterialPageRoute<Map<String, String>>(
              builder: (BuildContext context) => BottomNav(
                initialIndex: 1,
              ),
            ),
          );
        }, isArrow: true),
        categories(),
        // allCardsWidget(context),
        cardholidaySaveWidget(context),

        // tutorialWidget(
        //     item: "assets/celebraretutorial.mp4",
        //     bgImage: "assets/video_tutorial_bg.png",
        //     caption: "Watch how to make your E- wedding\nInvite"),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            children: [
              homepageHeading("Watch Tutorial"),
              const SizedBox(
                height: 9,
              ),
              Stack(
                alignment: Alignment.center,
                fit: StackFit.passthrough,
                children: [
                  Container(
                    width: double.infinity,
                    height: 167,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/video_tutorial_bg.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                      // color: const Color(0xFF010101),
                      // color: Colors.amber,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    // child: TutorialPlayer(
                    //   bgImage: bgImage,
                    //   caption: caption,
                    //   item: item,
                    // ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDiaVideolog(
                            item: "assets/celebraretutorial.mp4",
                            bgImage: "assets/video_tutorial_bg.png",
                            caption:
                                "Watch how to make your E- wedding\nInvite",
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF007663),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        cardSays(),
        simpleSteps(),
        createInvitationButton("Create Your Invitation Now", () {
          Navigator.push(
            context,
            MaterialPageRoute<Map<String, String>>(
              builder: (BuildContext context) => BottomNav(
                initialIndex: 1,
              ),
            ),
          );
        }),
        videoCatatlogue(context),
      ],
    );
  }

  Widget vedioInviteSide() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            // alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 330,
                      child: Image.asset(
                        "assets/curve_bg.png",
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Center(
                  child: Image.asset(
                    'assets/gif1.gif',
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    filterQuality: FilterQuality.low,
                    fit: BoxFit.cover,
                    isAntiAlias: true,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: watchOnYoutube(
                  context,
                  item: "assets/celebraretutorial.mp4",
                  bgImage: "assets/card_tutorial_bg.png",
                  caption:
                      "Watch to understand everything you\nneed to know about video invites  ",
                ),
              ),
            ],
          ),
        ),

        // watchOnYoutube(context),
        youtubeVideoListview(),

        // allCardsWidget(context),
        cardholidaySaveWidget(context),

        // tutorialWidget(
        //     item: "assets/celebraretutorial.mp4",
        //     bgImage: "assets/card_tutorial_bg.png",
        //     caption:
        //         "Watch to understand everything you\nneed to know about video invites  "),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            children: [
              homepageHeading("Watch Tutorial"),
              const SizedBox(
                height: 9,
              ),
              Stack(
                alignment: Alignment.center,
                fit: StackFit.passthrough,
                children: [
                  Container(
                    width: double.infinity,
                    height: 167,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                          'assets/card_tutorial_bg.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                      // color: const Color(0xFF010101),
                      // color: Colors.amber,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    // child: TutorialPlayer(
                    //   bgImage: bgImage,
                    //   caption: caption,
                    //   item: item,
                    // ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CustomDiaVideolog(
                              item: "assets/celebraretutorial.mp4",
                              bgImage: "assets/card_tutorial_bg.png",
                              caption:
                                  "Watch to understand everything you\nneed to know about video invites  ");
                        },
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 35,
                        width: 60,
                        decoration: BoxDecoration(
                          color: const Color(0xFF007663),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        vedioSays(),
        cardCatatlogue(context),

        // vedioPreview(
        //     'https://www.youtube.com/watch?v=mZcfy_Heu7o',
        //     'assets/templates/videotempb1.webp',
        //     'assets/templates/videotempb2.webp',
        //     'assets/templates/videotempb3.webp'),
        // vedioholidaySaveWidget(),
      ],
    );
  }

  Widget simpleSteps() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 27),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Create in',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  color: Color(0xff171616),
                ),
              ),
              Text(
                ' 3 Simple Steps',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat',
                  color: Color(0xff007663),
                ),
              ),
            ],
          ),
          StepListTile(
            titleText: "Select cards",
            subtitleText: "Select cards from 500+\nbeautiful designs ",
            trailing: "assets/select_step.png",
            primaryText: "1.",
          ),
          Divider(
            indent: 40,
            endIndent: 40,
          ),
          StepListTile(
            titleText: "Fill Details",
            subtitleText: "Fill text and add photos of\nbride and groom",
            trailing: "assets/fill_step.png",
            primaryText: "2.",
          ),
          Divider(
            indent: 40,
            endIndent: 40,
          ),
          StepListTile(
            titleText: "Share Invitation",
            subtitleText: "Share and download your\ninvitation easily",
            trailing: "assets/share_step.png",
            primaryText: "3.",
          ),
        ],
      ),
    );
  }

  Widget categories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              homepageHeading('Categories'),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Map<String, String>>(
                      builder: (BuildContext context) =>
                          BottomNav(initialIndex: 1),
                    ),
                  );
                },
                child: const Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xdd007663),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Color(0xdd007663),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xdd007663),
                      size: 16,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: showAllItems ? categoriesList.length : 8,
          itemBuilder: (context, index) {
            if (showAllItems) {
              if (categoriesList[index].title == "More") {
                return gridChild(buddha, index);
              } else {
                return gridChild(categoriesList[index], index);
              }
            } else {
              return gridChild(categoriesList[index], index);
            }
          },
        ),
        showAllItems == true
            ? InkWell(
                onTap: () {
                  setState(() {
                    showAllItems = false;
                  });
                },
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 10,
                      width: 50,
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        size: 30,
                        color: Color.fromRGBO(0, 118, 99, 1),
                      ),
                    ),
                  ),
                ),
              )
            : Container()
      ],
    );
  }

  Widget gridChild(Category model, int indexNo) {
    return GestureDetector(
      onTap: () {
        if (model.title != "More") {
          Navigator.push(
            context,
            MaterialPageRoute<Map<String, String>>(
              builder: (BuildContext context) => AllCardsInvites(
                categoryParameter: model.title.toLowerCase(),
                index: indexNo,
                fromSelectedCategory: true,
              ),
            ),
          );
        } else {
          setState(() {
            showAllItems = true;
          });
        }
      },
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.only(top: 2, left: 2, right: 2),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromRGBO(251, 243, 222, 1),
            ),
            child: model.isMore
                ? const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Color(0xff007663),
                  )
                : CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(model.imageUrl),
                  ),
          ),
          SizedBox(
            child: Text(
              model.title,
              style: const TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  Widget cardSays() {
    return SizedBox(
      // padding: EdgeInsets.all(18),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                homepageHeading("Want to know more?"),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Here from our customers',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                    color: Color(0xff4D4D4D),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: 30, child: Image.asset("assets/google_play.png")),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  children: [
                    Text(
                      '4.5',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Color(0xff605F5F),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xffFAD515),
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xffFAD515),
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xffFAD515),
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Color(0xffFAD515),
                          ),
                          Icon(
                            Icons.star_half_rounded,
                            color: Color(0xffFAD515),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '3K+ Reviews',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                        color: Color(0xff605F5F),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
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
                  autoPlay: true,
                  aspectRatio: 2,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),
              // Positioned(
              //   left: 10,
              //   bottom: 120,
              //   child: IconButton(
              //     icon: Icon(Icons.arrow_back_ios),
              //     onPressed: () {
              //       // Move to the previous slide
              //       cardcarouselController.previousPage();
              //     },
              //   ),
              // ),
              Positioned(
                top: 70,
                child: Container(
                  padding: const EdgeInsets.all(10),
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
          )
        ],
      ),
    );
  }

  Widget vedioSays() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        homepageHeading("Hear From Our Users"),
        InkWell(
          onTap: () {},
          child: CarouselSlider(
            items: videoReviewList
                .asMap()
                .entries
                .map(
                  (entry) => ReviewPlayer(
                    item: entry.value,
                    controller: allControllers[entry.key],
                  ),
                )
                .toList(),
            carouselController: cardcarouselController,
            options: CarouselOptions(
              height: 520,
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: false,
              aspectRatio: 2,
              viewportFraction: 1,
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                  for (var controller in allControllers) {
                    controller.pause();
                  }
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // children: videoReviewList.asMap().entries.map((entry) {
            children: List.generate(videoReviewList.length, (index) {
              // return GestureDetector(
              //   onTap: () => cardcarouselController.animateToPage(entry.key),
              //   child: Container(
              //     width: currentIndex == entry.key ? 15 : 7,
              //     height: 7.0,
              //     margin: const EdgeInsets.symmetric(horizontal: 5),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10),
              //       color: currentIndex == entry.key
              //           ? const Color(0xff007663)
              //           : const Color(0xffD9D9D9),
              //     ),
              //   ),
              // );
              // }).toList(),
              return CustomDotIndicator(
                currentIndex: currentIndex,
                itemIndex: index,
              );
            }),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

 
  Widget optionTab(String title, String imageUrl, bool isActive) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isActive
              ? [
                  const Color(0xff029A82),
                  const Color(0xff2CCEC1),
                ]
              : [
                  Colors.white,
                  Colors.white,
                ],
        ),
        border: isActive
            ? Border.all(
                color: Colors.transparent,
                width: 1,
              )
            : Border.all(
                color: const Color(0xff007663),
                width: 1,
              ),
        // color: isActive ? const Color(0xff007663) : Colors.white,
        borderRadius: BorderRadius.circular(26),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18.5),
      child: Row(
        children: [
          SizedBox(
            height: 22,
            width: 23,
            child: Image.asset(imageUrl),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isActive ? Colors.white : const Color(0xff007663)),
          ),
        ],
      ),
    );
  }
}

class CustomDotIndicator extends StatelessWidget {
  final int currentIndex;
  final int itemIndex;
  const CustomDotIndicator({
    super.key,
    required this.currentIndex,
    required this.itemIndex,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => /* Handle dot tap action */,
      child: Container(
        width: currentIndex == itemIndex ? 15 : 7,
        height: 7.0,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: currentIndex == itemIndex
              ? const Color(0xff007663)
              : const Color(0xffD9D9D9),
        ),
      ),
    );
  }
}

class CustomDiaVideolog extends StatefulWidget {
  final String item;
  final String bgImage;
  final String caption;
  const CustomDiaVideolog({
    Key? key,
    required this.item,
    required this.bgImage,
    required this.caption,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomDiaVideologState createState() => _CustomDiaVideologState();
}

class _CustomDiaVideologState extends State<CustomDiaVideolog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Watch Tutorial',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),
            AspectRatio(
              aspectRatio: 9 / 16,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffECECFF),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: TutorialPlayer(
                  bgImage: widget.bgImage,
                  caption: widget.caption,
                  item: widget.item,
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
