import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kronos/flutter_kronos.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vsm/main.dart';
import 'package:vsm/widgets/home.dart';

class CircularTimer extends StatefulWidget {
  const CircularTimer({super.key});

  @override
  State<CircularTimer> createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer> {
  RxInt seconds = 0.obs;
  RxInt minutes = 0.obs;

  @override
  void initState() {
    super.initState();
    final DocumentReference global =
        FirebaseFirestore.instance.collection(globalRef).doc('globals');
    global.get().then((value) {
      final String time = value.get('start_time');
      print(time);
      Timer.periodic(Duration(seconds: 1), (timer) async {
        final DateTime startTime = DateTime.parse(time);
        final DateTime now = await FlutterKronos.getDateTime as DateTime;
        final Duration difference = now.difference(startTime);
        if (!difference.isNegative) {
          // print('here');
          if (difference.inMinutes >= 5) {
            //call controller.forward in home.dart using homeKey
            // homeKey.currentState.widget.f
            // homeKey.currentState.widget.controller.forward();
            // homeKey.currentState?.forward();
            //  await Future.delayed(Duration(seconds: 10), () {});
            //homeKey.currentState?.controller.forward();
            homeKey.currentState?.forward();
            timer.cancel();
            seconds.value = 0;
            minutes.value = 0;
          } else {
            seconds.value = difference.inSeconds % 60;
            minutes.value = difference.inMinutes;
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 30,
      child: Obx(() {
        return Text(
          '${minutes.value.toString().padLeft(2, '0')}:${seconds.value.toString().padLeft(2, '0')}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        );
      }),
      //TODO: Add a timer here
      //TODO: At time 0, this widget should be replaced with SpinLogo Widget
    );
  }
}

class SpinLogo extends StatefulWidget {
  const SpinLogo({super.key});

  @override
  State<SpinLogo> createState() => _SpinLogoState();
}

class _SpinLogoState extends State<SpinLogo> with TickerProviderStateMixin {
  late AnimationController _spinController;
  late Animation<double> _spinAnimation;
  // late AnimationController _glowController;
  // late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    // _glowController =
    //     AnimationController(vsync: this, duration: Duration(seconds: 2));
    _spinAnimation = Tween<double>(begin: 0, end: 1).animate(_spinController)
      ..addListener(() {
        setState(() {});
      });

    // _glowAnimation = Tween(begin: 2.0, end: 15.0).animate(_glowController)
    //   ..addListener(() {
    //     setState(() {});
    //   });
    _spinController.repeat();
    // _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _spinController.dispose();
    // _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _spinAnimation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _spinAnimation.value * 2 * 3.14,
            child: Container(
              height: 240,
              width: 240,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                // boxShadow: [
                //   BoxShadow(
                //       blurRadius: _glowAnimation.value * 10,
                //       color: Color(0xFF00aaac),
                //       spreadRadius: _glowAnimation.value )
                // ],
              ),
              child: Image.asset(
                'assets/vsm_logo.png',
                fit: BoxFit.cover,
                scale: 0.1,
              ),
            ),
          );
        });
  }
}
