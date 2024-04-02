import 'package:flutter/material.dart';
import 'News.dart';
// Assuming the NewsItem class is defined in news_item.dart

class item extends StatelessWidget {
  final List<CabItem> newsItemList;


  item({required this.newsItemList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: Column(
              children: [
                Container(
                  height: 100.0,
                  width: 140.0, // Using imgUrl from NewsItem
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Image.network(
                    products[index].imgUrl[0],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(newsItemList[index].place),
              ],
            ),
          );
        },
      ),
    );
  }
}
