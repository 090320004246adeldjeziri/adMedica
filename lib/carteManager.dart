import 'News.dart';

class CartManager {
  static List<CabItem> cartItems = [];

  static void addToCart(CabItem newsItem) {
    cartItems.add(newsItem);
  }

  static void removeFromCart(CabItem newsItem) {
    cartItems.remove(newsItem);
  }

  static bool isInCart(CabItem newsItem) {
    return cartItems.contains(newsItem);
  }
}
