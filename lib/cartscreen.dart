

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_signup_screen/profile.dart';
class CartScreen extends StatelessWidget {
  var dname ;
 CartScreen({ Key key ,this.dname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: 
      AppBar(
        
        backgroundColor: Colors.red,
        title: Text("Cart"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
 
          children: [

           
            CartProducts(dname: dname,),
                         
  
          ],
        ),
      ),
      
    );
  }
}




class CartProducts extends StatefulWidget {
  var dname ;

   CartProducts({ Key key,this.dname}) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
int total=0;

 TimeOfDay _time = TimeOfDay(hour: 0, minute: 0);
 //////////////////////////////////////////////////// method for selecting time/////////////////////////////////////////////////
  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime; /// show changed time
      });
    }
  }
  @override
  Widget build(BuildContext context) {


  
      var i= widget.dname;
     var  a =_time.format(context);
     CollectionReference q = FirebaseFirestore.instance.collection('T${widget.dname}');
    return 
    Column(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection(widget.dname).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      final data =snapshot.requireData;
                   /// cart data fetch
                      return   Container(
                        height: 510,
                       
                        child: ListView.builder(
                          itemCount:data.size ,itemBuilder:(context,index) {
                          int qnt = data.docs[index]['qnt'];
                          int p=data.docs[index]['price'];
                              int count=data.docs[index]['qnt'];
                          int tprice=0;
                        
                               return
                                Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                         CircleAvatar(
                               radius: 50,
                                 backgroundImage: NetworkImage(data.docs[index]['productimg']),
                         ),
                  
                                  Text(data.docs[index]['productname']),
                                   IconButton(onPressed: (){
            
                
                              count = count-1;
                               tprice = count*p;
                  snapshot.data.docs[index].reference.update({'qnt':count});
                  snapshot.data.docs[index].reference.update({'Tprice':tprice});
                  
              setState(() {
                CollectionReference q = FirebaseFirestore.instance.collection('T${widget.dname}');
                total=total-p;
                 q.doc('total').set({
                        'Total':total
                      }); 
              });
        
              }, icon: Icon(Icons.remove_circle)),
              Text('$qnt'),
              IconButton(onPressed: (){
                int count=data.docs[index]['qnt'];
                              count = count+1;
                               tprice = count*p;
                  snapshot.data.docs[index].reference.update({'qnt':count});
                  snapshot.data.docs[index].reference.update({'Tprice':tprice});
   ////////////////////////////////////////////////////modifying the total price/////////////////////////
               setState(() {
                CollectionReference q = FirebaseFirestore.instance.collection('T${widget.dname}');
                total=total+p;
                 q.doc('total').set({
                        'Total':total
                      }); 
              });

              }, icon: Icon(Icons.add_circle)),
//////////////////////////////////////////// delete buttton///////////////////////////////////////////////
              IconButton(onPressed: (){
               setState(() {
                CollectionReference q = FirebaseFirestore.instance.collection('T${widget.dname}');
                total=total-(count*data.docs[index]['price']);
                 q.doc('total').update({
                        'Total':total
                      }); 
              });
                snapshot.data.docs[index].reference.delete();

                       Get.snackbar("Product Deleted", "",
                snackPosition: SnackPosition.BOTTOM,
                duration: Duration(seconds: 2)   );
              }, icon: Icon(Icons.delete))
                     ],
                                ),
                              )
                               ;
                             }),
                      );
                    },
                
              ),
          ),
        ),
//////////////////////////////////////////// Selecting time///////////////////////////////////////////////
 Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Colors.red,
              onPressed: _selectTime,
              child: Text('SELECT TIME',
              style: TextStyle(color: Colors.white)),
            ),     
            SizedBox(height: 8),
            Text(
              'Selected time: $a',
            ),
          ],
        ),
      ),

      /////////////////////////////////////////////////////total fetch ////////////////////////////////////
        StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('T$i').snapshots(),
        
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                                 final data =snapshot.requireData;
                            return Container(height: 50,
        
                            child: ListView.builder( itemCount:1,itemBuilder:(context,index){
        
                             int a1= data.docs[index]['Total'];
        
                                return  Padding(
                                  padding: const EdgeInsets.only(left:20,right: 20,top: 6),
                                  child: Row(

                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
                                    children: [
        Text('Total:',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                                      Text('$a1',style: TextStyle(fontSize: 25),),

////////////////////////////////////////////////////CHECKOUT//////////////////////////////////////////////
                                       MaterialButton(
                               color: Colors.red,
                              shape: RoundedRectangleBorder(
                                               borderRadius: BorderRadius.circular(50)),
        
                                               child:  const Text('Check Out!', style: TextStyle(fontSize: 20)),
        
                               textColor: Colors.white,
        
                               elevation: 5,
        
                               onPressed: () {
                                 
         CollectionReference q12 = FirebaseFirestore.instance.collection('T$i');
         
                                        q12.doc('total').update({
                    
                              'Total':0,
                              // 'items':''
                             
                              });   
                                       CollectionReference q123 = FirebaseFirestore.instance.collection(i);
         
                                        q123.doc().delete();   
         CollectionReference q1 = FirebaseFirestore.instance.collection('orders');
                                        q1.doc(i).set({
                              'Name': i,
                              'Time':a,
                              'Total':a1,
                              // 'items':''
                             
                              });   
                               showAlertDialog(context);  

            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));


                               }
                             )
                                    ],
                                  ),
                                );
                            } ),);
                              }
        ),
      ],
    );
  }
showAlertDialog(BuildContext context) {  
  //////////////////////////////////////////////////// Create button(Alert dialog)  ///////////////////////////////////
  Widget okButton = TextButton(  
    child: Text("OK"),  
    onPressed: () {  
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
    },  
  );  
  
  ///////////////////////////////////////////////// Create AlertDialog  //////////////////////////////////
  AlertDialog alert = AlertDialog(  
    title: Text("Order Completed Successfully"),  
    content: Text("Have a pleasent day!"),  
    actions: [  
      okButton,  
    ],  
  );  
  
  ///////////////////////////////////////////// show the dialog////////////////////////////////////////
  showDialog(  
    context: context,  
    builder: (BuildContext context) {  
      return alert;  
    },  
  );  
}
}









