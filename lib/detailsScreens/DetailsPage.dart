import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shatably/UsersScreens/NavigationBar1.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Products.dart';
import 'package:shatably/tools/Widgets.dart';
import 'package:url_launcher/url_launcher.dart';



class DetailsPage extends StatefulWidget{
  final Products products;


   DetailsPage({required this.products});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late dynamic rating;
  late String comment;
  dynamic image;
  List<Widget> ratingProduct = [];
  var _fireStore = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  final rateText = TextEditingController();
  var rates;
  var unique = Set<Widget>();
  var name;
  List<Widget> ratingProductWithoutRepeat = [];
  var nameRater;
  var imageRater;

  Widget build(BuildContext context){

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Details" , style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              fontFamily: 'Cairo-VariableFont_wght.ttf',
              fontStyle: FontStyle.italic,
              color: Colors.greenAccent
            ),),
            CartBtn()
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ProductImage(
                          size: size,
                          image: widget.products.image
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.products.title , style:TextStyle(
                            fontFamily: "Cairo-VariableFont_wght.ttf",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.greenAccent
                          ),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Price:${widget.products.price}" ,
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  fontFamily: 'Cairo-VariableFont_wght.ttf',
                                  color: Colors.greenAccent
                                )),

                              SizedBox(height: 20,),

                              RatingStreamBuilder()

                            ],
                          ),

                        ],
                      ),
                    ),

                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),


                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.products.subTitle ,
                      style: Theme.of(context).textTheme.titleSmall ,
                    ),
                    Text(widget.products.descrip ,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        fontFamily: 'Cairo-VariableFont_wght.ttf',
                        color: Colors.red
                      ) ,
                    )
                  ],
                ),
              ),
              TitleDetailsContainer(text: "PROMOTIONS"),
              ExtraContainer(
                icon: Icon(Icons.flight),
                text: 'Free shopping Nationwide on orders above 200 \nEGP',
              ),
              ExtraContainer(
                  icon: Icon(Icons.stars_rounded),
                  text: 'Enjoy installments from 6 months to 60 months\n'
                      'with valu'
              ),
              ExtraContainer(
                  icon: Icon(Icons.shield),
                  text: 'Safety and protection for you'
              ),

              TitleDetailsContainer(text: "VERIFIED CUSTOMER FEEDBACK"),
              Center(
                child: RatingBar.builder(
                    allowHalfRating: true,
                    itemBuilder: (context , _)=>Icon(
                      CupertinoIcons.star_fill,
                      color: Colors.black87,
                    ),
                    onRatingUpdate: (value){
                      rating = value;
                    }

                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                child: TextField(
                  onChanged: (text){
                    comment = text;
                  },
                  controller: rateText,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Write Comment',
                    border: OutlineInputBorder()
                  ),
                ),
              ),

              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 40),
                child: FirstBtn(
                    text: "Done!",
                    color: Colors.red,
                    onPressed: ()async{
                        rateText.clear();
                        FocusManager.instance.primaryFocus?.unfocus();
                        await for(var data in _fireStore.collection('Accounts').snapshots()){
                          for(var user in data.docs){
                            final email = user.get('Email');
                            if(FirebaseAuth.instance.currentUser?.email==email){
                              nameRater = user.get('UserName');
                              imageRater = user.get('image');

                              _fireStore.collection('RatingCustomer').add({
                                'star':rating,
                                'comment': comment,
                                'email' : email,
                                'name' :currentUser!.displayName==null?nameRater:currentUser!.displayName,
                                'image' : currentUser!.photoURL==null?imageRater:currentUser!.photoURL
                              });
                            }
                          }
                        }
                    }
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                 stream: _fireStore.collection('RatingCustomer').snapshots(),
                  builder: (context , Snapshot){
                   if(Snapshot.hasData){
                     rates = Snapshot.data?.docs;
                     for(var rate in rates!){

                       final comment = rate.get('comment');
                       final star = rate.get('star');
                       name = rate.get('name');
                       image = rate.get('image');

                       if(comment!=null && star!=null){

                         ratingProduct.add(ListTile(

                           leading: image==null? CircleAvatar(child: Icon(CupertinoIcons.person))
                               :CircleAvatar(backgroundImage: NetworkImage(image)),
                           //title: Text('${name}' , style: TextStyle(color: Colors.black87),),
                           subtitle: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               RatingBarIndicator(
                                 itemBuilder: (context , _)=>Icon(
                                   CupertinoIcons.star_fill,
                                   color: Colors.black87,
                                 ),
                                 rating: star,
                                 itemSize: 20,
                               ),

                               Text('$comment' , style: Theme.of(context).textTheme.titleLarge,)
                             ],
                           ),
                         ));


                       }
                     }
                   }

                    return Padding(
                      padding:  EdgeInsets.all(10),
                      child: Column(
                        children: ratingProductWithoutRepeat = ratingProduct.where((element) => unique.add(element)).toList(),
                      ),
                    );
                  }
              ),

              TitleDetailsContainer(text: 'OFFERS FOR YOU'),

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
                    itemCount: products.length,
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
      floatingActionButton:Padding(
        padding: EdgeInsets.only(left: 30),
        child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(offset: Offset(0,15) , blurRadius: 25 , color: Colors.black12)
            ]
          ),
          child: Row(

            children: [

              SizedBox(width: 20,),
              DetailsBtn(
                  icon: Icon(Icons.home_rounded , color: Color.fromARGB(255, 12, 0, 136),),
                  press: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationBar1()));
                  }
              ),

              SizedBox(width: 20,),

              DetailsBtn(
                  icon: Icon(Icons.phone , color: Color.fromARGB(255, 12, 0, 136),),
                  press: ()async{
                    try
                    {
                      Uri phone = Uri(
                        scheme: 'tel',
                        path: "01028236589",
                      );

                      await launchUrl(phone);
                    }
                    catch(e) {
                      debugPrint(e.toString());
                    }
                  }
              ),

              SizedBox(width: 20,),

              MaterialButton(
                  shape: OutlineInputBorder(borderSide: BorderSide(color: Colors.indigo)),
                  onPressed: (){
                    try{
                      _fireStore.collection('Shopping').doc(currentUser?.email).collection('ShoppingProducts').doc().set({
                        'email' : FirebaseAuth.instance.currentUser?.email,
                        'image' : widget.products.image,
                        'nameProduct' : widget.products.title,
                        'price' : widget.products.price,
                        'id' : widget.products.id,
                        'time' : FieldValue.serverTimestamp()
                      });

                      Fluttertoast.showToast(
                          msg: 'Product Save in Cart',
                        backgroundColor: Colors.black87,
                        textColor: Colors.white
                      );
                    }
                    catch(e){
                      print(e);
                    }
                  },
                 color: Colors.indigo,
                height: 50,
                 child: Row(
                   children: [
                     Icon(Icons.shopping_cart , color: Colors.greenAccent,size: 30,),
                     Text("Add To Cart" , style: TextStyle(
                       fontFamily: 'Cairo-VariableFont_wght.ttf',
                       fontSize: 20,
                       fontWeight: FontWeight.bold,
                       color: Colors.white
                     ),)
                   ],
                 ),
              )
            ],
          ),
        ),
      ),
    );
  }
}