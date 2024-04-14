import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class leadingHomePage extends StatelessWidget {
  const leadingHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 38,
                height: 38,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent.shade400.withOpacity(0.8),
                  child: const Icon(
                    size: 25,
                    Icons.person_outline_outlined,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 18,
            ),
            Text("Hi, Adel !",
                style: GoogleFonts.lexend(
                    fontSize: 14, color: const Color.fromRGBO(16, 130, 96, 1))),
            Text("Good Morning!",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: const Color.fromARGB(150, 76, 75, 1),
                )),
          ])
        ]);
  }
}
