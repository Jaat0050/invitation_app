import 'package:Celebrare/app/screens/cards/card_product_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Celebrare/app/models/custom_fonts.dart';
import 'package:Celebrare/app/screens/cards/customize_details.dart';
import 'package:Celebrare/app/utils/editting_utils.dart';
import 'package:Celebrare/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class AllCardsInvites extends StatefulWidget {
  final bool fromSelectedCategory;
  final String categoryParameter;
  final int index;
  const AllCardsInvites(
      {super.key,
      required this.categoryParameter,
      required this.index,
      required this.fromSelectedCategory});

  @override
  State<AllCardsInvites> createState() => _AllCardsInvitesState();
}

class _AllCardsInvitesState extends State<AllCardsInvites> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> responseData = [];
  List<Map<String, dynamic>> localResponseData = [];
  List<Map<String, dynamic>> limittedToTwenty = [];
  List<int> favIndices = [];

  int selectedIndex = 0;
  int currentIndex = 2;
  String _category = 'all';
  bool showAllItems = false;
  String _brideName = 'Bride';
  String _groomName = 'Groom';
  String _cardLanguage = 'Card Language';
  int currentPage = 0;
  bool isLastPage = false;

  List<Map<String, dynamic>> items = [
    {
      "image": "assets/categories/all.png",
      "text": "All",
      "name": "all",
    },
    {
      "image": "assets/categories/general.png",
      "text": "General",
      "name": "general",
    },
    {
      "image": "assets/categories/hindu.png",
      "text": "Hindu",
      "name": "hindu",
    },
    {
      "image": "assets/categories/muslim.png",
      "text": "Muslim",
      "name": "muslim",
    },
    {
      "image": "assets/categories/punjabi.png",
      "text": "Punjabi",
      "name": "sikh",
    },
    {
      "image": "assets/categories/bengali.png",
      "text": "Bengali",
      "name": "bengali",
    },
    {
      "image": "assets/categories/marathi.png",
      "text": "Marathi",
      "name": "marathi",
    },
    {
      "image": "assets/categories/buddha.png",
      "text": "Buddha",
      "name": "buddha",
    },
    {
      "image": "assets/categories/south.png",
      "text": "South",
      "name": "south_indian",
    },
    {
      "image": "assets/categories/christian.png",
      "text": "Christian",
      "name": "christian",
    },
    {
      "image": "assets/categories/other.png",
      "text": "Other",
      "name": "other",
    },
    {
      "image": "assets/categories/engagement.png",
      "text": "Engagement",
      "name": "engagement",
    },
  ];

  //------------------------------------------fetch data for all and general----------------------------------//
  Future<List<Map<String, dynamic>>> fetchDataforAll(
      String category, int index) async {
    List<Map<String, dynamic>> loadData = [];
    try {
      DocumentSnapshot snapshot = await _firestore
          .collection('weddinginvitations')
          .doc(category)
          .collection('cards')
          .doc(index.toString())
          .get();
      if (snapshot.exists) {
        
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            responseData.clear();
          });
          data.forEach((key, value) {
            setState(() {
              responseData.add(
                {
                  'imageUrl': value[0],
                  'cardId': value[1],
                  'tags': value[2],
                  'textstyle': value[3],
                  'category': value[4]
                },
              );
            });
          });
          loadData = responseData;
        

          await box.put('invitationsBox', responseData);
          setState(() {
            localResponseData = box.get('invitationsBox');
          });
          if (!isLastPage) {
            int lower = 0;
            int upper = 20;
            if (upper <= localResponseData.length) {
              setState(() {
                limittedToTwenty.clear();
                limittedToTwenty = localResponseData.sublist(lower, upper);
                
              });
            } else {
              setState(() {
                limittedToTwenty.clear();
                limittedToTwenty =
                    localResponseData.sublist(lower, localResponseData.length);
                isLastPage = true;
               
              });
            }
          }

         
        } else {
         
        }
      } else {
       
      }
    } catch (error) {
      
    }
    return loadData;
  }

  //-----------------------------------------general cards after cards-----------------------------------------//

  Future<List<Map<String, dynamic>>> fetchGeneralCardsAfterCards(
      String category, int index) async {
    List<Map<String, dynamic>> loadData = [];
    try {
      DocumentSnapshot snapshot = await _firestore
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
                  'category': value[4]
                },
              );
            });
          });

          
        } else {
          
        }
      } else {
        
      }
    } catch (error) {
      
    }
    return loadData;
  }

  //--------------------------------------------data fetching for other category--------------------------------//
  Future<void> fetchData(String category) async {
    List<Map<String, dynamic>> loadData7 = [];
    try {
      List<Map<String, dynamic>> generalData =
          await fetchGeneralCardsAfterCards('general', 1);
      loadData7 = List.from(generalData);

      DocumentSnapshot snapshot = await _firestore
          .collection('weddinginvitations')
          .doc(category) // Use the category variable here
          .get();
      if (snapshot.exists) {
       
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            responseData.clear();
          });
          data.forEach((key, value) {
            setState(() {
              responseData.add(
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
          responseData.addAll(loadData7);
          await box.put('invitationsBox', responseData);

          setState(() {
            localResponseData = box.get('invitationsBox');
          });
          if (!isLastPage) {
            int lower = 0;
            int upper = 20;
            if (upper <= localResponseData.length) {
              setState(() {
                limittedToTwenty.clear();
                limittedToTwenty = localResponseData.sublist(lower, upper);
                
              });
            } else {
              setState(() {
                limittedToTwenty.clear();
                limittedToTwenty =
                    localResponseData.sublist(lower, localResponseData.length);
                isLastPage = true;
                
              });
            }
          }

         
        } else {
         
        }
      } else {
       
      }
    } catch (error) {
     
    }
  }

  //----------------------------------------page next---------------------------------------//
  void pageforword() {
    if (!isLastPage) {
      int lower = (currentPage + 1) * 20;
      int upper = (currentPage + 2) * 20;
      if (upper <= localResponseData.length) {
        setState(() {
          currentPage++;
          limittedToTwenty.addAll(localResponseData.sublist(lower, upper));
         
          if (_shouldLoadMoreData()) {
            loadMoreData();
          }
        });
      } else {
        setState(() {
          currentPage++;
          limittedToTwenty.addAll(
              localResponseData.sublist(lower, localResponseData.length));
          isLastPage = true;
         
          if (_shouldLoadMoreData()) {
            loadMoreData();
          }
        });
      }
    }
  }



  bool _shouldLoadMoreData() {
    return [1, 3, 5, 7, 9, 11, 13].contains(currentPage);
  }

  //------------------------------------------loading more data for all and general-----------------------//
  Future<void> loadMoreData() async {
    if (_category == 'all') {
      if (currentIndex <= 8) {
        // fetchDataforAll(_category, currentIndex);
        try {
          DocumentSnapshot snapshot = await _firestore
              .collection('weddinginvitations')
              .doc(_category)
              .collection('cards')
              .doc(currentIndex.toString())
              .get();
          if (snapshot.exists) {
           
            Map<String, dynamic>? data =
                snapshot.data() as Map<String, dynamic>?;
            if (data != null) {
              data.forEach((key, value) {
                setState(() {
                  responseData.add(
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
              await box.put('invitationsBox', responseData);
              setState(() {
                localResponseData = box.get('invitationsBox');
              });
             
            } else {
             
            }
          } else {
          
          }
        } catch (error) {
         
        }
        currentIndex++;
      }
    } else if (_category == 'general') {
      if (currentIndex <= 4) {
        // fetchDataforAll(_category, currentIndex);
        try {
          DocumentSnapshot snapshot = await _firestore
              .collection('weddinginvitations')
              .doc(_category)
              .collection('cards')
              .doc(currentIndex.toString())
              .get();
          if (snapshot.exists) {
          
            Map<String, dynamic>? data =
                snapshot.data() as Map<String, dynamic>?;
            if (data != null) {
              data.forEach((key, value) {
                setState(() {
                  responseData.add(
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
              await box.put('invitationsBox', responseData);
              setState(() {
                localResponseData = box.get('invitationsBox');
              });
              
            } else {
             
            }
          } else {
           
          }
        } catch (error) {
          
        }

        currentIndex++;
      }
    } else {
      if (currentIndex <= 4) {
        // fetchDataforAll(_category, currentIndex);
        try {
          DocumentSnapshot snapshot = await _firestore
              .collection('weddinginvitations')
              .doc('general')
              .collection('cards')
              .doc(currentIndex.toString())
              .get();
          if (snapshot.exists) {
            
            Map<String, dynamic>? data =
                snapshot.data() as Map<String, dynamic>?;
            if (data != null) {
              data.forEach((key, value) {
                setState(() {
                  responseData.add(
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
              await box.put('invitationsBox', responseData);
              setState(() {
                localResponseData = box.get('invitationsBox');
              });
             
            } else {
             
            }
          } else {
           
          }
        } catch (error) {
        
        }

        currentIndex++;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageforword();
      }
    });
    
    setState(() {
      selectedIndex = widget.index;
      _category = widget.categoryParameter;
    });
    if (widget.index > 7) {
      setState(() {
        showAllItems = true;
      });
    }

    if (widget.index > 1) {
      fetchData(_category);
    }
    fetchDataforAll(_category, 1);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
        title: const Text(
          'All card invites',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
            color: Color.fromRGBO(38, 38, 38, 1),
          ),
        ),
        centerTitle: true,
        leading: widget.fromSelectedCategory == false
            ? const SizedBox()
            : GestureDetector(
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
        color: Colors.white,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              //------------------------------top section------------------------------//
              //
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //------------------------------discount banner------------------//

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
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  //----------------------------customize details------------------//
                  GestureDetector(
                    onTap: () async {
                      // Wait for the CustomizeDetails screen to be popped and receive data
                      Map<String, String>? returnedData = await Navigator.push(
                        context,
                        MaterialPageRoute<Map<String, String>>(
                          builder: (BuildContext context) => CustomizeDetails(
                              bride: _brideName, groom: _groomName),
                        ),
                      );

                      // Check if data is not null and update the state or perform any other actions
                      if (returnedData != null) {
                        setState(() {
                          _brideName = returnedData['brideName'] ?? _brideName;
                          _groomName = returnedData['groomName'] ?? _groomName;
                          _cardLanguage =
                              returnedData['cardLanguage'] ?? _cardLanguage;
                        });
                      }
                    },
                    child: Container(
                      height: 57,
                      width: size.width,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(96, 95, 95, 1),
                          width: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Customize details',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                  color: Color.fromRGBO(23, 22, 22, 1),
                                ),
                              ),
                              Text(
                                '$_groomName, $_brideName, $_cardLanguage',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Roboto',
                                  color: Color.fromRGBO(144, 144, 144, 1),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                              height: 24,
                              width: 24,
                              child: Image(
                                image: AssetImage('assets/edit.png'),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //---------------------------category text------------------------//
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(23, 22, 22, 1),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),

              //----------------------------gridview for types--------------------//
              Padding(
                padding: EdgeInsets.only(bottom: showAllItems ? 10 : 30),
                child: GridView.builder(
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisExtent: 100,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: showAllItems ? items.length : 8,
                  itemBuilder: (BuildContext context, int index) {
                    //     return ;
                    //   },
                    // ),(
                    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    // crossAxisCount: 4,
                    // mainAxisExtent: 100,
                    // mainAxisSpacing: 10,
                    //   ),
                    //   delegate: SliverChildBuilderDelegate(
                    //     (BuildContext context, int index) {
                    if (!showAllItems && index == 7) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            showAllItems = !showAllItems;
                            // selectedIndex = -1;
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.only(
                                  top: 2, left: 2, right: 2),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(251, 243, 222, 1),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 30,
                                  color: Color.fromRGBO(0, 118, 99, 1),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'More',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                color: Color.fromRGBO(68, 67, 67, 1),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      final item = items[index];
                      return GestureDetector(
                        onTap: selectedIndex == index
                            ? null
                            : () {
                                setState(() {
                                  if (index == 0 || index == 1) {
                                    setState(() {
                                      isLastPage = false;
                                      currentPage = 0;
                                      limittedToTwenty.clear();
                                      localResponseData.clear();
                                      _category = item["name"];
                                      currentIndex = 2;
                                    });
                                    fetchDataforAll(item["name"], 1);
                                   
                                  } else {
                                    setState(() {
                                      isLastPage = false;
                                      currentPage = 0;
                                      limittedToTwenty.clear();
                                      localResponseData.clear();
                                      _category = '';
                                      currentIndex = 2;
                                    });
                                    fetchData(item["name"]);

                                  
                                  }
                                  selectedIndex = index;
                                });
                              },
                        child: Column(
                          children: [
                            // Container(
                            //   height: 55,
                            //   width: 55,
                            //   margin: const EdgeInsets.only(bottom: 10),
                            //   clipBehavior: Clip.antiAlias,
                            //   padding: const EdgeInsets.only(
                            //       top: 4.34, left: 2.17, right: 2.17),
                            //   decoration: BoxDecoration(
                            //     shape: BoxShape.circle,
                            //     color: const Color.fromRGBO(251, 243, 222, 1),
                            //     border: Border.all(
                            //       color: selectedIndex == index
                            //           ? Color(0xFF007663)
                            //           : Colors.transparent,
                            //       width: 4,
                            //       strokeAlign: BorderSide.strokeAlignOutside,
                            //     ),
                            //   ),
                            Container(
                              height: 60,
                              width: 60,
                              margin: const EdgeInsets.only(bottom: 10),
                              clipBehavior: Clip.antiAlias,
                              padding: const EdgeInsets.only(
                                  top: 4, left: 2, right: 2, bottom: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: selectedIndex == index
                                    ? const LinearGradient(
                                        colors: [
                                          Color(0xFF007663),
                                          Color.fromARGB(255, 10, 221, 186),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      )
                                    : null,
                                // border: Border.all(
                                //   color: Color(0xFF007663),
                                //   width: 4,
                                // ),
                              ),
                              child: Container(
                                height: 55,
                                width: 55,
                                padding: const EdgeInsets.only(
                                    top: 4, left: 2, right: 2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromRGBO(251, 243, 222, 1),
                                  // border: Border.all(
                                  //   color: Colors.transparent,
                                  //   width: 4,
                                  //   style: BorderStyle.solid,
                                  // ),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage('${item["image"]}'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              item["text"],
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Roboto',
                                color: Color.fromRGBO(68, 67, 67, 1),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),

              //-----------------------------up button----------------------------------//
              if (showAllItems)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAllItems = false;
                      if (selectedIndex >= 7) {
                        selectedIndex = 0;
                      }
                    });
                  },
                  child: const SizedBox(
                    height: 40,
                    width: 50,
                    child: Icon(
                      Icons.keyboard_arrow_up,
                      size: 30,
                      color: Color.fromRGBO(0, 118, 99, 1),
                    ),
                  ),
                ),

              //----------------------------gridview for photos--------------------//

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GridView.builder(
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 330,
                  ),
                  itemCount: limittedToTwenty.length,
                  itemBuilder: (BuildContext context, int index) {
                    //-----------------------date-----------------------------------------------//
                    DateTime now = DateTime.now();
                    String formattedDate =
                        DateFormat('dd\'th\' MMM, yyyy').format(now);

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
                    double originalFontSize1 =
                        double.parse(textStyleValues1[1]);
                    double originalFontSize2 =
                        double.parse(textStyleValues2[1]);
                    double originalFontSize3 =
                        double.parse(textStyleValues3[1]);
                    double originalFontSize4 =
                        double.parse(textStyleValues4[1]);
                    double originalFontSize5 =
                        double.parse(textStyleValues5[1]);

                    //----------------------textstyle-------------------------------------//

                    TextStyle textStyle1 =
                        getTextStyle(int.parse(textStyleValues1[6]));
                    TextStyle textStyle2 =
                        getTextStyle(int.parse(textStyleValues2[6]));
                    TextStyle textStyle3 =
                        getTextStyle(int.parse(textStyleValues3[6]));
                    TextStyle textStyle4 =
                        getTextStyle(int.parse(textStyleValues4[6]));
                    TextStyle textStyle5 =
                        getTextStyle(int.parse(textStyleValues5[6]));

                    //------------------------calculation logic-------------------------------//
                    double heightScalingFactor = 262 / 1500;
                    double widthScalingFactor = 175 / 1000;

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
                    double scaledFontSize1 =
                        originalFontSize1 * heightScalingFactor;
                    double scaledFontSize2 =
                        originalFontSize2 * heightScalingFactor;
                    double scaledFontSize3 =
                        originalFontSize3 * heightScalingFactor;
                    double scaledFontSize4 =
                        originalFontSize4 * heightScalingFactor;
                    double scaledFontSize5 =
                        originalFontSize5 * heightScalingFactor;

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Color.fromRGBO(194, 197, 196, 1),
                              width: 0.7),
                          right: BorderSide(
                              color: Color.fromRGBO(194, 197, 196, 1),
                              width: 0.7),
                          bottom: BorderSide(
                              color: Color.fromRGBO(194, 197, 196, 1),
                              width: 0.7),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () async {
                             
                              Navigator.push(
                                context,
                                MaterialPageRoute<Map<String, String>>(
                                  builder: (BuildContext context) =>
                                      ProductScreen(
                                    cardTemplate: limittedToTwenty[index],
                                  ),
                                ),
                              );
                             
                            },
                            child: SizedBox(
                              height: 262,
                              width: 165,
                              child: FutureBuilder(
                                future: precacheImage(
                                  CachedNetworkImageProvider(
                                    '${limittedToTwenty[index]['imageUrl']}',
                                  ),
                                  context,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Stack(
                                      fit: StackFit.passthrough,
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 2 / 3,
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                '${limittedToTwenty[index]['imageUrl']}',
                                            fit: BoxFit.contain,
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error_outline,
                                              color:
                                                  Color.fromRGBO(0, 118, 99, 1),
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
                                          top: 3,
                                          right: 3,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (favIndices
                                                    .contains(index)) {
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
                                                  color: const Color.fromRGBO(
                                                      0, 118, 99, 1),
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: scaledTop1,
                                          left: scaledLeft1,
                                          width: 175,
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
                                                decoration:
                                                    textStyle1.decoration,
                                                fontWeight:
                                                    textStyle1.fontWeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: scaledTop2,
                                          left: scaledLeft2,
                                          width: 175,
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
                                                decoration:
                                                    textStyle2.decoration,
                                                fontWeight:
                                                    textStyle2.fontWeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: scaledTop3,
                                          left: scaledLeft3,
                                          width: 175,
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
                                                decoration:
                                                    textStyle3.decoration,
                                                fontWeight:
                                                    textStyle3.fontWeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: scaledTop4,
                                          left: scaledLeft4,
                                          width: 175,
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
                                                decoration:
                                                    textStyle4.decoration,
                                                fontWeight:
                                                    textStyle4.fontWeight,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: scaledTop5,
                                          left: scaledLeft5,
                                          width: 175,
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
                                                decoration:
                                                    textStyle5.decoration,
                                                fontWeight:
                                                    textStyle5.fontWeight,
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

                          const SizedBox(
                            height: 15,
                          ),
                          //-------------------------------------------price--------------------------------------//
                          SizedBox(
                            width: 150,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Text(
                                        limittedToTwenty[index]['tags'] ==
                                                'normal'
                                            ? '₹340'
                                            : limittedToTwenty[index]['tags'] ==
                                                    'premium'
                                                ? '₹440'
                                                : limittedToTwenty[index]
                                                            ['tags'] ==
                                                        'royal'
                                                    ? '₹540'
                                                    : '640',
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(147, 146, 146, 1),
                                          fontSize: 14,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w300,
                                          height: 0.09,
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
                                Text(
                                  limittedToTwenty[index]['tags'] == 'normal'
                                      ? '₹299'
                                      : limittedToTwenty[index]['tags'] ==
                                              'premium'
                                          ? '₹399'
                                          : limittedToTwenty[index]['tags'] ==
                                                  'royal'
                                              ? '₹499'
                                              : '600',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(23, 22, 22, 1),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0.09,
                                  ),
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
                                      '30% OFF',
                                      style: TextStyle(
                                        color: Color.fromRGBO(198, 88, 53, 1),
                                        fontSize: 10,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                        height: 0.12,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),

              //----------------------------page indicator---------------------------//

              if (limittedToTwenty.isNotEmpty)
                if (isLastPage != true)
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 30, left: 20, right: 20, top: 20),
                    width: size.width,
                    child: GestureDetector(
                      onTap: () {
                        pageforword();
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
                  )
            ],
          ),
        ),
      ),
    );
  }
}
