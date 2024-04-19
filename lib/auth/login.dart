import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/auth/sign.dart';
import 'package:medical/navigationMenu.dart';
import 'package:medical/widgets/auth_widget/fieldtext.dart';

import '../controller/LoginController.dart';

class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(226, 239, 247, 1),
        title: Text(
          "Log In",
          style: GoogleFonts.lexend(
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome Back!",
                style: GoogleFonts.lexend(fontSize: 33),
              ),
              Text(
                "Log in to Continue",
                style: GoogleFonts.lexend(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 20),
              MyTextField(
                textEditingController:loginController.email,
                ButtonName: "Email",
                icon: Icon(Icons.mail),
              ),
              const SizedBox(height: 15),
              MyTextField(
                textEditingController: loginController.password,
                ButtonName: "Password",
                icon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // Perform login action
                    loginController.login(
                    );
                  },
                  child: Text(
                    "Log In",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Don't have an Account yet? ",
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Sign Up",
                        style: GoogleFonts.inter(
                          color: Colors.green,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        // Add navigation to signup page
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => SignUpPage());
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
