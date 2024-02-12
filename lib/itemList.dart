import 'package:flutter/material.dart';

class Item {
  String title;
  String imageUrl;

  Item({
    required this.title,
    required this.imageUrl,
  });
}

class item extends StatelessWidget {
  final List<Item> itemList = [
    Item(title: 'Cleaning', imageUrl: 'assets/images/clean.jpg'),
    Item(title: 'Makiage', imageUrl: 'assets/images/makeup.jpg'),
    Item(title: 'Mother & Babe', imageUrl: 'assets/images/mam&babe.jpg'),
    Item(title: 'Vitamine', imageUrl: 'assets/images/vitamine.jpg'),
    Item(title: 'Women', imageUrl: 'assets/images/womencare.jpg'),
    // Add more items to the list as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 100.0,
                  width: 100.0,
                  child: Image.asset(itemList[index].imageUrl),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(itemList[index].title),
              ],
            ),
          );
        },
      ),
    );
  }
}
