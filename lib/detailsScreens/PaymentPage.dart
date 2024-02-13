import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Buttons.dart';



class PaymentPage extends StatelessWidget{

  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.black87,
        leading: Icon(Icons.attach_money_outlined , size: 40,),
        title: Text("Payment" , style: TextStyle(
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