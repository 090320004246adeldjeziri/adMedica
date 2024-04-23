import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical/auth/login.dart';
import 'package:medical/navigationMenu.dart';
import 'package:medical/widgets/auth_widget/fieldtext.dart';

import '../client/choosepage.dart';
import '../controller/SignUpController.dart';
import '../widgets/auth_widget/passField.dart';

class SignUpPage extends StatelessWidget {
 String role;
  SignUpPage({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(226, 239, 247, 1),
        title: Text(
          "Sign Up",
          style: GoogleFonts.lexend(
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () =>
              Get.to(ChooseRolePage()), // Go back to previous screen
          icon: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: const Icon(
              CupertinoIcons.back,
              color: Colors.green,
              size: 30,
            ),
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
                "Create Account !",
                style: GoogleFonts.lexend(fontSize: 33),
              ),
              Text(
                "Register To Get Started",
                style: GoogleFonts.lexend(fontSize: 20, color: Colors.green),
              ),
              const SizedBox(height: 20),
              MyTextField(
                textEditingController: signUpController.name,
                serviceType: TextInputType.name,
                ButtonName: "First Name", // Changed to fieldName
                icon: Icon(Icons.person),
              ),
              const SizedBox(height: 15),
              MyTextField(
                serviceType: TextInputType.name,
                textEditingController: signUpController.surname,
                ButtonName: "Last Name", // Changed to fieldName
                icon: Icon(Icons.people),
              ),
              SizedBox(height: 15),
              MyTextField(
                serviceType: TextInputType.emailAddress,
                textEditingController: signUpController.email,
                ButtonName: "Address Mail", // Changed to fieldName
                icon: Icon(Icons.mail),
              ),
              SizedBox(height: 15),
              MyTextField(
                serviceType: TextInputType.phone,
                textEditingController: signUpController.phone,
                ButtonName: "Phone Number", // Changed to fieldName
                icon: Icon(Icons.phone),
              ),
              const SizedBox(height: 15),
              MyPasswordField(
                serviceType: TextInputType.visiblePassword,
                textEditingController: signUpController.password,
                ButtonName: "Password", // Changed to fieldName
                icon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 15),
              MyPasswordField(
                                serviceType: TextInputType.visiblePassword,

                textEditingController: signUpController.confirmpassword,
                ButtonName: "Confirm Password", // Changed to fieldName
                icon: const Icon(Icons.lock),
              ),
              const SizedBox(height: 10),
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.green,
                      value: signUpController.agreementChecked.value,
                      onChanged: (value) {
                        signUpController.toggleAgreement(value ?? true);
                      },
                    ),
                    Flexible(
                      child: Text.rich(TextSpan(
                          text: "By registering, you are agreeing with our ",
                          style: TextStyle(color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Terms of Use",
                              style: GoogleFonts.podkova(color: Colors.green),
                            ),
                            TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: GoogleFonts.podkova(color: Colors.green),
                            )
                          ])),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    signUpController.onSignUp();
                    // Don't navigate to login page immediately after sign up
                    // Get.to(LoginPage());
                  },
                  child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(LoginPage()); // Navigate to login page
                },
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an Account ?",
                      style:
                          GoogleFonts.inter(color: Colors.black, fontSize: 14),
                      children: <TextSpan>[
                        TextSpan(
                          text: " Log in ",
                          style: GoogleFonts.inter(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
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
