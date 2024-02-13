import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Products.dart';
import 'package:shatably/tools/Widgets.dart';


class CartScreen extends StatelessWidget{
  final _firestore = FirebaseFirestore.instance;
  List<CartContainer> productOfCartWithoutRepeat = [];
  var unique =Set<CartContainer>();

  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        leading: Icon(CupertinoIcons.shopping_cart , color: Colors.black87,size: 40,),
        title: Text('Cart Page' , style: TextStyle(
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w400,
          fontSize: 40,
          color: Colors.black87,
          fontFamily: 'Cairo-VariableFont_wght.ttf'
        ),),
        actions: [
          CallBtn(colorIcon: Colors.black87, colorText: Colors.indigo)
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Shopping').doc(FirebaseAuth.instance.currentUser?.email).collection('ShoppingProducts').orderBy('time').snapshots(),
        builder: (context , snapshot){
          final List<CartContainer> productOfCart = [];

          switch(snapshot.connectionState){

            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);

            case ConnectionState.active:
            case ConnectionState.done:
              if(snapshot.hasData){
                final productsCart = snapshot.data?.docs;
                for(var productCart in productsCart!){
                  final nameProduct = productCart.get('nameProduct');
                  final imageProduct = productCart.get('image');
                  final price = productCart.get('price');
                  final cartWidget = CartContainer(
                    price: price,
                    image: imageProduct,
                    title: nameProduct,
                  );

                  productOfCart.add(cartWidget);
                }
              }
          }

          return productOfCart.isNotEmpty?ListView(
            children: productOfCartWithoutRepeat = productOfCart.where((element) => unique.add(element)).toList(),
          ):Center(child: Text("You don't have any Product",style: TextStyle(color: Colors.black87 , fontSize: 20),),);
        },
      ),
    );
  }
}