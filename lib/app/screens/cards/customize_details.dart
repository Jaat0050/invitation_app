import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class CustomizeDetails extends StatefulWidget {
  String groom;
  String bride;

  CustomizeDetails({required this.bride, required this.groom, super.key});

  @override
  State<CustomizeDetails> createState() => _CustomizeDetailsState();
}

class _CustomizeDetailsState extends State<CustomizeDetails> {
  final TextEditingController _brideController = TextEditingController();
  final TextEditingController _groomController = TextEditingController();
  List<String> languageNames = ['English', 'हिन्दी', 'ಕನ್ನಡ', 'मराठी', 'বাংলা'];
  String selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _brideController.text = widget.bride;
    _groomController.text = widget.groom;
  }

  @override
  void dispose() {
    super.dispose();
    _brideController.dispose();
    _groomController.dispose();
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
          'Customize Details',
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
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            width: 25,
            height: 25,
            child: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: size.height,
          width: size.width,
          color: Colors.white,
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  //----------------------language---------------------//
                  //
                  const Text(
                    'Card Languages: ',
                    style: TextStyle(
                      color: Color.fromRGBO(23, 22, 22, 1),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0.07,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //--------------------------------gridview---------------------//
                  //
                  SizedBox(
                    width: size.width,
                    height: 180,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 40,
                      ),
                      itemCount: languageNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        // bool isSelected =
                        //     languageNames[index] == selectedLanguage;

                        return GestureDetector(
                          onTap: () {
                            // setState(() {
                            //   selectedLanguage = languageNames[index];
                            // });
                          },
                          child: Container(
                            width: 134,
                            height: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 9),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 1,
                                  // color: isSelected
                                  //     ? Colors.transparent
                                  //     : const Color.fromRGBO(0, 118, 99, 1),
                                  color: index == 0
                                      ? const Color.fromRGBO(0, 118, 99, 1)
                                      : Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              // color: isSelected
                              //     ? const Color.fromRGBO(60, 138, 117, 1)
                              //     : Colors.white,
                              color: index == 0
                                  ? const Color.fromRGBO(0, 118, 99, 1)
                                  : Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  languageNames[index],
                                  style: TextStyle(
                                    // color: isSelected
                                    //     ? Colors.white
                                    //     : const Color.fromRGBO(
                                    //         144, 144, 144, 1),
                                    color: index == 0
                                        ? Colors.white
                                        : Colors.grey[400],
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    height: 0.07,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  //----------------------------enter details-----------------------//
                  const Text(
                    'Enter details and preview ',
                    style: TextStyle(
                      color: Color.fromRGBO(23, 22, 22, 1),
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0.07,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //----------------------------bride textfield-----------------------//
                  Container(
                    width: size.width,
                    height: 50,
                    padding: const EdgeInsets.only(left: 28),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color.fromRGBO(0, 118, 99, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 22,
                          height: 27.28,
                          child: Image(
                            image: AssetImage('assets/bride.png'),
                          ),
                        ),
                        const SizedBox(width: 28),
                        SizedBox(
                          width: size.width * 0.55,
                          child: TextField(
                            controller: _brideController,
                            cursorColor: const Color.fromRGBO(0, 118, 99, 1),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write Bride Name',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(144, 144, 144, 1),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //-------------------------------wed-------------------------//
                  SizedBox(
                    width: size.width,
                    child: const Text(
                      'Weds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(0, 118, 99, 1),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 0.09,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //----------------------------groom textfield-----------------------//
                  Container(
                    width: size.width,
                    height: 50,
                    padding: const EdgeInsets.only(left: 28),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 1,
                          color: Color.fromRGBO(0, 118, 99, 1),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 22,
                          height: 27.28,
                          child: Image(
                            image: AssetImage('assets/groom.png'),
                          ),
                        ),
                        const SizedBox(width: 28),
                        SizedBox(
                          width: size.width * 0.55,
                          child: TextField(
                            controller: _groomController,
                            cursorColor: const Color.fromRGBO(0, 118, 99, 1),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write Groom Name',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(144, 144, 144, 1),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                height: 0.08,
                              ),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 100,
                  ),
                  //-----------------------------button---------------------//
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(60, 138, 117, 1),
                      disabledBackgroundColor:
                          const Color.fromRGBO(60, 138, 117, 1),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_brideController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Enter Bride name",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromRGBO(60, 138, 117, 1),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else if (_groomController.text.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Enter Groom name",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromRGBO(60, 138, 117, 1),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            } else {
                              Map<String, String> data = {
                                'brideName': _brideController.text.toString(),
                                'groomName': _groomController.text.toString(),
                                'cardLanguage': selectedLanguage,
                              };
                              Navigator.pop(context, data);
                            }
                          },
                    child: isLoading
                        ? const Align(
                            alignment: Alignment.center,
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 20,
                            ),
                          )
                        : const Text(
                            'Submit and Preview',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
}
