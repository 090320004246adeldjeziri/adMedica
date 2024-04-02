import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'News.dart';

class ChangePictureDemo extends StatefulWidget {
  @override
  _ChangePictureDemoState createState() => _ChangePictureDemoState();
}

class _ChangePictureDemoState extends State<ChangePictureDemo> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildCarouselSlider() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        aspectRatio: MediaQuery.of(context).size.width / 180,
        enlargeCenterPage: false,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 1200),
        enableInfiniteScroll: true,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      itemCount: products.length,
      itemBuilder: (context, index, realIdx) {
        return _buildSliderItem(index);
      },
    );
  }

  Widget _buildSliderItem(int index) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              products[index].imgUrl[0],
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Text(
              'Top news',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
         
          // Center(
          //   child: Container(
          //     width: 60,
          //     height: 35,
          //     alignment: Alignment.center,
          //     decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(12.0),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.all(2),
          //       child: Text(
          //         '90 % ',
          //         style: TextStyle(
          //           color: Colors.red,
          //           fontSize: 20,
          //           fontWeight: FontWeight.w800,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    return SizedBox(
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: products.map((news) {
          int index = products.indexOf(news);
          return Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == index ? Colors.blueAccent : Colors.grey,
            ),
          );
        }).toList(),
      ),
    );
  }
}
