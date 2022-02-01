import 'dart:ui';
import 'package:flutter/material.dart';


class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red[100],
      body: SafeArea(
        // safearea adjust the screen to acording to devices and do not overlap pre-occupied constraints
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
                "Frequently Asked Question",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey[900],
                  fontSize: 30,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Image.network(
                    "https://image.freepik.com/free-vector/faqs-concept-illustration_114360-5245.jpg"),
              ),
              Column(
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Text(
                    "Are there to-go offers in the canteens?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.deepOrange[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Yes, you can also have your food packaged for take-away in every canteen or fill it yourself into containers or boxes you have brought with you. In addition, salads and desserts are also available as to-go options.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      
                    ),
                  ),
                  Text(
                    "How do I easily find my favourite food ?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.deepOrange[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Our online-menu includes a lot of food options which can help you to choose your favourite food.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "How to Order?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.deepOrange[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Place your order in advance with our EDU Canteen App and pick up your food from the EDU canteen.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "Is there any option for online payment?",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.deepOrange[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "No, our app doesn't have the option for online payment. The customers have to collect their food from the EDU canteen by paying in cash.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
