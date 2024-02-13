
import 'package:flutter/cupertino.dart';
import 'package:shatably/tools/Widgets.dart';

class Products{

final int  price , id , number , offerPrice , sale;
final String title , subTitle , descrip , image;

Products({
  required this.sale,
  required this.offerPrice,
  required this.number,
  required this.id,
  required this.title,
  required this.subTitle,
  required this.descrip,
  required this.price,
  required this.image
});
}

List<Products> products = [
  Products(
      id: 1,
      title: 'Paint Brush',
      subTitle: 'Coating Brush for Painting',
      descrip: 'This brush offers easy to paint your home walls',
      price: 120,
      image: 'tools/images/ProductImages/paintbruch.png',
      number: 10,
      offerPrice: 60,
      sale: 50
  ),

  Products(
      id: 2,
      title: 'Roller',
      subTitle: 'Roller for painting high walls',
      descrip: 'Roller helps you in high wall paint',
      price: 350,
      image: 'tools/images/ProductImages/roller.png',
     number: 6,
     offerPrice: 200,
     sale: 10
  ),

  Products(
      id: 3,
      title: 'Plug Socket',
      subTitle: 'Plug Socket',
      descrip: ' plug Socket stunned and good materials',
      price: 15,
      image: 'tools/images/ProductImages/plug socket.png',
     number: 9,
     offerPrice: 5,
     sale: 70
  ),

  Products(
      id: 4,
      title: 'Screwdriver',
      subTitle: 'Cross Screwdriver',
      descrip: 'Metal screwdriver for cross screws',
      price: 50,
      image: 'tools/images/ProductImages/screwdriver.png',
      number: 0,
      offerPrice: 30,
      sale: 15
  ),

  Products(
      id: 5,
      title: 'Pliers',
      subTitle: 'Pliers for Cutting',
      descrip: 'Good-made pliers and great price',
      price: 75,
      image: 'tools/images/ProductImages/pliers.png',
      number: 15,
      offerPrice: 50,
      sale: 10
  ),

  Products(
      id: 6,
      title: 'Spray Black',
      subTitle: 'Spray Black color for painting',
      descrip: 'Spray Black color shiny for paint gives you an attractive appearance '
          'for walls and facilitates mixing with several colors',
      price: 500,
      image: 'tools/images/ProductImages/spray black.png',
      number: 25,
      offerPrice: 350,
      sale: 20
  ),

  Products(
      id: 7,
      title: 'Welding Tape',
      subTitle: 'Wide Welding Tape',
      descrip: 'Wide welding tape with solid sign',
      price: 110,
      image: 'tools/images/ProductImages/welding tape.png',
      number: 100,
      offerPrice: 90,
      sale: 2
  ),

  Products(
      id: 8,
      title: 'Saw',
      subTitle: 'Wood cutting saw',
      descrip: 'Saw for cutting weapons from strong iron',
      price: 255,
      image: 'tools/images/ProductImages/saw.png',
      number: 5,
      offerPrice: 200,
      sale: 5
  ),

  Products(
      id: 9,
      title: 'Plank',
      subTitle: 'Wood Plank for wood works',
      descrip: 'Wood plank for wood works 2 meters from beech wood',
      price: 310,
      image: 'tools/images/ProductImages/plank.png',
      number: 17,
      offerPrice: 210,
      sale: 10
  ),

  Products(
      id: 10,
      title: 'Faucet Mixer',
      subTitle: 'faucet mixer for bathroom',
      descrip: 'Faucet Mixer of stainless steel aluminum for bathroom',
      price: 1200,
      image: 'tools/images/ProductImages/Faucet Mixer.png',
      number: 25,
      offerPrice: 900,
      sale: 7
  ),

  Products(
      id: 11,
      title: 'Water Pipes',
      subTitle: 'Plastic Water Pipes',
      descrip: 'Plastic Water Pipes for plumbing works 1 Meter',
      price: 200,
      image: 'tools/images/ProductImages/water pipe.png',
      number: 7,
      offerPrice: 150,
      sale: 10
  ),

  Products(
      id: 12,
      title: 'blue Color',
      subTitle: 'Blue Color for painting',
      descrip: 'Blue color shiny for paint gives you an attractive appearance '
          'for walls and facilitates mixing with several colors',
      price: 620,
      image: 'tools/images/ProductImages/blueColor.png',
      number: 19,
      offerPrice: 500,
      sale: 10
  )

];

List<String> item = [
  "PaintBrush",
  "Roller",
  "PLug Socket",
  "Blue Color"
];

class Sanai3yInfo {
  String phone;
  String job;
  Sanai3yInfo({required this.job  ,required this.phone});
}

List<Sanai3yContainer> carpenters = [];

List<Sanai3yContainer> smith=[];

List<Sanai3yContainer> electrical=[];

List<Sanai3yContainer> paint = [];

List<Sanai3yContainer> plumber = [];
