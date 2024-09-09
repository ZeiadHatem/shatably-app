import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shatably/detailsScreens/CarpentryPage.dart';
import 'package:shatably/detailsScreens/MaterialPage.dart';
import 'package:shatably/detailsScreens/PaintPage.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Widgets.dart';

import '../detailsScreens/BlackSmithPage.dart';
import '../detailsScreens/ElectricityPage.dart';
import '../detailsScreens/PlumbingPage.dart';

//Screen to show the options in my program

class CategoryPage extends StatelessWidget{
   //late final Function press;

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Category" , style: TextStyle(
              fontFamily: "Cairo-VariableFont_wght.ttf",
              fontSize: 30,
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold
            ),),

            CartBtn()
          ],
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CarpentryPage()));
                      },
                      child: Stack(
                        children: [
                          Containers(color: Colors.greenAccent),
                          Positioned(
                            top: 0,
                              left: 0,
                              child: Image.asset("tools/images/CategoriesImages/carpenters.png" , height: 100,width: 100,)
                          ),
                          PositionedText(text: "Carpentry")
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BlackSmithPage()));
                      },
                      child: Stack(
                        children: [
                          Containers(color: Colors.lightBlueAccent),
                          Positioned(
                            top: 0,
                              left: 0,
                              child: Image.asset("tools/images/CategoriesImages/blacksmith.png" , height: 100,width: 100,)
                          ),
                          PositionedText(text: "BlackSmith")
                        ],
                      ),
                    ),
                  ],
                )
            ),
            
            Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ElectricityPage()));
                      },
                      child: Stack(
                        children: [
                          Containers(color: Colors.cyanAccent),
                          Positioned(
                            top: 0,
                              left: 0,
                              child: Image.asset("tools/images/CategoriesImages/Electericity.png" , height: 100,width: 100,)
                          ),
                          PositionedText(text: "Electricity")
                        ],
                      ),
                    ),

                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PaintPage()));
                      },
                      child: Stack(
                        children: [
                          Containers(color: Colors.tealAccent),

                          Positioned(
                            top: 0,
                              left: 0,
                              child: Image.asset('tools/images/CategoriesImages/Paint.png',height: 100,width: 100,)
                          ),
                          PositionedText(text: "Paint")
                        ],
                      ),
                    )
                  ],
                )
            ),

            Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>PlumbingPage()));
                      },
                      child: Stack(
                        children: [
                          Containers(color: Colors.redAccent),
                          Positioned(
                            top: 0,
                              left: 0,
                              child: Image.asset('tools/images/CategoriesImages/plumbing.png' , height: 100,width: 100,)
                          ),
                          PositionedText(text: "Plumbing")
                        ],
                      ),
                    ),
                    
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MaterialsPage()));
                      },
                      child: Stack(
                        children: [
                          Containers(color: Colors.purpleAccent),
                          Positioned(
                            top: 15,
                              left: 0,
                              child: Image.asset('tools/images/CategoriesImages/Material.png',width: 100,height: 100,)
                          ),
                          PositionedText(text: "Materials")
                        ],
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
