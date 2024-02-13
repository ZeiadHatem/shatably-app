import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Widgets.dart';

class ChatScreenHome extends StatelessWidget{

  final _fireStore = FirebaseFirestore.instance;
  List<Widget> senders=[];
  List<Widget> sendersWithoutRepeat=[];
  var unique = Set<Widget>();
  var nameR;
  var imageR;
  var message;
  var cardWidget;


  Widget build(BuildContext context){

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Sahtably" , style: TextStyle(
            fontSize: 40,
            fontFamily: 'Cairo-VariableFont_wght.ttf',
            color: Colors.greenAccent,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
        ),),
      ),

      body: ListView(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: _fireStore.collection('Messages').orderBy('time').snapshots(),
              builder: (context , snapshot){
                List<MessageContainer> messagesUsers = [];
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
                    nameR = user.get('nameR');
                    imageR = user.get('imageR');
                    final email = user.get('emailSender');
                    final message = user.get('message');
                    final phoneR = user.get('phoneR');
                    final currentUser = FirebaseAuth.instance.currentUser?.email;
                    if(email== currentUser){
                      cardWidget= CardMessages(
                        image: imageR,
                        userName: nameR,
                        message: message,
                        phone: phoneR,
                      );
                      senders.add(cardWidget);
                    }
                  }
                }
                return senders.isNotEmpty?Column(
                  children: sendersWithoutRepeat= senders.where((element) => unique.add(element)).toList(),
                ) : Center(child: Text("You don't have conversations",style: TextStyle(color: Colors.grey[500] , fontSize: 20),),);
              }

            },
          ),
        ],
      ),
    );
  }
}