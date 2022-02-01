import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/////////////////////////////////////////////////////Snacks////////////////////////////////////////////////
class FoodProduts extends StatelessWidget {
  

var dname;
int count=0;

FoodProduts({Key key,this.dname}):super(key: key);
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
      child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('snacks').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                final data =snapshot.requireData;
            /// fetching the snacks data 
                return   ListView.builder(
                  itemCount:data.size ,itemBuilder:(context,index) {
                    int price =   data.docs[index]['productPrice'];
                       return
                        Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 CircleAvatar(
                       radius: 50,
                         backgroundImage: NetworkImage(data.docs[index]['productImg']),
                 ),
              
                          Text(data.docs[index]['productName']),
                    Text('$price'),
////////////////////////////user side status (availability)///////////////////////////////////////////////
                    Row(children: [if ( data.docs[index]['status']==false) ...[ 
            Container(
                child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text("Sold Out!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ),
            ),
          ] else ...[
             MaterialButton(onPressed: (){
/////////////////////////////// creating cart collection user /////////////////////////////////////////
        Map <String,dynamic> d =
               {"productname":data.docs[index]['productName'],
               "price":price,
               "user":dname,"qnt":count, "productimg": data.docs[index]['productImg'],
               "Tprice":0
               };
      FirebaseFirestore.instance.collection(dname).add(d);

      Get.snackbar("Product Added", "You have added ${data.docs[index]['productName']} to the cart",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          
          );

        },
      color: Colors.red,
                       shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
        child:Text("Add to cart",style: TextStyle(color: Colors.white),) ,), 
          ],
        ]
          ),    
        ]
                 ),
                      )
                       ;
                     });
              },
        ),
    );
  }
}

//////////////////////////////////////////Lunch///////////////////////////////////////////////////////////
class FoodProduts2 extends StatelessWidget {
  

var dname;
int count=0;

FoodProduts2({Key key,this.dname}):super(key: key);
  @override
  Widget build(BuildContext context) {
    // final CollectionReference q =FirebaseFirestore.instance.collection('cart_total');
    return Padding(
       padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
      child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('lunch').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                final data =snapshot.requireData;
            
                return   ListView.builder(
                  itemCount:data.size ,itemBuilder:(context,index) {
                    int price =   data.docs[index]['productPrice'];
                       return
                        Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 CircleAvatar(
                       radius: 50,
                         backgroundImage: NetworkImage(data.docs[index]['productImg']),
                 ),
              
                          Text(data.docs[index]['productName']),
                    Text('$price'),

                    Row(children: [if ( data.docs[index]['status']==false) ...[
            Container(
                child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text("Sold Out!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ),
            ),
          ] else ...[
             MaterialButton(onPressed: (){
                 
        Map <String,dynamic> d =
               {"productname":data.docs[index]['productName'],
               "price":price,
               "user":dname,"qnt":count, "productimg": data.docs[index]['productImg'],
               "Tprice":0
               };
      FirebaseFirestore.instance.collection(dname).add(d);

      Get.snackbar("Product Added", "You have added ${data.docs[index]['productName']} to the cart",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          
          );

        },
      color: Colors.red,
                       shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
        child:Text("Add to cart",style: TextStyle(color: Colors.white),) ,), 
          ],
        ]
          ),    
        ]
                 ),
                      )
                       ;
                     });
              },
          
        ),
    );
  }


}
// ////////////////////////////////////////Drinks////////////////////////////////////////////////////////
class FoodProduts3 extends StatelessWidget {
  

var dname;
int count=0;

FoodProduts3({Key key,this.dname}):super(key: key);
  @override
  Widget build(BuildContext context) {
    // final CollectionReference q =FirebaseFirestore.instance.collection('cart_total');
    return Padding(
         padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
      child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection('drinks').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                final data =snapshot.requireData;
            
                return   ListView.builder(
                  itemCount:data.size ,itemBuilder:(context,index) {
                    int price =   data.docs[index]['productPrice'];
                       return
                        Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 CircleAvatar(
                       radius: 50,
                         backgroundImage: NetworkImage(data.docs[index]['productImg']),
                 ),
              
                          Text(data.docs[index]['productName']),
                    Text('$price'),

                    Row(children: [if ( data.docs[index]['status']==false) ...[
            Container(
                child: Padding(
                padding: const EdgeInsets.only(right: 35),
                child: Text("Sold Out!",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                ),
            ),
          ] else ...[
             MaterialButton(onPressed: (){
                 
        Map <String,dynamic> d =
               {"productname":data.docs[index]['productName'],
               "price":price,
               "user":dname,"qnt":count, "productimg": data.docs[index]['productImg'],
               "Tprice":0
               };
      FirebaseFirestore.instance.collection(dname).add(d);

      Get.snackbar("Product Added", "You have added ${data.docs[index]['productName']} to the cart",
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          
          );

        },
      color: Colors.red,
                       shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
        child:Text("Add to cart",style: TextStyle(color: Colors.white),) ,), 
          ],
        ]
          ),    
        ]
                 ),
                      )
                       ;
                     });
              },
          
        ),
    );
  }
}
