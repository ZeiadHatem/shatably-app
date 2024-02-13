import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shatably/detailsScreens/CartScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstBtn extends StatelessWidget{

  String text;
  Color color;
  VoidCallback onPressed;

  FirstBtn({required this.text , required this.color , required this.onPressed});

  Widget build(BuildContext context){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(60) , borderSide: BorderSide.none),
          elevation: 5,
          color: color,
          child: MaterialButton(
            child: Text(text , style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: "Cairo-VariableFont_wght.ttf",
              fontSize: 20,
              color: Colors.white
            ),),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}


class FacebookBtn extends StatelessWidget{

  String text;
  VoidCallback onPressed;
  Color color;


  FacebookBtn({required this.color , required this.text , required this.onPressed});

  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            shape: StadiumBorder(),
            elevation: 5,
            color: color,

            child: MaterialButton(
              height: 50,
              child:Text(text , style: TextStyle(fontSize: 30 , color:Colors.white),),
              onPressed: onPressed,
            ),
          ),
        ],
      ),
    );
  }
}


class GoogleBtn extends StatelessWidget{

  Color color;
  VoidCallback onPressed;
  String text;

  GoogleBtn({required this.color , required this.onPressed , required this.text});

  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            shape: StadiumBorder(),
            elevation: 5,
            color: color,

            child: MaterialButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset("tools/images/GoogleSignIn.jpg" , width: 50,),
                  Text(text , style: TextStyle(fontSize: 20 , color: Colors.white),)
                ],
              ),
              onPressed: onPressed,
            ),
          )
        ],
      ),
    );
  }
}


class ButtonS extends StatelessWidget{

  Color color1;
  String text;
  Icon icon;
  VoidCallback onPressed;

  ButtonS({required this.text , required this.icon ,required this.onPressed , required this.color1});

  Widget build(BuildContext context){
    return Material(
      color: Colors.transparent,
      child: MaterialButton(
        shape: StadiumBorder(),
        splashColor: color1,
        child: Row(

          children: [
            icon,
          SizedBox(width: 30,),
          Text(text , style: Theme.of(context).textTheme.titleSmall,)
          ],
        ) ,
        onPressed: onPressed,
      ),
    );
  }
}

class HomePageBtn extends StatelessWidget{

  final Color color;
  final Image;
  VoidCallback onPressed;

  HomePageBtn({required this.Image , required this.color , required this.onPressed});


  Widget build(BuildContext context){
    return MaterialButton(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide.none),
      elevation: 5,
      height: 50,
      onPressed: onPressed,
      color: color,
      child: Image,
    );
  }
}

class CartBtn extends StatelessWidget{

  Widget build(BuildContext context){
    return IconButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
        }, icon: Icon(Icons.shopping_cart_rounded) , color: Colors.greenAccent,);
  }
}

class DetailsBtn extends StatelessWidget{

  final VoidCallback press;
  final Icon icon;

  const DetailsBtn({required this.icon , required this.press});

  Widget build(BuildContext context){
    return FloatingActionButton(
      splashColor: Colors.indigo,
      onPressed: press,
      child: icon,
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo)),
    );
  }
}

class CallBtn extends StatelessWidget{

  final colorIcon;
  final colorText;

  CallBtn({required this.colorIcon , required this.colorText});


  Widget build(BuildContext context){
    return Material(
      color: Colors.transparent,
      child: MaterialButton(
        shape: StadiumBorder(),
        splashColor: Colors.black87,
        child: Row(

          children: [
            Icon(CupertinoIcons.phone , color: colorIcon,),
            Text('Call Us' , style: TextStyle(
                fontFamily: 'Cairo-VariableFont_wght.ttf',
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: colorText
            ),)
          ],
        ) ,
        onPressed: ()async{
          try{
            Uri phone = Uri(
                scheme: 'tel',
                path: '01028236589'
            );
            await launchUrl(phone);
          }
          catch(e){
            debugPrint(e.toString());
          }
        },
      ),
    );
  }
}