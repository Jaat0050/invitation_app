import 'package:Celebrare/app/bottom_nav.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_core/firebase_core.dart';
 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: prefer_typing_uninitialized_variables
var box;
// ignore: prefer_typing_uninitialized_variables
var box1;
// ignore: prefer_typing_uninitialized_variables
// var box2;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    // await Firebase.initializeApp();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCDxKDwu7q_PV7n1JWghRt_dOPxB8TRcds",
        authDomain: "celebrare-b43da.firebaseapp.com",
        databaseURL: "https://celebrare-b43da.firebaseio.com",
        projectId: "celebrare-b43da",
        storageBucket: "celebrare-b43da.appspot.com",
        messagingSenderId: "460151234667",
        appId: "1:460151234667:android:47c5288cedf543ded0112e",
        // measurementId: "G-PW5NKP1DL3",
      ),
    );
    // if (Platform.isAndroid) WebView.platform = AndroidWebView();

    await Hive.initFlutter();

    box = await Hive.openBox<List<Map<String, dynamic>>>('invitationsBox');

    box1 =
        await Hive.openBox<List<Map<String, dynamic>>>('invitationsVideoBox');
    // box2 = await Hive.openBox<List<dynamic>>('video_controllers');
  } catch (e) {
    
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Celebrare',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(235, 93, 28, 1),
            ),
            useMaterial3: true,
          ),
          home: AnimatedSplashScreen(
            splash: 'assets/splash_logo.webp',
            centered: true,
            splashIconSize: 120,
            nextScreen: Scaffold(
              body: DoubleBackToCloseApp(
                // snackBar: const SnackBar(content: Text('double tap to exit app')),
                snackBar: SnackBar(
                  backgroundColor: Colors.white,
                  shape: ShapeBorder.lerp(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(2.0), // Starting shape
                    ),
                    const StadiumBorder(), // Ending shape
                    0.2,
                  )!,
                  width: 200,
                  behavior: SnackBarBehavior.floating,
                  content: const Text(
                    'double tap to exit app',
                    style: TextStyle(
                      color: Color.fromRGBO(60, 138, 117, 1),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  duration: const Duration(seconds: 1),
                ),
                child: BottomNav(initialIndex: 0),
              ),
            ),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
