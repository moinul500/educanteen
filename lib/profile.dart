
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_signup_screen/cartscreen.dart';
import 'package:login_signup_screen/complain_page.dart';
import 'package:login_signup_screen/faq.dart';
import 'package:login_signup_screen/food_products.dart';
import 'package:login_signup_screen/login.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
   TabController tabController;
 bool kk=false;
final FirebaseAuth _auth=FirebaseAuth.instance;


   User user;
  bool isloggedin= false;
  checkAuthetificaltion() async
 {
   _auth.authStateChanges().listen((user)
    {
  if(user==null)
  {
     Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage()));
  }
    }
   );
 }
 getUser() async
 {
   User firebaseUser=  _auth.currentUser;
  await firebaseUser?.reload();
   firebaseUser=  _auth.currentUser;
   if(firebaseUser!=null)
  {
    setState(() {
     this.user=firebaseUser;
     this.isloggedin=true;
    });
  }
 }
 signOut()async
 {
   Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
  //  _auth.signOut();
 }

@override
    void initState()
    {
    
      this.checkAuthetificaltion();
      this.getUser();
      super.initState();
  
    tabController = TabController(vsync:  this, length: 3);
    }
  @override
  Widget build(BuildContext context) {
    var dname =user.displayName; 
  final Stream<QuerySnapshot> _usersStream =
   FirebaseFirestore.instance.collection('orders').where('Name',isEqualTo: dname).snapshots(); ///database connection order
    return Scaffold(

//////////////////////////////////////////////////drawer/////////////////////////////////////////////////////////////////////////
       drawer: Drawer(
          child: Container(
            color: Colors.red.shade300,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white54,
                        radius: 43,
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.red,
                          backgroundImage: AssetImage("assets/profile.jpg")
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Welcome $dname'),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            height: 30,
                            child: MaterialButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                              },
                              child: Text('Logout'),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(15),
                                  side: BorderSide(
                                    width: 2,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: 350,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                  
          ListTile(leading: 
                        const Icon( Icons.home_outlined), title: Text('HOME')),
                     
                      ListTile(
                            onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Complain()));
                        },
                        leading: const Icon( Icons.copy_outlined), title: Text('Raise a Complaint')),
                      ListTile(
                        onTap: (){
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>FaqPage()));
                        },
                        leading: const Icon (Icons.format_quote_outlined), title: Text('FAQs')),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                  
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Contact Support',style:TextStyle(color: Colors.black,fontSize: 18, fontWeight: FontWeight.bold) ,),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text('Call Us :'),
                          SizedBox(
                            width: 10,
                            height: 20,
                          ),
                          Text('+880123456789',style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold) ,),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Text('Mail Us : '),
                            SizedBox(
                              width: 10,
                            ),
                            Text('admin@gmail.com',style:TextStyle(color: Colors.black, fontWeight: FontWeight.bold) ,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                                        )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
////////////////////////////////////////////////homepage//////////////////////////////////////////////////
      appBar: AppBar(
      
        backgroundColor: Colors.red,
      
        // automaticallyImplyLeading: false,
        title: Text("Order Your Food"),
        
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
     Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen(dname: dname,)));
              },
              child: Icon(FontAwesomeIcons.shoppingBag)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },
              
              child: Icon(FontAwesomeIcons.signOutAlt)),
          ),
        ],
      ),
      body: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(75.0)),
                  color: Color(0xFFFD7465)),
            ),
            Container(
              height: 160.0,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(65.0)),
                  color: Color(0xFFFE8A7E)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 15.0),
              child: Text(
                'Welcome $dname',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 90.0, left: 15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 23),
                    child: Text(
                      'Choose your favorite Food!',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

  StreamBuilder<QuerySnapshot>( 
  ////////////////////////////////////////////////// fetching Time //////////////////////////////////////////
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('');
        }
        return Container(
          width: double.maxFinite,
          height: 100,
         
          child: ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.only(top: 46,left: 15),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Text("Collect your food within:",style: TextStyle(color: Colors.white,
                      fontSize: 20, fontFamily: 'Montserrat',fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(data['Time'],style: TextStyle(color: Colors.white,fontSize: 20,
                    fontFamily: 'Montserrat',fontWeight: FontWeight.bold),),
                  ],
                ),
              )
              ;
            }).toList()

          ),
        );
        
        }
        ),
        ],
            ),

          ],
        ),
////////////////////////////////////////////////// Snacks ///////////////////////////////////////////////
        TabBar(
          controller:  tabController,
          indicatorColor: Color(0xFFFE8A7E),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 4.0,
          isScrollable: true,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          tabs: [
            Tab(
                  child: Text(
                    'Snacks',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Lunch',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                                Tab(
                  child: Text(
                    'Drinks',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                    ),
                  ),
                ),
          ],
        ),
         Container(
          height: MediaQuery.of(context).size.height - 400.0,
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
               FoodProduts(dname: dname,),
                FoodProduts2(dname: dname,),
                FoodProduts3(dname: dname,)
            ],
          ),
        ),

       
      ],
        )
    );
  }
}
