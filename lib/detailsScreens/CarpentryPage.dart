import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Products.dart';
import 'package:shatably/tools/Widgets.dart';

import 'Profile_Page.dart';


//var sanai3yContainer;
var unique = Set<Widget>();
List<Widget> carpentersWithoutRepeat = [];
var sanai3ya;

class CarpentryPage extends StatefulWidget{

  @override
  State<CarpentryPage> createState() => _CarpentryPageState();
}

class _CarpentryPageState extends State<CarpentryPage> {
  
  //GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  final Auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  late  User signedInUser;
  var sanai3yName;
  var image;
  var job;
  var sanai3yEmail;
  var phone;
  var num = 0;


 @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {
   final User = Auth.currentUser;
   if(User!=null){
     signedInUser = User;
   }
  }

  
  Widget build(BuildContext context){

    Size size = MediaQuery.of(context).size;

    return Scaffold(

      drawer: DrawerDetails(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Carpentry", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo-VariableFont_wght.ttf',
                fontSize: 40,
                color: Colors.greenAccent,
                fontStyle: FontStyle.italic
            ),),
            CartBtn()
          ],
        ),
      ),

      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Expanded(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)
                  ))
                ),

              StreamBuilder<QuerySnapshot>(
                  stream: _fireStore.collection('Sanai3yAccounts').snapshots(),
                  builder: (context , Snapshot){

                     if(Snapshot.hasData){
                       final sanai3ya = Snapshot.data?.docs;
                       for(var sanai3y in sanai3ya!){
                          phone = sanai3y.get('phone');
                          job = sanai3y.get('job');
                          sanai3yEmail = sanai3y.get('email');
                          sanai3yName = sanai3y.get('userName');
                          image = sanai3y.get('image');
                         final currentUser = signedInUser.email;

                         if(signedInUser.phoneNumber!=phone&&job!=null&&sanai3yEmail!=currentUser&&job=='carpenter'){
                           final sanai3yContainer =  Sanai3yContainer(
                               phone: phone, job: job, image: image, userName: sanai3yName,email: sanai3yEmail,);
                           carpenters.add(sanai3yContainer);

                         }

                       }
                     }

                    return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10) ,
                          child: ListView(
                            children:
                              carpentersWithoutRepeat = carpenters.where((sanai3yContainer) => unique.add(sanai3yContainer))
                                  .toList()

                          ),
                        )
                    );
                  }

              ),
            ],
          ),
        ),
      ),
    );
  }


}