import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TickerTape extends StatefulWidget {
  final List<Company> companies;

  const TickerTape({super.key, required this.companies});

  @override
  _TickerTapeState createState() => _TickerTapeState();
}

class _TickerTapeState extends State<TickerTape>
    // with SingleTickerProviderStateMixin 
    {
  // late AnimationController _animationController;
  // final double _scrollMaxExtent = 0.0;
  // final double _scrollOffset = 0.0;
  // final List<Widget> _children = [
  //   // Text('Twitter\n6.9'),
  //   // Text('Amazon\n69.0'),
  //   // Text('Google\n96.0'),
  //   // Text('Facebook\n50.0'),
  //   // Text('Netflix\n30.0'),
  //   // Text('Hooli\n0.0'),
  //   // Text('Jio\n6.9'),
  // ];

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 5),
    // )
    //   ..addListener(() {
    //     _scrollOffset = _animationController.value * _scrollMaxExtent;
    //     // setState(() {});
    //   })
    //   ..repeat();
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

  //final RxBool isScrolling = true.obs;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: CarouselSlider.builder(
        itemCount: widget.companies.length,
        // items: _children,
        itemBuilder: (context, index, realIdx) {
          return TickerWidget(
              stockname: widget.companies[index].name,
              stockprice: widget.companies[index].price);
        },
        options: CarouselOptions(
          viewportFraction:
              (kDebugMode && Platform.isAndroid)
                  ? 0.9
                  :
              0.2, //to mitigate assertion error on android
          height: 50.0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 2500),
          autoPlayCurve: Curves.easeInToLinear,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 2.0,
          scrollDirection: Axis.horizontal,
          // onPageChanged: (index, reason) {
          //   setState(() {
          //     _scrollOffset = index.toDouble();
          //   });
          // },
        ),
      ),
    );
  }
}

class TickerWidget extends StatelessWidget {
  const TickerWidget(
      {required this.stockname, required this.stockprice, super.key});

  final String stockname;
  final int stockprice;
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            '$stockname\n$stockprice',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

class Company {
  final String name;
  final int price;

  Company({required this.name, required this.price});
}
