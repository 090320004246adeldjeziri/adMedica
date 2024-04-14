import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 41,
          width: 350,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(15.0), // Adjust the radius as needed
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 7,
              ),
              Icon(
                size: 20,
                Icons.search,
                color: Colors.black.withOpacity(0.7),
              ),
              const SizedBox(
                  width: 15.0), // Adjust the spacing between icon and text
              Expanded(
                  child: TextField(
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Search Product",
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  border: InputBorder.none,
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
