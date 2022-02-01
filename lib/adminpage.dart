import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:login_signup_screen/login.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Admin extends StatefulWidget {


  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> with SingleTickerProviderStateMixin {
    TabController tabController;
@override
    void initState()
    {
    
   
      super.initState();
    tabController = TabController(vsync:this, length: 3);
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text("EDU Canteen Admin"),
        centerTitle: true,
        actions: [  
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            children: [
              TabBar(
          controller:  tabController,
          indicatorColor: Color(0xFFFE8A7E),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 4.0,
          isScrollable: true,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          tabs: <Widget>[
                Tab(
                  child: Text(
                    'Orders',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Food Items',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                    ),
                  ),
                ),

                Tab(
                  child: Text(
                    'Complains',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 18.0,
                    ),
                  ),
                ),
               
              ],
        ),
         Expanded(
        
          child: TabBarView(
            controller: tabController,
            children: <Widget>[
                Orders(),
                FoodItems(),
                ComplainDB()
            ],
          ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}
class Orders extends StatefulWidget {
  

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15,left: 15,right: 8),
            child: Column(
              children: [
                Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

      Text("Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Text("Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                   Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                        Text("Time",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ],),
/////////////////////////////////////// fetching order data////////////////////////////////////////////// 
                StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('orders').snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          final data =snapshot.requireData;
                       
                          return   Container(
                            height: double.maxFinite,
                           
                            child: ListView.builder(
                              itemCount:data.size ,itemBuilder:(context,index) {
                              int ttl = data.docs[index]['Total'];
                         var name =data.docs[index]['Name'];
                            
                                   return
                                    Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [

                      
                                      Text(data.docs[index]['Name'],style: TextStyle(fontSize:20 ,),),

/////////////////////////////////////////////// Details//////////////////////////////////////////////////
                   IconButton(onPressed: (){

              showDialog(context: context, builder: (context)=>Dialog(
child: Container(
  color: Colors.blueGrey[50],
  child:   Column(
  
    children: [
      Padding(
  
        padding: const EdgeInsets.all(15.0),
  
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
  
          children: [
  
   Text("Product Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
  
                       Text("Quantity",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
  
                       Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
        ],),
  
      ),
   ////////////////////////////////////// details item fetch/////////////////////////////////
          StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection(name).snapshots(),
  
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  
                                final data =snapshot.requireData; 
                                return Container( height: 670,
  
                                  child: ListView.builder(itemCount:data.size ,itemBuilder: (context,index){
  
                                    int quan = data.docs[index]['qnt'];
  
                                    int totl = data.docs[index]['Tprice'];
  
                                        return Padding(
  
                                          padding: const EdgeInsets.all(15.0),
  
                                          child: Row(
  

                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                         children: [

                                              Text(data.docs[index]['productname'],style: TextStyle(fontSize: 20),),
  
                                            Text('$quan',style: TextStyle(fontSize: 15),),
  
                                              Text('$totl',style: TextStyle(fontSize: 15),),
  
                                          ],),
  
                                        );
  
                                  }),
  
                                );
  
                              } ,
  
                    ),
  
    ],
  
  ),
)));
                  }, icon: Icon(FontAwesomeIcons.utensils)),

                                      Text('$ttl',style: TextStyle(fontSize:15 ,),),
                                      Text(data.docs[index]['Time'],style: TextStyle(fontSize:15 ,),),
/////////////////////////////////////////////// delete button/////////////////////////////////////////////        
                  IconButton(onPressed: () async {

                    snapshot.data.docs[index].reference.delete();
                    Get.snackbar("Order List Updated", "Food Delivered to ${data.docs[index]['Name']}/ Order Cancelled",
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 5)   );
var collection = FirebaseFirestore.instance.collection(name);
var snapshots = await collection.get();
for (var doc in snapshots.docs) {
  await doc.reference.delete();
}
                           
                  }, icon: Icon(FontAwesomeIcons.checkCircle)),
                 
                         ],
                                    ),
                                  )
                                   ;
                                 }),
                          );
                        },
                    
                  ),
              ],
            ),
          ),
        )
;
  }
}

class FoodItems extends StatefulWidget {
  

  @override
  _FoodItemsState createState() => _FoodItemsState();
}

class _FoodItemsState extends State<FoodItems> with SingleTickerProviderStateMixin {
   TabController tabController;
  final CollectionReference collectionReference1 = FirebaseFirestore.instance.collection('products');
  @override
    void initState()
    {
    tabController = TabController(vsync:  this, length: 3);
    }
  @override
  Widget build(BuildContext context) {
   return      SingleChildScrollView(
     child: Column(
       children: [
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
            height: MediaQuery.of(context).size.height - 200.0,
            child: TabBarView(
              controller: tabController,
              children: <Widget>[
        FoodProduts11(),
        FoodProduts22(),
        FoodProduts33()
              ],
            ),
          ),
       ],
     ),
   )
        ;
  }
}
/////////////////////////////////////////// Complain/////////////////////////////////////////////////////
class ComplainDB extends StatelessWidget {
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('complain');
   ComplainDB({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
 
        
        child: Expanded(
            child: StreamBuilder(stream: collectionReference.snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasData){
                return Column(
                  children: snapshot.data.docs.map((e) => Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [
                      ListTile(
                        title: Text(e['Name'],style: TextStyle(fontWeight: FontWeight.bold,
                           fontSize: 20
                           ),),
                           subtitle:  Text(e['Complain'],style: TextStyle(
                           fontSize: 20
                           ),) ,
                      )
                           ],
                  )).toList(),
                );
              }
              return Center(child: CircularProgressIndicator(),);
              },

        )),
      );
  }
}

//////////////////////////////////////////////Snacks////////////////////////////////////////////////////
class FoodProduts11 extends StatefulWidget {
  

var dname;

FoodProduts11({Key key,this.dname}):super(key: key);

  @override
  State<FoodProduts11> createState() => _FoodProduts11State();
}

class _FoodProduts11State extends State<FoodProduts11> {
int count=0;

  @override
  Widget build(BuildContext context) {
    // final CollectionReference q =FirebaseFirestore.instance.collection('cart_total');
    return Padding(
           padding: const EdgeInsets.only(right: 15,left: 15,top: 20),
      child: Expanded(
        child: Column(
          children: [
      Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                    child: Container(
                      child: MaterialButton(
                        minWidth: 50,
                        height: 40,
                        onPressed: (){
             TextEditingController add1 = new TextEditingController();
                          TextEditingController add2 = new TextEditingController();
                                       TextEditingController add3 = new TextEditingController();
        showDialog(context: context, builder: (context)=>Dialog(
                       child: Container(
                         height: 400,
                         child: ListView(
                          
                      children: [
               Padding(
                            padding: const EdgeInsets.only(bottom: 15,top: 40,right:30 ,left: 30),
                            child: TextFormField(
                             
                               controller:add1 ,
                               cursorColor: Colors.black,
                              decoration:  InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                    color: Colors.red,
                                  )),
                                labelText: 'Product Name',
                                  labelStyle: TextStyle(color: Colors.black)),
      
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15,right:30 ,left: 30),
                            child: TextFormField(
                              controller:add2 ,
                          keyboardType: TextInputType.number,
                               cursorColor: Colors.black,
                              decoration:  InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                    color: Colors.red,
                                  )),
                                labelText: 'Product Price',
                                  labelStyle: TextStyle(color: Colors.black)),
       
                            ),
                          ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:30 ,left: 30),
                                    child: TextFormField(
                                                       
                   controller:add3 ,
                       cursorColor: Colors.black,
                    decoration:  InputDecoration(
                              focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                 color: Colors.red,
                             )),
                             labelText: 'Product Image URL',
               labelStyle: TextStyle(color: Colors.black)),
         
           
                             ),
                                  ),
                                   Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                      child: Container(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: (){
                      int pp1=int.tryParse(add2.text);
                                Map <String,dynamic> d11 =
                 {"productName":add1.text,
                 "productPrice":pp1,
                 "productImg":add3.text,
                 "status":true
                 };
      
        FirebaseFirestore.instance.collection('snacks').add(d11);
                                 Get.snackbar("Product Added", "",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
                                  ); 
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin())); 
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
                       ));
      
                        },
                        color: Colors.red,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Add New Product",
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
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
    Padding(
      padding: const EdgeInsets.only(left: 70),
      child: Text("Product",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    ),
                         Padding(
                           padding: const EdgeInsets.only(left: 5),
                           child: Text("Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                         ),
                          Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ],),
            ),
          
            Expanded(
      
              child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('snacks').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        final data =snapshot.requireData;
                     TextEditingController data3 = new TextEditingController();
                    
                        return  ListView.builder(
                          shrinkWrap: true,
                          itemCount:data.size ,itemBuilder:(context,index) {
                          bool status =  data.docs[index]['status'];
                            int price =   data.docs[index]['productPrice'];
                               return
                                Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                         CircleAvatar(
                               radius: 35,
                                 backgroundImage: NetworkImage(data.docs[index]['productImg']),
                         ),
                                        
                                  Text(data.docs[index]['productName']),
                            Row(
                              children: [
                                Text('$price'),
////////////////////////////////////////////////// price update///////////////////////////////////////////
                                IconButton(onPressed: (){
                        
                         showDialog(context: context, builder: (context)=>Dialog(
                         child: Container(child: Container(
                         child: ListView(
                           shrinkWrap: true,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                          child: TextFormField(
                          controller: data3,
                          keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'price',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(borderRadius: 
                                        BorderRadius.all(Radius.circular(10)))
                                      ),
                                    ),
                        ),
                                   Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                        child: Container(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: (){
//////////////////////////////////////// price update in database ///////////////////////////////////////
                        int qty=int.tryParse(data3.text);
                                    snapshot.data.docs[index].reference.update({'productPrice':qty}).whenComplete(() => Navigator.pop(context));
                        
                                  
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
                         ),),
                         ));
                                }, icon: Icon(FontAwesomeIcons.edit)),
               
               
                              ],
                            ),
                            CustomSwitch(
                              value: status,
                              activeColor:Colors.greenAccent,
                              onChanged: (value){
                                setState(() {
                                  if(status==true)
                        {
                                snapshot.data.docs[index].reference.update({'status':false});
                                        Get.snackbar("Status", " ${data.docs[index]['productName']} is now unavailable",
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 4),
                                  );
                        }
                        else
                        {
                          snapshot.data.docs[index].reference.update({'status':true});
                                    Get.snackbar("Status", " ${data.docs[index]['productName']} is now available",
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 4),
                                  );
                        }
                              },
                                );
                          
                                }
                                
                                ),                       
                                         ],
                                ),
                              )
                               ;
                             });
                      },
                  
                ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////Lunch////////////////////////////////////////////
class FoodProduts22 extends StatefulWidget {
  

var dname;

FoodProduts22({Key key,this.dname}):super(key: key);

  @override
  State<FoodProduts22> createState() => _FoodProduts22State();
}

class _FoodProduts22State extends State<FoodProduts22> {
int count=0;

  @override
  Widget build(BuildContext context) {

    return Padding(
           padding: const EdgeInsets.only(right: 15,left: 15,top: 20),
      child: Expanded(
        child: Column(
          children: [
      Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                    child: Container(
                      child: MaterialButton(
                        minWidth: 50,
                        height: 40,
                        onPressed: (){
             TextEditingController add11 = new TextEditingController();
                          TextEditingController add21 = new TextEditingController();
                                       TextEditingController add31 = new TextEditingController();
        showDialog(context: context, builder: (context)=>Dialog(
                       child: Container(
                         height: 400,
                         child: ListView(
                          
                      children: [
               Padding(
                            padding: const EdgeInsets.only(bottom: 15,top: 40,right:30 ,left: 30),
                            child: TextFormField(
                             
                               controller:add11 ,
                               cursorColor: Colors.black,
                              decoration:  InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                    color: Colors.red,
                                  )),
                                labelText: 'Product Name',
                                  labelStyle: TextStyle(color: Colors.black)),
      
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15,right:30 ,left: 30),
                            child: TextFormField(
                              controller:add21 ,
                          keyboardType: TextInputType.number,
                               cursorColor: Colors.black,
                              decoration:  InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                    color: Colors.red,
                                  )),
                                labelText: 'Product Price',
                                  labelStyle: TextStyle(color: Colors.black)),
       
                            ),
                          ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:30 ,left: 30),
                                    child: TextFormField(
                                                       
                   controller:add31 ,
                       cursorColor: Colors.black,
                    decoration:  InputDecoration(
                              focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                 color: Colors.red,
                             )),
                             labelText: 'Product Image URL',
               labelStyle: TextStyle(color: Colors.black)),
         
           
                             ),
                                  ),
                                   Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                      child: Container(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: (){
                      int pp12=int.tryParse(add21.text);
                                Map <String,dynamic> d11 =
                 {"productName":add11.text,
                 "productPrice":pp12,
                 "productImg":add31.text,
                 "status":true
                 };
      
        FirebaseFirestore.instance.collection('lunch').add(d11);
                                 Get.snackbar("Product Added", "",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
                                  ); 
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin())); 
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
                       ));
      
                        },
                        color: Colors.red,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Add New Product",
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
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
    Padding(
      padding: const EdgeInsets.only(left: 70),
      child: Text("Product",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    ),
                         Padding(
                           padding: const EdgeInsets.only(left: 5),
                           child: Text("Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                         ),
                          Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ],),
            ),
          
            Expanded(
      
              child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('lunch').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        final data =snapshot.requireData;
                     TextEditingController data3 = new TextEditingController();
                    
                        return  ListView.builder(
                          shrinkWrap: true,
                          itemCount:data.size ,itemBuilder:(context,index) {
                          bool status =  data.docs[index]['status'];
                            int price =   data.docs[index]['productPrice'];
                               return
                                Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                         CircleAvatar(
                               radius: 35,
                                 backgroundImage: NetworkImage(data.docs[index]['productImg']),
                         ),
                                        
                                  Text(data.docs[index]['productName']),
                            Row(
                              children: [
                                Text('$price'),
                                IconButton(onPressed: (){
                        
                         showDialog(context: context, builder: (context)=>Dialog(
                         child: Container(child: Container(
                         child: ListView(
                           shrinkWrap: true,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                          child: TextFormField(
                          controller: data3,
                          keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'price',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(borderRadius: 
                                        BorderRadius.all(Radius.circular(10)))
                                      ),
                                    ),
                        ),
                                   Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                        child: Container(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: (){
                        int qty=int.tryParse(data3.text);
                                    snapshot.data.docs[index].reference.update({'productPrice':qty}).whenComplete(() => Navigator.pop(context));
                        
                                  
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
                         ),),
                         ));
                                }, icon: Icon(FontAwesomeIcons.edit)),
               
               
                              ],
                            ),
                            CustomSwitch(
                              value: status,
                              activeColor:Colors.greenAccent,
                              onChanged: (value){
                                setState(() {
                                  if(status==true)
                        {
                                snapshot.data.docs[index].reference.update({'status':false});
                                        Get.snackbar("Status", " ${data.docs[index]['productName']} is now unavailable",
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 4),
                                  );
                        }
                        else
                        {
                          snapshot.data.docs[index].reference.update({'status':true});
                                    Get.snackbar("Status", " ${data.docs[index]['productName']} is now available",
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 4),
                                  );
                        }
                              },
                                );
                          
                                }
                                
                                ),                       
                                         ],
                                ),
                              )
                               ;
                             });
                      },
                  
                ),
            ),
          ],
        ),
      ),
    );
  }
}
// /////////////////////////////////////////////////////Drinks///////////////////////////////////////////
class FoodProduts33 extends StatefulWidget {
  

var dname;

FoodProduts33({Key key,this.dname}):super(key: key);

  @override
  State<FoodProduts33> createState() => _FoodProduts33State();
}

class _FoodProduts33State extends State<FoodProduts33> {
int count=0;

  @override
  Widget build(BuildContext context) {
    
    return Padding(
           padding: const EdgeInsets.only(right: 15,left: 15,top: 20),
      child: Expanded(
        child: Column(
          children: [
      Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
                    child: Container(
                      child: MaterialButton(
                        minWidth: 50,
                        height: 40,
                        onPressed: (){
             TextEditingController add12 = new TextEditingController();
                          TextEditingController add22 = new TextEditingController();
                                       TextEditingController add32 = new TextEditingController();
        showDialog(context: context, builder: (context)=>Dialog(
                       child: Container(
                         height: 400,
                         child: ListView(
                          
                      children: [
               Padding(
                            padding: const EdgeInsets.only(bottom: 15,top: 40,right:30 ,left: 30),
                            child: TextFormField(
                             
                               controller:add12 ,
                               cursorColor: Colors.black,
                              decoration:  InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                    color: Colors.red,
                                  )),
                                labelText: 'Product Name',
                                  labelStyle: TextStyle(color: Colors.black)),
      
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 15,right:30 ,left: 30),
                            child: TextFormField(
                              controller:add22 ,
                          keyboardType: TextInputType.number,
                               cursorColor: Colors.black,
                              decoration:  InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:  BorderSide(
                                    color: Colors.red,
                                  )),
                                labelText: 'Product Price',
                                  labelStyle: TextStyle(color: Colors.black)),
       
                            ),
                          ),
                                  Padding(
                                    padding: const EdgeInsets.only(right:30 ,left: 30),
                                    child: TextFormField(
                                                       
                   controller:add32 ,
                       cursorColor: Colors.black,
                    decoration:  InputDecoration(
                              focusedBorder: OutlineInputBorder(
                              borderSide:  BorderSide(
                                 color: Colors.red,
                             )),
                             labelText: 'Product Image URL',
               labelStyle: TextStyle(color: Colors.black)),
         
           
                             ),
                                  ),
                                   Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                      child: Container(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: (){
                      int pp13=int.tryParse(add22.text);
                                Map <String,dynamic> d11 =
                 {"productName":add12.text,
                 "productPrice":pp13,
                 "productImg":add32.text,
                 "status":true
                 };
      
        FirebaseFirestore.instance.collection('drinks').add(d11);
                                 Get.snackbar("Product Added", "",
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
                                  ); 
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Admin())); 
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
                       ));
      
                        },
                        color: Colors.red,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Add New Product",
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
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
    Padding(
      padding: const EdgeInsets.only(left: 70),
      child: Text("Product",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
    ),
                         Padding(
                           padding: const EdgeInsets.only(left: 5),
                           child: Text("Price",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                         ),
                          Text("Status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ],),
            ),
          
            Expanded(
      
              child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('drinks').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        final data =snapshot.requireData;
                     TextEditingController data3 = new TextEditingController();
                    
                        return  ListView.builder(
                          shrinkWrap: true,
                          itemCount:data.size ,itemBuilder:(context,index) {
                          bool status =  data.docs[index]['status'];
                            int price =   data.docs[index]['productPrice'];
                               return
                                Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                         CircleAvatar(
                               radius: 35,
                                 backgroundImage: NetworkImage(data.docs[index]['productImg']),
                         ),
                                        
                                  Text(data.docs[index]['productName']),
                            Row(
                              children: [
                                Text('$price'),
                                IconButton(onPressed: (){
                        
                         showDialog(context: context, builder: (context)=>Dialog(
                         child: Container(child: Container(
                         child: ListView(
                           shrinkWrap: true,
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                          child: TextFormField(
                          controller: data3,
                          keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: 'price',
                                        hintStyle: TextStyle(color: Colors.grey),
                                        border: OutlineInputBorder(borderRadius: 
                                        BorderRadius.all(Radius.circular(10)))
                                      ),
                                    ),
                        ),
                                   Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                        child: Container(
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: (){
                        int qty=int.tryParse(data3.text);
                                    snapshot.data.docs[index].reference.update({'productPrice':qty}).whenComplete(() => Navigator.pop(context));
                        
                                  
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
                         ),),
                         ));
                                }, icon: Icon(FontAwesomeIcons.edit)),
               
               
                              ],
                            ),
                            CustomSwitch(
                              value: status,
                              activeColor:Colors.greenAccent,
                              onChanged: (value){
                                setState(() {
                                  if(status==true)
                        {
                                snapshot.data.docs[index].reference.update({'status':false});
                                        Get.snackbar("Status", " ${data.docs[index]['productName']} is now unavailable",
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 4),
                                  );
                        }
                        else
                        {
                          snapshot.data.docs[index].reference.update({'status':true});
                                    Get.snackbar("Status", " ${data.docs[index]['productName']} is now available",
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 4),
                                  );
                        }
                              },
                                );
                          
                                }
                                
                                ),                       
                                         ],
                                ),
                              )
                               ;
                             });
                      },
                  
                ),
            ),
          ],
        ),
      ),
    );
  }
}