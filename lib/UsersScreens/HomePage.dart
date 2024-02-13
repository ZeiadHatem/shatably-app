import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shatably/detailsScreens/BlackSmithPage.dart';
import 'package:shatably/detailsScreens/ElectricityPage.dart';
import 'package:shatably/detailsScreens/MaterialPage.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Widgets.dart';
import 'package:shatably/tools/Products.dart';

import '../detailsScreens/CartScreen.dart';

class HomePage extends StatefulWidget{

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User CurrentUser;
  final Auth =  FirebaseAuth.instance;

  @override
  void initState() {
    getUser();
    getImage();
    super.initState();
  }

  getUser(){

    final User = Auth.currentUser;
    if(User != null){
      CurrentUser = User;
    }
  }

  getImage(){
    ImageHomeStreamBuilder();
  }


  Widget build(BuildContext context){

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: Scaffold(

        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 40 ,horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discover" , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: 'Cairo-VariableFont_wght.ttf',
                    color: Colors.black87
                  ),),

                  Row(
                    children: [
                      IconButton(
                          onPressed: (){
                            showSearch(context: context, delegate: SearchIcon());
                          },
                          icon: Icon(Icons.search , size: 35,)
                      ),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.notifications_none_outlined , size: 35,)
                      ),

                      IconButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
                          },
                          icon: Icon(Icons.shopping_cart_rounded , size: 35,)
                      ),

                      SizedBox(width: 10,),

                      ImageHomeStreamBuilder(),
                    ],
                  )
                ],
              ),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(offset: Offset(0,15) , blurRadius: 25 , color: Colors.white)
                  ]
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ContainerHomePage(
                        colorbackground: Colors.white,
                        image: Image(image: AssetImage('tools/images/ContainersSales/sales.gif'),),
                        image2: Image(image: AssetImage('tools/images/ContainersSales/lastchance.gif'),),
                        text: 'BLACK FRIDAY SALE',
                        colorText: Colors.black87,
                        image3: Image.asset('tools/images/CategoriesImages/Paint.png',height: 100,width: 150,)
                    ),

                    SizedBox(width: 10,),

                    ContainerHomePage(
                      colorbackground: Colors.red ,
                      image: Image.asset("tools/images/ContainersSales/sale.png" ,height: 100,width: 100,),
                      image2: Image.asset('tools/images/ContainersSales/ramadankareem.png' , height: 100,width: 200,),
                      image3: Image.asset("tools/images/CategoriesImages/Material.png"  ,height: 100,width: 100,),
                      text: "SPECIAL OFFER 35% OFF",
                      colorText: Colors.white,
                    ),

                    SizedBox(width: 10,),

                    ContainerHomePage(
                        colorbackground: Colors.lightBlueAccent,
                        image: Image.asset('tools/images/ContainersSales/sale3.png',height: 100,width: 200,),
                        image2: Image.asset('tools/images/ContainersSales/bestSale.png' , height: 100,width: 100,),
                        text: 'SALE 70% OFF CARPENTRY',
                        image3: Image.asset('tools/images/CategoriesImages/carpenters.png' , height: 90,width: 90,),
                        colorText: Colors.white
                    )
                  ],
                ),
              ),

              SizedBox(height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomePageBtn(
                      Image: Image.asset('tools/images/CategoriesImages/blacksmith.png' , height: 50,width: 50,),
                      color: Colors.lightBlueAccent,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>BlackSmithPage()));
                      },
                  ),

                  HomePageBtn(
                      Image: Image.asset('tools/images/CategoriesImages/Electericity.png' , height: 50,width: 50,),
                      color: Colors.cyanAccent,
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ElectricityPage()));
                      },
                  ),

                  HomePageBtn(
                      Image:Image.asset('tools/images/CategoriesImages/Material.png' , height: 50,width: 50,) ,
                      color: Colors.purpleAccent,
                      onPressed:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>MaterialsPage()));
                      }
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Deals of The Day" , style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Cairo-VariableFont_wght.ttf',
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                  ),),
                ],
              ),
              SizedBox(height: 10,),

                  Container(
                    height: 150,
                    width: 400,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        /*boxShadow: [
                          BoxShadow(offset: Offset(0,15) , blurRadius: 25 , color: Colors.black26)
                        ]*/
                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length-6,
                        itemBuilder: (context , index)=>ContainerProduct(
                            products: products[index],
                            itemIndex: index
                        )
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}