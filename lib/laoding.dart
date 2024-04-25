import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Assurez-vous d'importer ce package si vous l'utilisez pour SpinKitFadingCircle

class LoadingIndicatorUtil {
  static OverlayEntry? overlayEntry;

  static void showLoadingIndicator(BuildContext context,double topPos) {
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * topPos,
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Center(
              child: SpinKitFadingCircle(
                color: Colors.green,
                size: 100.0,
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context)?.insert(overlayEntry!);
    
  }

  static void removeLoadingIndicator() {
    overlayEntry?.remove();
  }
}
