import 'package:flutter/material.dart';
import 'package:medical/News.dart';

class FavoritesManager {
 
  static List<CabItem> favorits = [];

  static void addToFavorites(CabItem newsItem) {
    if (!favorits.contains(newsItem)) {
      favorits.add(newsItem);
    }
  }

  static void removeFromFavorites(CabItem newsItem) {
    favorits.remove(newsItem);
  }

  static bool isFavorite(CabItem newsItem) {
    return favorits.contains(newsItem);
  }
  
}
