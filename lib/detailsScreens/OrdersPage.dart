import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Widgets.dart';
import 'package:url_launcher/url_launcher.dart';


class OrdersPage extends StatelessWidget{


  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        leading: Icon(Icons.shopping_basket , size: 40,),
        title: Text("Your Orders" , style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontStyle: FontStyle.italic
        ),),

        actions: [
          CallBtn(colorIcon: Colors.white, colorText: Colors.blue[900])
        ],
      ),
      body: Center(child: Text("You don't have any Product",style: TextStyle(color: Colors.black87, fontSize: 20),),),
    );
  }
}