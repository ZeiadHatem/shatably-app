import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shatably/Sanai3yScreens/ChatScreen_Sanai3y.dart';
import '../registeration&login/SignIn.dart';
import 'HomeScreen_Sanai3y.dart';
import 'Profile_Page_Sanai3y.dart';


class Sanai3yScreen extends StatefulWidget{

  @override
  State<Sanai3yScreen> createState() => _Sanai3yScreenState();
}

class _Sanai3yScreenState extends State<Sanai3yScreen> {

  late User signedInUser;
  final Auth = FirebaseAuth.instance;


  logOut()async{
    await Auth.signOut();
    //signedInUser.delete();

    Navigator.pushNamed(context, SignIn.screenR);
  }
  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser(){
    final user = Auth.currentUser;
    if(user!=null){
      signedInUser =  user;
    }
  }

  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Shatably" , style: TextStyle(
                fontSize: 40 ,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo-VariableFont_wght.ttf',
                color: Colors.indigo[100],
                fontStyle: FontStyle.italic
              ),),

                TextButton(
                    onPressed: (){
                      logOut();
                      //signedInUser.delete();
                    },
                    child: Row(
                      children: [
                        Text('LogOut' , style: Theme.of(context).textTheme.bodyMedium,),
                        SizedBox(width: 4,),
                        Icon(Icons.logout,  color: Colors.white,),

                      ],
                    )
                )
            ],
          ),
          bottom: TabBar(
              tabs: [
                Tab(child: Text("Home",style: Theme.of(context).textTheme.bodyMedium,),),
                Tab(child: Text("Chat"  ,style: Theme.of(context).textTheme.bodyMedium,),),
                Tab(child: Text('Profile',style: Theme.of(context).textTheme.bodyMedium,),)
              ]
          ),
        ),
        backgroundColor: Colors.blue[900],
        body: TabBarView(
            children: [
              HomeScreen_Sanai3y(),
              ChatScreen_Sanai3y(),
              ProfilePageSanai3y(),
            ]
        ),
      ),
    )
    );
  }
}