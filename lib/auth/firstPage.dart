import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:medical/auth/sign.dart';
import 'package:medical/client/choosepage.dart';

import 'login.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(child:
      
       Padding(
         padding: const EdgeInsets.all(20.0),
         child: Column(
          children: [
            Image.asset(
                  'assets/images/dawa.png',
            ),
            const SizedBox(
              height: 30,
              
            ),
     SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      // Perform login action
                      Get.to(ChooseRolePage());
                
                    },
                    child: Text(
                      "Sign Up",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                  SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () {
                      // Perform login action
                       Get.to(LoginPage());
                
                    },
                    child: Text(
                      "Sign in",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

          ],
      ),
       )),


    );
  }
}