import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup_screen/login.dart';

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

 FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

String _name,_email,_password;

 signup()async
 {
   if(_formkey.currentState.validate())
   {
     _formkey.currentState.save();
     try{
          UserCredential user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
          if(user!=null)
          {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            await _auth.currentUser.updateDisplayName(_name);
          }
     }
     catch(e){
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupPage()));
             },
           child: Text("OK!"))
         ],
       );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
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
                                 return "Enter your Name";
                              
                              },
                               cursorColor: Colors.black,
                              decoration:  InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                    color: Colors.red,
                                  )),
                                labelText: 'Enter your Name',
                                  labelStyle: TextStyle(color: Colors.black)),
                                  
                                  onSaved: (input) => _name = input,
                             

                         
                            ),
                          ),
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
                  child: Column(
                    children: [
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: signup, ///declared earlier
                        color: Colors.red,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Signup",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                        ),
                        GestureDetector(
                          onTap: () {
              Navigator.push( context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                          child: Text(
                            "Signin",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                    ],
                  ),
                ),
              ),
              

            ],
          ),
        ),
      ),
    );
  }

  
}
