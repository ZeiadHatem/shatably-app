import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../tools/Buttons.dart';
import '../tools/Widgets.dart';
import 'ChatPage.dart';


class ProfilePage extends StatefulWidget{
final Sanai3yInfoContainer sanai3yInfoContainer;
final String name;
final String image;
final email;
final phone;
   ProfilePage({required this.sanai3yInfoContainer, required this.name, required this.image, required this.email , this.phone});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final Auth =FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  late User signedInUser;
  List<PostProfileSanai3yContainer> postSanai3yWithoutRepeat =[];
  var unique = Set<PostProfileSanai3yContainer>();

  @override
  void initState() {
    getUser();
    super.initState();
  }
  getUser(){

    final User = Auth.currentUser;
    if(User != null){
      signedInUser = User;
    }
  }


  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: Text('Shatably' , style: TextStyle(
                fontSize: 40 ,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo-VariableFont_wght.ttf',
                color: Colors.green[200],
                fontStyle: FontStyle.italic
            ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70 , left: 8 , right: 8),
                  height: 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40))
                  ),
                ),

                widget.sanai3yInfoContainer,

                Padding(
                    padding:  EdgeInsets.only(top: 200 , left: 10 , right: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: FirstBtn(
                              text: 'Message Me',
                              color: Colors.blue,
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
                                  userName: widget.name,
                                  image: widget.image,
                                  email: widget.email,
                                  phone: widget.phone

                                )));
                              }
                          ),
                        ),

                        SizedBox(width: 30,),

                        Expanded(
                            child: FirstBtn(
                                text: 'Rate ',
                                color: Colors.red[900]!,
                                onPressed: (){}
                            )
                        )
                      ],
                    )
                )
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

                  StreamBuilder(
                      stream: _fireStore.collection('PostsSanai3y').snapshots(),
                      builder: (context , snapshot){
                        List<PostProfileSanai3yContainer> postsSanai3y=[];

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
                              final postImage = post.get('image');
                              final emailPost = post.get('email');
                              if(emailPost== widget.email){

                                final postProfile = PostProfileSanai3yContainer(
                                  imagePost: postImage,
                                  textPost: postText,
                                  name: widget.name,
                                  image: widget.image,
                                );

                                postsSanai3y.add(postProfile);
                              }

                            }
                          }
                          return  Column(
                            children: postSanai3yWithoutRepeat = postsSanai3y.where((element) => unique.add(element)).toList(),
                          );
                        }

                      }
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