import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shatably/detailsScreens/CarpentryPage.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Products.dart';
import 'package:shatably/tools/Widgets.dart';


class ElectricityPage extends StatefulWidget{

  @override
  State<ElectricityPage> createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {

  final Auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  late User  signedInUser;
  var sanai3ya;
  var unique = Set<Sanai3yContainer>();
  List<Sanai3yContainer> electricalWithoutRepeat = [];

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser(){
    final User = Auth.currentUser;
    if(User!=null){
      signedInUser = User;
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      drawer: DrawerDetails(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Electricity", style: TextStyle(
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
                margin: EdgeInsets.only(top:70),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40)
                  )
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                  stream: _fireStore.collection('Sanai3yAccounts').snapshots(),
                  builder: (context , Snapshot){

                    if(Snapshot.hasData){
                      sanai3ya = Snapshot.data?.docs;
                      for(var sanai3y in sanai3ya!){
                        final phone = sanai3y.get('phone');
                        final job = sanai3y.get('job');
                        final sanai3yEmail = sanai3y.get('email');
                        final currentUser = signedInUser.email;
                        final sanai3yName = sanai3y.get('userName');
                        final image = sanai3y.get('image');
                        if(job == 'electrical'&&signedInUser.phoneNumber!=phone&&currentUser!=sanai3yEmail&&job!=null){

                          final sanai3yContainer = Sanai3yContainer(
                            image: image,
                            phone: phone,
                            job: job,
                            userName: sanai3yName,
                            email: sanai3yEmail,
                          );
                          electrical.add(sanai3yContainer);
                        }

                      }
                    }

                    return Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10) ,
                          child: ListView(
                            children: electricalWithoutRepeat = electrical.where((sanai3yContainer) => unique.add(sanai3yContainer)).toList(),
                          ),
                        )
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}