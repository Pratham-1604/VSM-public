import 'package:vsm/firebase_options.dart';
import 'package:vsm/widgets/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kronos/flutter_kronos.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

//waiting_for_game start -> :
//bpc (base percent change): change in stock price
//npc new percent change):
//
//1 *100 = 100
//2 *200 = 400

//check how much us er can sell

//process calc_end -> :

GlobalKey<HomeState> homeKey = GlobalKey();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent, // optional
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      //  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      // print('connected to firebase emulator');
    } catch (e) {
      print("error connecting to firestore emulator: $e");
    }
  }
  FlutterKronos.sync();
  // get time using Kronos(accurate to millisecond)
  // var nowk = await FlutterKronos.getDateTime;
  // print('Kronos: $nowk');
  await GetStorage.init();
  //flow from here should be
  //login? -> home -> waiting_for_game? -> spinlogo
  //                -> trading_ends? -> spinLogo -> price_calc_starts? -> spinLogo -> price_calc_ends-> navigate to leaderboard
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VSM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Home(key: homeKey,),
      themeMode: ThemeMode.dark,
      // home: HomePageLayout(0),
      // routes: {
      //   HomePage.routeName: (context) => HomePage(),
      //   LeaderBoard.routeName: (context) => LeaderBoard(),
      // },
    );
  }
}
