import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:login_signup_screen/login.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red[100],
      body: SafeArea(
        // safearea adjust the screen to acording to devices and do not overlap pre-occupied objects
        child: Container(
          width: double.infinity,
          // height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            // even space distribution
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Image.asset("assets/home.png"),
              ),
              Column(
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Text(
                    "EDU canteen is here to provide Good Foods. It can provide healthy foods and also be financially viable. You can order favourtite foods and get it at any time you want",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              Container(
                // the login button
                child: MaterialButton(
                  minWidth: double.infinity,
                  elevation: 30,
                  height: 60,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  color: Colors.red,
                  // defining the shape
                  shape: RoundedRectangleBorder(
                  
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
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
