import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shatably/detailsScreens/DetailsPage.dart';
import 'package:shatably/tools/Products.dart';
import 'package:shatably/tools/Widgets.dart';


class SearchPage extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Search for Your Product" , style: TextStyle(
            fontFamily: "Cairo-VariableFont_wght.ttf",
            fontSize: 30,
            color: Colors.greenAccent,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.italic
        ),),

        actions: [
          IconButton(
              onPressed: (){
                showSearch(context: context, delegate: SearchIcon());
              },
              icon: Icon(CupertinoIcons.search)
          )
        ],
      ),
      
      body: ListView.builder(
        //list of some suggetion product in search not all.
           itemCount: products.length-8,
          itemBuilder: (context , index)=>
              MaterialsContainer(
                  products: products[index], 
                  itemIndex: index, 
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(products: products[index])));
                  }
              )
      ),
    );
  }
}

