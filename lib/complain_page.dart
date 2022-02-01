import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_screen/profile.dart';
class Complain extends StatefulWidget {

   Complain({ Key key }) : super(key: key);

  @override
  _ComplainState createState() => _ComplainState();
}

class _ComplainState extends State<Complain> {
    TextEditingController data1 = new TextEditingController();
  TextEditingController data2 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        backgroundColor: Colors.red,
        title: Text("Raise Your Complain"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 280,
                width: 280,
                child: Image.asset("assets/complain.jpg"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      controller: data1,
              decoration: InputDecoration(
                hintText: 'Your Name',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: 
                BorderRadius.all(Radius.circular(10)))
              ),
            ),
                  ),
            TextFormField(
            controller: data2,
              minLines: 2,
              maxLines: 10,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Write here!',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: 
                BorderRadius.all(Radius.circular(10)))
              ),
            )
                ],
              ),
            ),
            Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                    child: Container(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: (){
                    Map <String,dynamic> data =
                     {"Name":data1.text,"Complain":data2.text};
            FirebaseFirestore.instance.collection('complain').add(data);
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>Profile()));
                    confimation(context);
                        },
                        color: Colors.red,
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
            
          ],
        ),
      ),
    );
    
  }
  
  confimation(BuildContext context) {
               Get.snackbar("Submitted", "Complain Placed",
            snackPosition: SnackPosition.TOP,
            duration: Duration(seconds: 5));
  }
}