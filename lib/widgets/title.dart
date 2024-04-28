import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

class title extends StatelessWidget {
  final String titleG ;
  final String titleL ;
  const title(this.titleG,this.titleL,
    {super.key});
    
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titleG,
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.normal)),
          Text(titleL,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.green,
              ))
        ],
      ),
    );
  }
}
