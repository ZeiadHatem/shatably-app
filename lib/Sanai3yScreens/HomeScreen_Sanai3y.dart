import 'package:flutter/material.dart';
import 'package:shatably/detailsScreens/DetailsPage.dart';
import 'package:shatably/tools/Products.dart';
import 'package:shatably/tools/Widgets.dart';


class HomeScreen_Sanai3y extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[860],

      body: Column(
          children: [
            Text("Materials For Your Work" , style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 30,
              fontFamily: 'Cairo-VariableFont_wght.ttf',
              color: Colors.indigo,
              fontWeight: FontWeight.bold
            ),),

            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context , index)=>MaterialsContainer(
                            products: products[index],
                            itemIndex: index,
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  DetailsPage(products: products[index])));
                            }
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}