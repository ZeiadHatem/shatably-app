import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../tools/Buttons.dart';


class BinPage extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: Icon(CupertinoIcons.delete , size: 40,),
        title: Text("Bin" , style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontStyle: FontStyle.italic
        ),),

        actions: [
          CallBtn(colorIcon: Colors.white, colorText: Colors.white)
        ],
      ),
      body: Center(child: Text("You don't have any Product",style: TextStyle(color: Colors.black87, fontSize: 20),),),
    );
  }
}