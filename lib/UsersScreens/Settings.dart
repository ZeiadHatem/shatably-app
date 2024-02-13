import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shatably/Sanai3yScreens/Samai3yScreen.dart';
import 'package:shatably/Sanai3yScreens/Sanai3ySignIn.dart';
import 'package:shatably/detailsScreens/BinPage.dart';
import 'package:shatably/detailsScreens/Help&Support.dart';
import 'package:shatably/detailsScreens/OrdersPage.dart';
import 'package:shatably/registeration&login/SignIn.dart';
import 'package:shatably/tools/Widgets.dart';
import '../detailsScreens/PaymentPage.dart';
import '../tools/Buttons.dart';



class SettingsPage extends StatefulWidget{

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
   final Auth = FirebaseAuth.instance;
   var userName;
   var currentUser;
   final _fireStore = FirebaseFirestore.instance;
   late User signedInUser ;
   var jobUser;
   var accountsUser ;
   var unique = Set<Text>();
   List<Text> usersWithoutRepeat=[];


   @override
   void initState(){
     super.initState();
     getUserName();
     getUser();
     getImage();
   }

   getUser(){

     final User = Auth.currentUser;
     if(User != null){
       signedInUser = User;
     }
   }

   logOut()async{
     await Auth.signOut();
     //signedInUser.delete();
     Navigator.pushNamed(context, SignIn.screenR);
   }

   getUserName(){
     StreamBuilder<QuerySnapshot>(
         stream: _fireStore.collection('Accounts').snapshots(),
         builder: (context , snapshot){
           List<Text> accountUser = [];
           if(snapshot.hasData){
             accountsUser = snapshot.data?.docs;

             for(var user in accountsUser!){

               currentUser= user.get('Email');
               userName = user.get('UserName');

               if(signedInUser.email==currentUser&&userName!=null){
                 accountUser.add(Text(userName , style: Theme.of(context).textTheme.titleSmall,));

               }
             }
           }

           return Positioned(
               bottom: 0,
               right: 0,
               child:SizedBox(
                   height: 90,
                   //width: size.width-100,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       userName!=null?Column(
                           crossAxisAlignment: CrossAxisAlignment.stretch,
                           children: usersWithoutRepeat = accountUser.where((element) => unique.add(element)).toList()
                       ): Container(),

                       signedInUser.displayName!=null? Column(
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                           Text("${signedInUser.displayName}" , style: Theme.of(context).textTheme.titleSmall,),
                         ],
                       ):Container()


                     ],
                   )

               )
           );
         }
     );
   }

   getImage(){
     ImageStreamBuilder();
   }

   Sanai3yLogIn()async{
     DocumentSnapshot<Map<String, dynamic>> job = await FirebaseFirestore.instance.collection('Sanai3yAccounts').doc(signedInUser.email).get();
     
     //print(job.get('email'));
     if(job.data()!=null){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Sanai3yScreen()));
     }
     else
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Sanai3ySignIn()));

     setState(() {
       jobUser = job;
     });

   }


   Widget build(BuildContext context){
     Size size = MediaQuery.of(context).size;

     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.indigo,
         title: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text("Settings" , style: TextStyle(
                 fontSize: 30,
                 fontFamily: 'Cairo-VariableFont_wght.ttf',
                 color: Colors.greenAccent,
                 fontWeight: FontWeight.bold
             ),),
             CartBtn()
           ],
         ),
       ),
       body: SingleChildScrollView(
         child: Column(
           children: [
             Stack(
               alignment: Alignment.topLeft,
               children: [
                 Container(
                   margin: EdgeInsets.symmetric(vertical: 20 , ),
                   height: 100,
                   //color: Colors.black87,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(40),
                       boxShadow: [
                         BoxShadow(offset: Offset(0,15) , blurRadius: 25 , color: Colors.black26)
                       ]
                   ),
                 ),

                         ImageStreamBuilder(),
                 
                 StreamBuilder<QuerySnapshot>(
                     stream: _fireStore.collection('Accounts').snapshots(),
                     builder: (context , snapshot){
                       List<Text> accountUser = [];
                       if(snapshot.hasData){
                         accountsUser = snapshot.data?.docs;

                         for(var user in accountsUser!){

                           currentUser= user.get('Email');
                           userName = user.get('UserName');
                           if(signedInUser.email==currentUser&&userName!=null){
                             accountUser.add(Text(userName , style: Theme.of(context).textTheme.titleSmall,));

                           }
                         }

                       }

                       return Positioned(
                           bottom: 0,
                           right: 0,
                           child:SizedBox(
                               height: 90,
                               width: size.width-100,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.stretch,
                                 children: [
                                   userName!=null?Column(
                                       crossAxisAlignment: CrossAxisAlignment.stretch,
                                       children: usersWithoutRepeat = accountUser.where((element) => unique.add(element)).toList()
                                   ): Container(),

                                   signedInUser.displayName!=null? Column(
                                     crossAxisAlignment: CrossAxisAlignment.stretch,
                                     children: [
                                       Text("${signedInUser.displayName}" , style: Theme.of(context).textTheme.titleSmall,),
                                     ],
                                   ):Container()


                                 ],
                               )
                           )
                       );
                     }
                 ),
               ],
             ),

             Column(
               children: [
                 Stack(
                   children: [
                     Container(
                         margin: EdgeInsets.symmetric(vertical: 10 ),
                         height: 500,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(40),
                             color: Colors.white,
                             boxShadow: [
                               BoxShadow(offset: Offset(0,15) , color: Colors.black26 , blurRadius: 25)
                             ]
                         ),
                         child: Padding(
                           padding:  EdgeInsets.all(20),
                           child: Column(
                             children: [
                               ButtonS(
                                 text: "Payment",
                                 color1: Colors.greenAccent,
                                 onPressed: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentPage()));
                                 },
                                 icon: Icon(Icons.payment),),

                               ButtonS(
                                   text: "Orders",
                                   icon: Icon(Icons.shopping_basket_outlined, color: Colors.yellow,),
                                   onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> OrdersPage()));
                                   },
                                   color1: Colors.black87
                               ),

                               ButtonS(
                                   text: "Bin",
                                   icon: Icon(Icons.delete_outline_outlined , color: Colors.orange,),
                                   onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=>BinPage()));
                                   },
                                   color1: Colors.orangeAccent
                               ),

                               ButtonS(
                                   text: "General",
                                   icon: Icon(Icons.settings_rounded , color: Colors.grey,),
                                   onPressed: (){

                                   },
                                   color1: Colors.lightBlueAccent),

                               Divider(color: Colors.black87,),

                               ButtonS(
                                   text: "Help & Support",
                                   icon: Icon(Icons.support_agent_outlined , color: Colors.indigo,),
                                   onPressed: (){
                                     Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpSupport()));
                                   },
                                   color1: Colors.tealAccent),
                               ButtonS(
                                   text: 'Go to Work',
                                   icon: Icon(Icons.work_outline_outlined , color: Colors.red,),
                                   color1: Colors.cyanAccent,
                                   onPressed: ()async{
                                       Sanai3yLogIn();
                                   }

                               ),
                             ],
                           ),
                         )
                     ),
                   ],
                 )
               ],
             )

             ,MaterialButton(
               onPressed: (){
                 logOut();
               } ,
               child: Row(
                 children: [
                   Icon(Icons.logout ,color: Colors.brown, ),

                   SizedBox(width: 30,),

                   Text("LogOut" ,
                     style: TextStyle(
                         fontWeight: FontWeight.bold,
                         fontFamily: 'Cairo-VariableFont_wght.ttf',
                         color: Colors.brown
                     ),
                   )
                 ],
               ),
             )
           ],
         ),
       ),
     );
   }
}