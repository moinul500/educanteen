
import 'package:flutter/material.dart';
import 'package:login_signup_screen/adminpage.dart';
import 'package:login_signup_screen/profile.dart';
import 'package:login_signup_screen/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final FirebaseAuth _auth = FirebaseAuth.instance; // interacting with the firebase
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>(); 
  String _email,_password;  
 login() async
 {
   if(_formkey.currentState.validate())
   {
     _formkey.currentState.save();
     try{
     UserCredential user= await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      if(_email=="admin@gmail.com" && _password=="123456")
      {
           Navigator.push(context, MaterialPageRoute(builder:(context)=>Admin()));
      }
      else
      {
          Navigator.push(context, MaterialPageRoute(builder:(context)=>Profile()));
      }
     }
      catch(e)
       {
            showError(e.message);
       }
   }
 }
  showError(String errormessage)
  {
    showDialog(context: context,
     builder:(BuildContext context)
     {
       return AlertDialog(
         title: Text("Error!"),
         content: Text(errormessage),
         actions: [
           TextButton(
             onPressed:(){ 
            
               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
               },
           child: Text("OK!"))
         ],
       );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Expanded( //// responsive

                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Login to your account",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child:Form(
                      key:_formkey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: TextFormField(
                             
                              validator: (input)
                              {
                                 if(input.isEmpty)
                                 return "Enter your Email";
                              
                              },
                               cursorColor: Colors.black,
                              decoration:  InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                    color: Colors.red,
                                  )),
                                labelText: 'Enter your Email (EDU email)',
                                  labelStyle: TextStyle(color: Colors.black)),
                                  
                                  onSaved: (input) => _email = input,
                             

                         
                            ),
                          ),
                        
                          //input
                                                    TextFormField(
                                                     
                                                      validator: (input)
                                                      {
                                                         if(input.length<6)
                                                         return "Password must be atleast 6 characters";
                                                      
                                                      },
                                                       cursorColor: Colors.black,
                                                      decoration:  InputDecoration(
                                                          focusedBorder: OutlineInputBorder(
                                                              borderSide:  BorderSide(
                                                            color: Colors.red,
                                                          )),
                                                        labelText: 'Enter your Pasword (minimum 6 characters)',
                                                          labelStyle: TextStyle(color: Colors.black)),
                                                          obscureText: true,
                                                          onSaved: (input) => _password = input,
                                                    )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: login, /// declared earlier 
                        color: Colors.red,
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => SignupPage()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 100),
                    height: 290,
                    width: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/login2.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}


