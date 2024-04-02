import 'package:flutter/material.dart';
import 'package:medical/News.dart';

import 'FavoriteManager.dart';
 // Import the FavoritesManager class

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Favorites'),
        ),
        body: ListView.builder(
          itemCount:5,// FavoritesManager.favorites.length,
          itemBuilder: (context, index) {
           // final newsItem = FavoritesManager.favorites[index];
            return ListTile(
              title: Text("newsItem.title"),
              subtitle: Text("newsItem.seller"),
              trailing: IconButton(
                icon: Icon(Icons.remove_circle),
                onPressed: () {
                  // FavoritesManager.removeFromFavorites(newsItem);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Text('Item removed from favorites.'),
                  //));
                },
              ),
              onTap: () {
                // Navigate to the detail page of the item if needed
              },
            );
          },
        ),
      ),
    );
  }
}
