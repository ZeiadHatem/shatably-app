import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Products.dart';

import '../tools/Buttons.dart';
import '../tools/Widgets.dart';
import 'PostScreen.dart';

class ProfilePageSanai3y extends StatefulWidget{
  @override
  State<ProfilePageSanai3y> createState() => _ProfilePageSanai3y();
}

class _ProfilePageSanai3y extends State<ProfilePageSanai3y> {
  late User signedInUser;
  final Auth = FirebaseAuth.instance;

  final _fireStore = FirebaseFirestore.instance;

  List<PostSanai3yContainer> postSanai3yWithoutRepeat = [];

  var unique = Set<PostSanai3yContainer>();


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

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                height: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(40))
                ),
              ),
              InfoSanai3yStreamBuilder(),

              Padding(
                  padding:  EdgeInsets.only(top: 200 , left: 10 , right: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: FirstBtn(
                            text: '+ Write Post',
                            color: Colors.blue,
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PostPage()));
                            }
                        ),
                      ),

                      SizedBox(width: 30,),

                      Expanded(
                          child: FirstBtn(
                              text: 'Edit Profile',
                              color: Colors.black87,
                              onPressed: (){}
                          )
                      )
                    ],
                  )
              ),
            ],
          ),

          SizedBox(height: 10,),

          Padding(
            padding:  EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Posts' , style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo-VariableFont_wght.ttf',
                    color: Colors.white
                )),

                SizedBox(height: 10,),

                //PostSanai3yContainer()

                StreamBuilder<QuerySnapshot>(
                    stream: _fireStore.collection('PostsSanai3y').orderBy('time').snapshots(),
                    builder: (context , snapshot){
                      List<PostSanai3yContainer> postSanai3y=[];

                      switch(snapshot.connectionState){
                        case ConnectionState.waiting:
                        case ConnectionState.none:
                          return Center(child: CircularProgressIndicator(),);

                        case ConnectionState.done:
                        case ConnectionState.active:

                        if(snapshot.hasData){
                          final posts = snapshot.data?.docs;

                          for(var post in posts!){

                            final postText = post.get('text');
                            final imagePost = post.get('image');
                            final sanai3y = post.get('email');
                            final timeCreate = post.get('time');

                            if(postText!=null&&signedInUser.email==sanai3y) {
                              final postContainer = PostSanai3yContainer(
                                imagePost: imagePost,
                                textPost: postText,
                              );
                              postSanai3y.add(postContainer);
                            }
                          }
                        }

                        return Column(
                          children: postSanai3yWithoutRepeat = postSanai3y.where((postContainer) => unique.add(postContainer))
                              .toList(),
                        );
                      }
                    }
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}