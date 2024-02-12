import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class appBar extends StatelessWidget {
  const appBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(150),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 35,
                    height: 35,
                    child: CircleAvatar(
                      backgroundColor:
                          Colors.blueAccent.shade400.withOpacity(0.8),
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
                Text("Hi, Adel !",
                    style: GoogleFonts.lexend(
                        fontSize: 13,
                        color: const Color.fromRGBO(16, 130, 96, 1))),
                Text("Good Morning!",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color.fromARGB(150, 76, 75, 1),
                    )),
              ])
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Your Location ",
                          style: GoogleFonts.poppins(
                              fontSize: 10,
                              color: Colors.green,
                              fontStyle: FontStyle.normal),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Ain Témouchent",
                          style: GoogleFonts.poppins(fontSize: 10),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: const [
                          Icon(Icons.map_sharp, color: Colors.green)
                        ],
                      ),
                      Column(
                        children: const [
                          Icon(
                            Icons.notifications,
                            color: Colors.green,
                            semanticLabel: "news!",
                          )
                        ],
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
