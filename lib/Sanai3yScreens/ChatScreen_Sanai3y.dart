import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Widgets.dart';




class ChatScreen_Sanai3y extends StatelessWidget{


  final _fireStore = FirebaseFirestore.instance;
  List<Widget> senders=[];
  List<Widget> sendersWithoutRepeat=[];
  var unique = Set<Widget>();
  var nameSender;
  var imageSender;
  var message;
  var cardWidget;

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('Chats').orderBy('time').snapshots(),
              builder: (context , snapshot){
                if(snapshot.hasData){
                  final messages = snapshot.data?.docs;
                  for(var messageUser in messages!){
                     message = messageUser.get('message');
                  }
                }
                return Container();
              }
          ),
          StreamBuilder(
            stream: _fireStore.collection('ChatCard').snapshots(),
            builder: (context , snapshot){

              switch(snapshot.connectionState){
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(child: CircularProgressIndicator(),);

                case ConnectionState.done:
                case ConnectionState.active:

                  if(snapshot.hasData){
                    final data= snapshot.data?.docs.reversed;

                    for(var user in data!){
                      nameSender = user.get('nameSender');
                      imageSender = user.get('imageSender');
                      final email = user.get('emailSender');
                      final phoneSender = user.get('phoneSender');
                      final currentUser = FirebaseAuth.instance.currentUser?.email;
                      if(email!=currentUser){
                        cardWidget= CardMessages(
                          image: imageSender,
                          userName: nameSender,
                          message: message,
                          phone: phoneSender,
                        );
                        senders.add(cardWidget);
                      }
                    }
                  }
                  return senders.isNotEmpty?Column(
                    children: sendersWithoutRepeat= senders.where((element) => unique.add(element)).toList())
                  : Center(child: Text("You don't have conversations",style: TextStyle(color: Colors.white , fontSize: 20),),);
              }

            },
          )
        ],
      ),
    );
  }
}