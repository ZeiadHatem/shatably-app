import 'package:flutter/material.dart';
import 'package:shatably/UsersScreens/Category.dart';
import 'package:shatably/UsersScreens/HomePage.dart';
import 'package:shatably/UsersScreens/Settings.dart';
import 'package:shatably/tools/Products.dart';

import 'Chat Screen Home.dart';
import 'SearchPage.dart';


class NavigationBar1 extends StatefulWidget{
  static String screenR = "NavigationBar1";

  @override
  State<NavigationBar1> createState() => _NavigationBar1();
}
class _NavigationBar1 extends State<NavigationBar1> {
  int currentPage = 2;

  Widget build(BuildContext context){

    final dynamic Pages = [
       CategoryPage()
      ,SearchPage()
      ,HomePage(),
       ChatScreenHome()
      ,SettingsPage()
    ];

    return Scaffold(
      body: Pages[currentPage],
      bottomNavigationBar:NavigationBar(
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.category_outlined , color: Colors.white,),
                label: "Category",
                selectedIcon: Icon(Icons.category_rounded , color: Colors.black87,),
            ),

            NavigationDestination(
                icon: Icon(Icons.search  ,color: Colors.white,),
                label: "Search",
              selectedIcon: Icon(Icons.search , color: Colors.black87,),
            ),

            NavigationDestination(
                icon: Icon(Icons.home_outlined  ,color: Colors.white,),
                label: "Home",
                selectedIcon: Icon(Icons.home , color: Colors.black87,),
            ),

            NavigationDestination(
                icon: Icon(Icons.chat_outlined , color: Colors.white,),
                label: "Chat",
                selectedIcon: Icon(Icons.chat , color: Colors.black87,),
            ),
            NavigationDestination(

                icon: Icon(Icons.settings_rounded , color: Colors.white,),
                label: "Settings",
              selectedIcon: Icon(Icons.settings_rounded  ,color: Colors.black87,),


            )
          ],
              selectedIndex: currentPage,
               backgroundColor: Colors.indigo,
               labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
               animationDuration: Duration(milliseconds: 1000),
               height: 70,
              onDestinationSelected: (int index){
                setState(() {
                  currentPage = index;
                });
              },
      ),
    );
  }
}