import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shatably/detailsScreens/DetailsPage.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Widgets.dart';
import 'package:shatably/tools/Products.dart';

class MaterialsPage extends StatefulWidget{

  @override
  State<MaterialsPage> createState() => _MaterialsPageState();
}

class _MaterialsPageState extends State<MaterialsPage> {

  //GlobalKey<ScaffoldState> keyDrawer = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context){

    return Scaffold(

      drawer: DrawerDetails(),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Materials' , style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo-VariableFont_wght.ttf',
              fontSize: 40,
              color: Colors.greenAccent,
              fontStyle: FontStyle.italic
            ),),

            CartBtn()
          ],
        ),
      ),

      backgroundColor: Colors.indigo,

      body: SafeArea(
        child: Expanded(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40)
                    ,topRight: Radius.circular(40))
                ),
              ),

              ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context , index)=>MaterialsContainer(
                    itemIndex: index,
                    products: products[index],
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>
                      DetailsPage(products: products[index])));
                    },
                  )
              )
            ],
          ),
        )
      ),
    );
  }
}