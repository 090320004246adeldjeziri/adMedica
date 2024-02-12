// Define the News class
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class News {
  final String image;

  News({required this.image});
}

class ChangePictureDemo extends StatefulWidget {
  @override
  _ChangePictureDemoState createState() => _ChangePictureDemoState();
}

class _ChangePictureDemoState extends State<ChangePictureDemo> {
  // List of News objects
  List<News> newsList = [
    News(
        image:
            'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
    News(
        image:
            'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80'),
    News(
        image:
            'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'),
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start the timer to change picture every 2 seconds
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % newsList.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          options: CarouselOptions(
            aspectRatio: MediaQuery.of(context).size.width / 180,
            enlargeCenterPage: false,
            viewportFraction: 1,
            autoPlay: true, // Enable auto play
            autoPlayInterval:
                const Duration(seconds: 5), // Set auto play interval
            autoPlayAnimationDuration:
                const Duration(milliseconds: 1600), // Set transition duration
            enableInfiniteScroll: true, // Enable infinite scroll
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
          itemCount: newsList.length,
          itemBuilder: (context, index, realIdx) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      newsList[index].image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  const Positioned(
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
                  const Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      'Bottom-Left Widget',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 60,
                      height: 35,
                      alignment: Alignment.center,

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            12.0), // Adjust the radius as needed
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2),
                        child: Text(
                          
                          '90 % ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: newsList.map((news) {
              int index = newsList.indexOf(news);
              return Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      currentIndex == index ? Colors.blueAccent : Colors.grey,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
