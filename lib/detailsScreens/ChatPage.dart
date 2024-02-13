import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Widgets.dart';
import 'package:url_launcher/url_launcher.dart';


class ChatPage extends StatefulWidget{
final userName , image , email , phone;

   ChatPage({this.image  ,this.userName , this.email , this.phone});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
String?  message;
final messageControll = TextEditingController();
final _fireStore = FirebaseFirestore.instance;
var nameSender;
var imageSender;
var phoneSender;

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue[900],
        title: Row(
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_rounded)),
            CircleAvatar(radius: 20, backgroundImage: NetworkImage(widget.image),),
            SizedBox(width: 10,),
            Text(widget.userName , style: TextStyle(
                fontSize: 17,
                fontFamily: 'Cairo-VariableFont_wght.ttf',
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),
            Spacer(),
            IconButton(
                onPressed: ()async{
                  try{
                    Uri phone = Uri(
                      scheme: 'tel',
                      path: "${widget.phone}"
                    );
                    await launchUrl(phone);
                  }
                      catch(e){
                        debugPrint(e.toString());
                      }
                },
                icon: Icon(CupertinoIcons.phone_fill)
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),
            Row(
              children: [
                Flexible(
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(bottom: 10 , left: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.blue[900]
                    ),
                    child: TextField(
                      controller: messageControll,
                      onChanged: (value){
                        message = value;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write Message Here. . . .',
                        contentPadding: EdgeInsets.only(left: 10),
                        hintStyle: TextStyle(fontStyle: FontStyle.italic,  color: Colors.white , fontWeight: FontWeight.w300),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(bottom: 10),
                  icon: Icon(Icons.send , size: 35,),
                  onPressed: ()async{
                    messageControll.clear();
                    String id = _fireStore.collection('Chats').doc().id;
                    FocusManager.instance.primaryFocus?.unfocus();
                      await for(var data in _fireStore.collection('Accounts').snapshots()){
                      for(var user in data.docs){
                        final email = user.get('Email');
                        if(FirebaseAuth.instance.currentUser?.email==email){
                          nameSender = user.get('UserName');
                          imageSender = user.get('image');
                          phoneSender = user.get('Phone');
                          _fireStore.collection('Chats').doc(id).set({
                            'emailSender'  :  FirebaseAuth.instance.currentUser?.email,
                            'nameSender'   :  nameSender,
                            'imageSender'  :  imageSender,
                            'nameR'        :  widget.userName,
                            'imageR'       :  widget.image,
                            'message'      :  message,
                            'time'         :  FieldValue.serverTimestamp(),
                          });
                            _fireStore.collection('ChatCard').doc(widget.userName).set(
                                {
                                  'nameR'        :  widget.userName,
                                  'imageR'       :  widget.image,
                                  'emailSender'  :  FirebaseAuth.instance.currentUser?.email,
                                  'nameSender'   :  nameSender,
                                  'imageSender'  :  imageSender,
                                  'phoneR'       :  widget.phone,
                                  "phoneSender"  :  phoneSender,
                                  'message'      :  message,
                                  'time'         :  FieldValue.serverTimestamp(),
                                });

                        }
                      }
                    }
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}