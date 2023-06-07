// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vsm/screens/leaderboard.dart';
import 'package:vsm/screens/power_cards_screen.dart';
import 'package:vsm/screens/user_screen.dart';
import 'package:vsm/widgets/circulartime.dart';
import 'package:vsm/widgets/home_screen_item.dart';
import 'package:vsm/widgets/tickertape.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

enum activeButton { Buy, Sell, None }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

const String userRef = "users_col_v2";
const String globalRef = "globals_col_v2";
const String stocksRef = "stocks_col_v2";

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  static const String teamid = "123"; //get this from local storage
  final DocumentReference global =
      FirebaseFirestore.instance.collection(globalRef).doc('globals');
  final DocumentReference user =
      FirebaseFirestore.instance.collection(userRef).doc(teamid);
  late int curr_round;
  final List<Company> companies = [];

  late AnimationController controller;
  late Animation<double> animation;
  final RxBool _expanded = false.obs;
  final RxBool _circularReveal = false.obs;
  final PageController _pageController = PageController();
  final RxBool _isFetching = true.obs;

  Future<void> forward() async {
    // print('calling forward');
    // _expanded.value = true;
    // await Future.delayed(Duration(milliseconds: 500));
    // controller.forward();
    //TODO: commented out for now, uncomment in release
  }

  // void reverse() {
  //   controller.reverse();
  // }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInSine);
    //get user details, global details and stocks details and until this, show loading indication
    user.get().then((value) {
      Map user = value.data() as Map;
      // print(user["balance"]);
      // write user balance to get storage
      final box = GetStorage();
      box.write('balance', user["balance"]);
    });
    global.get().then((value) {
      Map global = value.data() as Map;
      // print(global);
      // print(value.data());
      //store start time and curr_round in get storage
      final box = GetStorage();
      box.write('start_time', global["start_time"]);
      box.write('curr_round', global["curr_round"]);
      curr_round = global["curr_round"];
      // print(box.read('start_time'));
      // print(box.read('curr_round'));
      final CollectionReference stocks = FirebaseFirestore.instance
          .collection(stocksRef)
          .doc("$curr_round")
          .collection("stocks");
      stocks.get().then((value) {
        for (var element in value.docs) {
          // print(element.id); // this is the name of the stock
          // print(element.data()); // this is the price of the stock
          Map stkData = element.data() as Map;
          //print(stkData["stk_price"]);
          companies.add(Company(name: element.id, price: stkData["stk_price"]));
        }
        _isFetching.value = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF03045E),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: kToolbarHeight + ((Platform.isIOS) ? 50 : 25),
            ),
            child: PageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              children: [
                Obx(() {
                  return (!_isFetching.value)
                      ? ListView.builder(
                          // padding: EdgeInsets.zero,
                          padding: EdgeInsets.only(
                            bottom: 60,
                            //  top: 20
                          ),
                          physics: BouncingScrollPhysics(),
                          itemCount: companies.length,
                          itemBuilder: (context, index) => Center(
                            child: CardForStock(
                              companies[index].name,
                              companies[index].price.toDouble(),
                              // dummyData[index]['quantity'] as double
                              0.0,
                            ),
                          ),
                        )
                      : Center(child: CircularProgressIndicator());
                }),
                PowerCardsScreen(),
                LeaderBoard(),
                UserScreen(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CustomClipperWithCircularHole(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 14.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.globe),
                        onPressed: () {
                          _pageController.animateToPage(0,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.diamond),
                        onPressed: () {
                          _pageController.animateToPage(1,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.chartSimple),
                        onPressed: () {
                          _pageController.animateToPage(2,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                      ),
                      IconButton(
                        icon: FaIcon(FontAwesomeIcons.user),
                        onPressed: () {
                          _pageController.animateToPage(3,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Obx(() {
              return (!_isFetching.value)
                  ? Container(
                      height: kToolbarHeight + ((Platform.isIOS) ? 50 : 25),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SafeArea(
                          bottom: false,
                          child: TickerTape(companies: companies)),
                    )
                  : const SizedBox();
            }),
          ),
          CircularRevealAnimation(
            animation: animation,
            child: Obx(() => (_expanded.value)
                ? Container(
                    color: Colors.white,
                  )
                : SizedBox()),
          ),
          Obx(() {
            return AnimatedAlign(
              duration: const Duration(milliseconds: 500),
              alignment: (!_expanded.value)
                  ? Alignment.bottomCenter
                  : Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: (!_expanded.value) ? 44 : 0),
                child: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () async {
                    if (!_expanded.value) {
                      _expanded.value = true;
                      await Future.delayed(const Duration(milliseconds: 500));
                      // _circularReveal.value = true;
                      controller.forward();
                    } else {
                      _expanded.value = false;
                      // _circularReveal.value = false;
                      controller.reverse();
                    }
                  },
                  child: AnimatedSize(
                    clipBehavior: Clip.none,
                    duration: Duration(milliseconds: 500),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: !_expanded.value
                          ? const CircularTimer()
                          : const SpinLogo(),
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

//custom clipper that creates a notch in the center of the bottom app bar
class CustomClipperWithCircularHole extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const holeRadius = 34.0;
    final holeCenter = Offset(size.width / 2, -8);
    //print(holeCenter);
    final path = Path();
    // ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
    // ..addOval(Rect.fromCircle(center: holeCenter, radius: holeRadius))
    // ..fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    path.addOval(Rect.fromCircle(center: holeCenter, radius: holeRadius));
    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
