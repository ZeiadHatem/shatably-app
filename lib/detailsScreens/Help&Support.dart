import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:url_launcher/url_launcher.dart';



class HelpSupport extends StatelessWidget{


  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(Icons.support_agent , color: Colors.black87,size: 35,),
          title: Text('Connect With Us' , style: TextStyle(
            fontSize: 30 ,
            color: Colors.black87,
            fontWeight: FontWeight.w100,
            fontStyle: FontStyle.italic
          ),),
        ),

      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
           ButtonS(
               text: 'Call Us',
               icon: Icon(CupertinoIcons.phone),
               onPressed: ()async{
                 try{
                   Uri phone = Uri(
                       scheme: 'tel',
                       path: '01028236589'
                   );
                   await launchUrl(phone);
                 }
                 catch(e){
                   debugPrint(e.toString());
                 }
               },
               color1: Colors.black87
           ),
            ButtonS(
                text: 'Chat Us',
                icon:   Icon(CupertinoIcons.chat_bubble_text),
                onPressed: ()async{
                  final link = Uri.parse('https://wa.me/01099304011');
                  await launchUrl(link);
                },
                color1: Colors.black87
            )
          ],
        ),
      ),
    );
  }
}