import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shatably/detailsScreens/BlackSmithPage.dart';
import 'package:shatably/detailsScreens/CarpentryPage.dart';
import 'package:shatably/detailsScreens/ChatPage.dart';
import 'package:shatably/detailsScreens/DetailsPage.dart';
import 'package:shatably/detailsScreens/ElectricityPage.dart';
import 'package:shatably/detailsScreens/PaintPage.dart';
import 'package:shatably/detailsScreens/PaymentPage.dart';
import 'package:shatably/detailsScreens/PlumbingPage.dart';
import 'package:shatably/detailsScreens/Profile_Page.dart';
import 'package:shatably/tools/Products.dart';
import '../detailsScreens/MaterialPage.dart';
import 'Buttons.dart';

class Containers extends StatelessWidget{

  Color color;
  Containers({required this.color});

  Widget build(BuildContext context){

    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 100,
      width: 170,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(offset: Offset(0,15) , blurRadius: 25 , color: Colors.black26)
          ]
      ),
    );
  }
}



class PositionedText extends StatelessWidget{

  String text;

  PositionedText({required this.text});

  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Positioned(
      right: 0,
        bottom: 0,
        child: SizedBox(
          height: 80,
          width: size.width-290,
          child: Column(
            children: [
                Text(text , style: Theme.of(context).textTheme.titleSmall,)
            ],
          ),
        )
    );
  }
}

class ContainerHomePage extends StatelessWidget{

  final Color colorbackground;
  final String text;
  final Image image;
  final Image image2;
  final Image image3;
  final Color colorText;

  ContainerHomePage({
    required this.colorbackground ,
    required this.image ,
    required this.image2,
    required this.text,
    required this.image3,
    required this.colorText
  });

  Widget build(BuildContext context){

    return Container(
      height: 200,
      width: 350,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: colorbackground,
          boxShadow: [
            BoxShadow(offset: Offset(0,15) , blurRadius: 25 , color: Colors.white)
          ]
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 image,
                  image2
                ],
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text(text,style: TextStyle(
                  //fontFamily: "Cairo-VariableFont_wght.ttf",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorText,
                    fontStyle: FontStyle.italic
                ),),
                image3
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ContainerProduct extends StatelessWidget{

  final Products products;
  final int itemIndex;

  ContainerProduct({required this.products,required this.itemIndex});

  Widget build(BuildContext context){

    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            //margin: EdgeInsets.symmetric(horizontal: 10),
            height: 120,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(offset: Offset(0,5) , blurRadius: 5 , color: Colors.black26)
              ]
            ),
          ),
        ),
        Positioned(
          top: 0,
            left: 0,
            child: Image.asset(products.image , height: 150,width: 90)
        ),

        Positioned(
          bottom: 0,
            right: 0,
            child: SizedBox(
              height: 130,
              width: size.width-230,
              child: Column(
                children: [
                  Text(products.title , style: TextStyle(
                      fontFamily: 'Cairo-VariableFont_wght.ttf',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo
                  ),),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Text("${products.sale}%",style: TextStyle(
                          fontFamily: 'Cairo-VariableFont_wght.ttf',
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                        ),),

                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(22)
                          ),
                          child:Text("Price ${products.price}\$",style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontFamily: 'Cairo-VariableFont_wght.ttf',
                            fontSize: 15,
                            color: Colors.white
                          ),) ,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10 ),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(22)
                    ),
                    child: Text('Price: ${products.offerPrice}\$' , style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15 ,
                        fontFamily: 'Cairo-VariableFont_wght.ttf',
                       color: Colors.white
                    ),),
                  )
                ],
              ),
            )
        )
      ],
    );
  }
}

class MaterialsContainer extends StatelessWidget{

  final int itemIndex;
  final Products products;
  final VoidCallback onPressed;

  MaterialsContainer({required this.products , required this.itemIndex , required this.onPressed});

  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10 ,horizontal: 20),
      height: 190,

      child: InkWell(
        onTap: onPressed,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(offset: Offset(0,15) , blurRadius: 25 , color: Colors.black26)
                ]
              ),
            ),
            Positioned(
              top: 0,
                left: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 170,
                    width: 160,
                    child: Image.asset(products.image , fit: BoxFit.contain,)
                ),
            ),

            Positioned(
              top: 0,
              bottom: 0,
                right: 0,
                child: SizedBox(
                  height: 100,
                  width: size.width-200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Spacer(),

                      Text(products.title ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo-VariableFont_wght.ttf',
                          fontSize: 20,
                          color: Colors.indigo
                        ) ,),

                      SizedBox(height: 10,),

                      Text(products.subTitle ,textAlign: TextAlign.center,style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo-VariableFont_wght.ttf',
                          fontSize: 15,
                          color: Colors.black87
                      ) , ),



                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20  ,vertical: 2.5),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(offset: Offset(0,5) , blurRadius: 5 , color: Colors.black26)
                            ]
                          ),
                          child: Text("Price: ${products.price}\$" ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Cairo-VariableFont_wght.ttf',
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}



class DrawerDetails extends StatefulWidget{

  @override
  State<DrawerDetails> createState() => _DrawerDetailsState();
}

class _DrawerDetailsState extends State<DrawerDetails> {
  late User currentUser;
  final Auth = FirebaseAuth.instance;
  var userName;
  var CurrentUser;
  final _fireStore = FirebaseFirestore.instance;
  var accountsUser ;
  var unique = Set<Text>();
  List<Text> usersWithoutRepeat=[];


  @override
  void initState() {
    getImage();
    super.initState();
  }

  getImage(){
    final User = Auth.currentUser;
    if(User!=null){
      setState(() {
        currentUser = User;

      });
    }
  }

  Widget build(BuildContext context){
    return Drawer(elevation: 10,
      shape: OutlineInputBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(40) )
          ,borderSide: BorderSide.none),

      child: Column(
        children: [
          DrawerHeader(
            padding: EdgeInsets.fromLTRB(16, 7, 16, 0),
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageStreamBuilder(),
                  ],
                ),
                SizedBox(height: 10,),

             StreamBuilder<QuerySnapshot>(
               stream: _fireStore.collection('Accounts').snapshots(),
                builder: (context , snapshot){
                 List<Text> accountUser = [];
                 switch(snapshot.connectionState){
                   case ConnectionState.waiting:
                   case ConnectionState.none:
                     return Center(child: CircularProgressIndicator(),);

                   case ConnectionState.done:
                   case ConnectionState.active:
                   if(snapshot.hasData){

                     accountsUser = snapshot.data?.docs;

                     for(var user in accountsUser!){

                       CurrentUser= user.get('Email');
                       userName = user.get('UserName');

                       if(currentUser.email==CurrentUser&&userName!=null){
                         accountUser.add(Text(userName , style: Theme.of(context).textTheme.bodyMedium,));
                       }
                     }
                   }
                   return Column(
                     children: [
                       userName!=null?Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: usersWithoutRepeat = accountUser.where((element) => unique.add(element)).toList()
                       ): Container(),

                       currentUser.displayName!=null? Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text("${currentUser.displayName}" , style: Theme.of(context).textTheme.bodyMedium,),
                         ],
                       ):Container()

                     ],
                   );
                 }
                }
             ),],),

            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(30) , bottomLeft: Radius.circular(30))
            ),
          ),

          ButtonS(
              text: "Carpentry",
              icon: Icon(Icons.carpenter_rounded),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CarpentryPage()));
              },
              color1: Colors.greenAccent
          ),

          ButtonS(
              text: "BlackSmith",
              icon: Icon(Icons.iron),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BlackSmithPage()));
              },
              color1: Colors.lightBlueAccent
          ),

          ButtonS(
              text: "Electricity",
              icon: Icon(Icons.electric_bolt),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ElectricityPage()));
              },
              color1: Colors.cyanAccent
          ),

          ButtonS(
              text: "Paint",
              icon: Icon(Icons.color_lens_rounded),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PaintPage()));
              },
              color1: Colors.tealAccent
          ),

          ButtonS(
              text: "Plumbing",
              icon: Icon(Icons.plumbing_outlined),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PlumbingPage()));
              },
              color1: Colors.red
          ),

          ButtonS(
              text: "Materials",
              icon: Icon(Icons.shopping_bag_rounded),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MaterialsPage()));
              },
              color1: Colors.purpleAccent
          ),


          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Colors.black87,
            ),
          )
          ,ButtonS(
              text: "Payment",
              icon: Icon(Icons.payment , color: Colors.greenAccent,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage()));
              },
              color1: Colors.greenAccent
          ),
          ButtonS(
              text: "Settings",
              icon: Icon(Icons.settings_rounded , color: Colors.lightBlueAccent,),
              onPressed: (){},
              color1: Colors.lightBlueAccent
          )
        ],
      ),);
  }
}



class Sanai3yContainer extends StatelessWidget {

  var userName;
  var job;
  var image;
  var phone;
  var email;
  Sanai3yContainer({required this.phone  ,required this.job , required this.image , required this.userName , required this.email});

  Widget build(BuildContext context){

    Size size = MediaQuery.of(context).size;

    return  Container(
      margin: EdgeInsets.symmetric(vertical:10 , horizontal: 20),
      height: 190,

      child: InkWell(
             onTap: (){

               Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage(sanai3yInfoContainer: Sanai3yInfoContainer(
                 image: image,
                 phone: phone,
                 job: job,
                 userName: userName,
               ), name: '$userName' , image: '$image', email: email,phone: phone,
               )));
             },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 166,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(offset: Offset(0,15) , blurRadius: 25 , color: Colors.black26)
                  ]
              ),
            ),

            Positioned(
              top: 10,
              left: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child:CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(image),
                )
              ) ,
            ),

            Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  height: 150,
                  width: size.width-230,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(userName , style: TextStyle(
                          fontFamily: 'Cairo-VariableFont_wght.ttf',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo
                      ),),

                      Text(phone, style: TextStyle(
                          fontFamily: 'Cairo-VariableFont_wght.ttf',
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),),

                      Text(job,style: TextStyle(
                          fontFamily: 'Cairo-VariableFont_wght.ttf',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo
                      ),),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

class ProductImage extends StatelessWidget{

  final String image;
  final Size size;

  ProductImage({required this.size , required this.image});

  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: size.width * 0.8,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: size.width*0.7,
            width: size.width*0.7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
          ),
          
          Image.asset(
            image,
            fit: BoxFit.contain,
            height: size.width*0.75,
            width: size.width*0.75,
          )
        ],
      ),
    );
  }
}

class TitleDetailsContainer extends StatelessWidget{

  final String text;

   TitleDetailsContainer({required this.text});

  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      child: Text(text ,textAlign: TextAlign.center, style: TextStyle(color: Colors.black38),),
      color: Colors.black12,
    );
  }
}

class ExtraContainer extends StatelessWidget{

  final String text;
  final Icon icon;

  const ExtraContainer({required this.icon , required this.text});
  
  Widget build(BuildContext context){
    return Container(
      color: Colors.white,
      child: Padding(
        padding:  EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              children: [
                icon,
                SizedBox(width: 20,),

                Text(text , style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    fontSize: 15,
                   fontFamily: 'Cairo-VariableFont_wght.ttf'
                ),)
              ],
            )
          ],
        ),
      ),
    );
  }
}

class  RatingStreamBuilder extends StatelessWidget{

  List<Widget> ratingProduct = [];
  var _fireStore = FirebaseFirestore.instance;
  var rates;
  var unique = Set<Widget>();
  List<Widget> ratingProductWithoutRepeat = [];

  Widget build(BuildContext context){

    return StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection('RatingCustomer').limit(1).snapshots(),
        builder: (context , Snapshot){

          if(Snapshot.hasData){
            rates = Snapshot.data?.docs;
            for(var rate in rates!){
              final star = rate.get('star');

              if(star!=null){

                ratingProduct.add(RatingBarIndicator(
                  itemSize: 20,
                  itemBuilder: (context , _)=>Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.black87,
                  ),
                  rating: star,
                ));
              }
            }
          }

          return Column(
            children: ratingProductWithoutRepeat = ratingProduct.where(
                    (rate) => unique.add(rate)).toList(),
          );
        }
    );
  }
}



class ImageStreamBuilder extends StatefulWidget{

  @override
  State<ImageStreamBuilder> createState() => _ImageStreamBuilderState();
}

class _ImageStreamBuilderState extends State<ImageStreamBuilder> {
  var currentUser;

  final _fireStore = FirebaseFirestore.instance;

  var imageUser;

  late User signedInUser ;

  final Auth = FirebaseAuth.instance;
  var imageUsers;

  @override
  void initState(){
    super.initState();
    //getUserName();
    getUser();
    //getImage();
  }

  getUser(){

    final User = Auth.currentUser;
    if(User != null){
      signedInUser = User;
    }
  }

  Widget build(BuildContext context){

    return StreamBuilder(
        stream: _fireStore.collection('Accounts').snapshots(),
        builder: (context ,  snapshot){
          if(snapshot.hasData){
            imageUsers  =snapshot.data?.docs;
            for(var image in imageUsers!){

              currentUser= image.get('Email');
              if(signedInUser.email==currentUser){
                imageUser = image.get('image');
              }
            }
          }

          return Positioned(
              top: 0,
              left: 0,
              child:Container(
                  child:Column(
                    children: [
                      imageUser!=null?
                      CircleAvatar(radius: 40,backgroundImage: NetworkImage(imageUser)):
                      CircleAvatar(radius: 40, backgroundImage: NetworkImage(signedInUser.photoURL.toString()),)

                    ],
                  )

              )
          );
        }
    );
  }
}



class ImageHomeStreamBuilder extends StatefulWidget{
  @override
  State<ImageHomeStreamBuilder> createState() => _ImageHomeStreamBuilderState();
}

class _ImageHomeStreamBuilderState extends State<ImageHomeStreamBuilder> {
  var currentUser;

  final _fireStore = FirebaseFirestore.instance;

  var imageUser;

  late User signedInUser ;

  final Auth = FirebaseAuth.instance;
  var imageUsers;

  @override
  void initState(){
    super.initState();
    getUser();
  }

  getUser(){

    final User = Auth.currentUser;
    if(User != null){
      signedInUser = User;
    }
  }

  Widget build(BuildContext context){

    return StreamBuilder(
        stream: _fireStore.collection('Accounts').snapshots(),
        builder: (context ,  snapshot){

          if(snapshot.hasData){
            imageUsers  =snapshot.data?.docs;
            for(var image in imageUsers!){

              currentUser= image.get('Email');
              if(signedInUser.email==currentUser){
                imageUser = image.get('image');
              }
            }
          }

          return Positioned(
              top: 0,
              left: 0,
              child:Container(
                  child:Column(
                    children: [
                      imageUser!=null?
                      CircleAvatar(radius: 25,backgroundImage: NetworkImage(imageUser)):
                      CircleAvatar(radius: 25, backgroundImage: NetworkImage(signedInUser.photoURL.toString()),)

                    ],
                  )

              )
          );
        }
    );
  }
}



class InfoSanai3yStreamBuilder extends StatefulWidget{

  State<InfoSanai3yStreamBuilder> createState()=> _InfoSanai3yStreamBuilder();
}

class _InfoSanai3yStreamBuilder extends State<InfoSanai3yStreamBuilder>{
  final _fireStore = FirebaseFirestore.instance;
  final Auth = FirebaseAuth.instance;
  var currentUser;
  var image;
  var userName;
  var job;
  var phone;
  late User signedInUser;
  var unique = Set<Widget>();
  var listAcountWithoutRepeat = [];
  var imageSanai3ya;


  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser(){

    final User = Auth.currentUser;
    if(User != null){
      signedInUser = User;
    }
  }

  Widget build(BuildContext context){

    return StreamBuilder(
        stream: _fireStore.collection('Sanai3yAccounts').snapshots(),
        builder: (context , snapshot){
          List<Widget> listAccount=[];

          switch(snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);

            case ConnectionState.done:
            case ConnectionState.active:
            if(snapshot.hasData){
              imageSanai3ya = snapshot.data?.docs;
              for(var imageSanai3y in imageSanai3ya!){

                currentUser = imageSanai3y.get('email');
                userName = imageSanai3y.get("userName");
                if(signedInUser.email==currentUser){
                  image = imageSanai3y.get('image');
                  job = imageSanai3y.get('job');
                  phone = imageSanai3y.get('phone');
                  listAccount.add(Text('$userName' , style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Cairo-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold
                  ),));
                }
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Positioned(
                    child: Container(
                      child: CircleAvatar(radius: 60,backgroundImage: NetworkImage(image),),
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Positioned(
                      top: 140,
                      left: 10,
                      child: Column(
                        children: listAcountWithoutRepeat = listAccount
                            .where((element) => unique.add(element)).toList(),
                      ),
                    ),

                    //SizedBox(width: 50,),

                    Column(
                      children: [
                        Positioned(
                            child: Text('Phone: $phone' , style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Cairo-VariableFont_wght.ttf',
                                fontWeight: FontWeight.bold,
                                color: Colors.cyan[900]
                            ),)
                        ),

                        Positioned(
                            child: Text('Job: $job' , style: TextStyle(
                                fontSize: 17,
                                fontFamily: 'Cairo-VariableFont_wght.ttf',
                                fontWeight: FontWeight.bold,
                                color: Colors.red[900]
                            ),)
                        )
                      ],
                    )
                  ],
                )
              ],
            );
          }
        }
    );
  }
}



class ImageSanai3yStreamBuilder2 extends StatefulWidget{
  @override
  State<ImageSanai3yStreamBuilder2> createState() => _ImageSanai3yStreamBuilder2State();
}

class _ImageSanai3yStreamBuilder2State extends State<ImageSanai3yStreamBuilder2> {
  final _fireStore = FirebaseFirestore.instance;

  var currentUser;

  var image;

  late User signedInUser;

  final Auth = FirebaseAuth.instance;
  var imageSanai3ya;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser(){

    final User = Auth.currentUser;
    if(User != null){
      signedInUser = User;
    }
  }

  Widget build(BuildContext context){
    return StreamBuilder(
        stream: _fireStore.collection('Sanai3yAccounts').snapshots(),
        builder: (context , snapshot){
          //List<Widget> listAccount=[];

          switch(snapshot.connectionState){

            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator(),);

            case ConnectionState.done:
            case ConnectionState.active:
            if(snapshot.hasData){
              imageSanai3ya = snapshot.data?.docs;
              for(var imageSanai3y in imageSanai3ya!){

                currentUser = imageSanai3y.get('email');
                if(signedInUser.email==currentUser){
                  image = imageSanai3y.get('image');

                }
              }
            }


            return Positioned(
                child: Container(
                  child: CircleAvatar(radius: 25,backgroundImage: NetworkImage(image),),
                )
            );
          }
        }
    );
  }
}



class PostSanai3yContainer extends StatelessWidget{

  final Auth = FirebaseAuth.instance;
  var name;
  var imagePost;
  var textPost;
  var accounts;


  PostSanai3yContainer({required this.imagePost , required this.textPost});

  Widget build(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Padding(
          padding:  EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 10,),
                  ImageSanai3yStreamBuilder2(),

                  SizedBox(width: 5,),

                  StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('Sanai3yAccounts').snapshots(),
                      builder: (context , snapshot){
                        switch(snapshot.connectionState){

                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(child: CircularProgressIndicator(),);

                          case ConnectionState.done:
                          case ConnectionState.active:
                          if(snapshot.hasData){
                            accounts = snapshot.data?.docs;
                            for(var account in accounts!){

                              final currentUser = account.get('email');
                              if(currentUser==Auth.currentUser?.email){

                                name = account.get('userName');

                              }
                            }
                          }

                          return Column(
                            children: [
                              Text(name , style: Theme.of(context).textTheme.titleMedium,),

                            ],
                          );
                        }

                      }
                  ),

                ],
              ),

              SizedBox(height: 10,),

              Divider(height: 1,color: Colors.black87,),

              SizedBox(height: 10,),

              Container(
                      margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(textPost  ,style: Theme.of(context).textTheme.titleMedium,),

                          SizedBox(height: 10),

                          Positioned(
                            right: 10,
                              child: Image.network(imagePost )
                          )
                        ],
                      ))
          ]
          ),
        )
      ),
    );
  }
}

class Sanai3yInfoContainer extends StatelessWidget{

  var userName;
  var job;
  var image;
  var phone;

  Sanai3yInfoContainer({this.phone , this.job , this.image , this.userName});

  Widget build(BuildContext context){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Positioned(
            child: Container(
              child: CircleAvatar(radius: 60,backgroundImage: NetworkImage(image),),
            )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Positioned(
              top: 140,
              left: 10,
              child: Text(userName , style: Theme.of(context).textTheme.titleMedium,),
            ),

            //SizedBox(width: 50,),

            Column(
              children: [
                Positioned(
                    child: Text('Phone: ${phone}' , style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Cairo-VariableFont_wght.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan[900]
                    ),)
                ),

                Positioned(
                    child: Text('Job: ${job}' , style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Cairo-VariableFont_wght.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.red[900]
                    ),)
                )
              ],
            )
          ],
        )
      ],
    );
  }
}

class PostProfileSanai3yContainer extends StatelessWidget{

  final Auth = FirebaseAuth.instance;
  var name;
  var image;
  var imagePost;
  var textPost;
  var accounts;


  PostProfileSanai3yContainer({ this.imagePost ,  this.textPost , this.image , this.name});

  Widget build(BuildContext context){

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
          margin: EdgeInsets.only(bottom: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40)
          ),
          child: Padding(
            padding:  EdgeInsets.all(10),
            child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(image),
                        ),
                      ),

                      SizedBox(width: 5,),

                      Text(name , style: Theme.of(context).textTheme.titleMedium,)
                    ],
                  ),

                  SizedBox(height: 10,),

                  Divider(height: 1,color: Colors.black87,),

                  SizedBox(height: 10,),

                  Container(
                      margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(textPost  ,style: Theme.of(context).textTheme.titleMedium,),

                          SizedBox(height: 10),

                          Positioned(
                              right: 10,
                              child: Image.network(imagePost )
                          )
                        ],
                      ))
                ]
            ),
          )
      ),
    );
  }
}



class ImageProfileSanai3yStreamBuilder2 extends StatefulWidget{
  @override
  State<ImageProfileSanai3yStreamBuilder2> createState() => _ImageProfileSanai3yStreamBuilder2();
}

class _ImageProfileSanai3yStreamBuilder2 extends State<ImageProfileSanai3yStreamBuilder2> {
  final _fireStore = FirebaseFirestore.instance;

  var currentUser;

  var image;

  late User signedInUser;

  final Auth = FirebaseAuth.instance;
  var imageSanai3ya;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser(){

    final User = Auth.currentUser;
    if(User != null){
      signedInUser = User;
    }
  }

  Widget build(BuildContext context){
    return StreamBuilder(
        stream: _fireStore.collection('Sanai3yAccounts').snapshots(),
        builder: (context , snapshot){
          //List<Widget> listAccount=[];

          if(snapshot.hasData){
            imageSanai3ya = snapshot.data?.docs;
            for(var imageSanai3y in imageSanai3ya!){

              currentUser = imageSanai3y.get('email');
              if(signedInUser.email!=currentUser){
                image = imageSanai3y.get('image');

              }
            }
          }
          return Positioned(
              child: Container(
                child: CircleAvatar(radius: 25,backgroundImage: NetworkImage(image),),
              )
          );
        }
    );
  }
}



class MessageStreamBuilder extends StatelessWidget{
final _fireStore = FirebaseFirestore.instance;


  Widget build(BuildContext context){

    return StreamBuilder<QuerySnapshot>(
                    stream: _fireStore.collection('Chats').orderBy('time').snapshots(),
                    builder: (context , snapshot){
                      List<MessageContainer> messagesUsers = [];
                      if(snapshot.hasData){
                        final messages = snapshot.data?.docs.reversed;
                        for(var messageUser in messages!){
                          final message = messageUser.get('message');
                          final nameSender = messageUser.get('nameSender');
                          final sender = messageUser.get('emailSender');
                          final currentUser = FirebaseAuth.instance.currentUser?.email;

                            final messageWidget = MessageContainer(
                                messageText: message,
                                sender: nameSender,
                                isMe: currentUser==sender
                            );
                            messagesUsers.add(messageWidget);
                        }
                      }
                      return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ListView(
                              reverse: true,
                              children: messagesUsers,
                            ),
                          )
                      );
                    }
                );
  }
}

class MessageContainer extends StatelessWidget{
  
  final messageText;
  final sender;
  final bool isMe;

  const MessageContainer({ required this.messageText, required this.sender, required this.isMe});

  Widget build(BuildContext context){

    return Padding(
      padding:  EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(sender , style: TextStyle(fontSize: 12 , color: Colors.black45),),
          Material(
            color: isMe?Colors.blue[900] : Colors.white,
            elevation: 6,
            shape: OutlineInputBorder(borderRadius: isMe? BorderRadius.only(
              bottomRight: Radius.circular(40),
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40)
            )
                :BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40)
            ), borderSide: BorderSide.none
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
              child: Text( messageText , style: TextStyle(
                fontSize: 15,
                color: isMe?Colors.white:Colors.black87
              ),),
            ),
          )
        ],
      ),
    );
  }
}

class CardMessages extends StatelessWidget{

  final userName , image, message , phone;


   CardMessages({ this.userName, this.image, this.message , this.phone});

  Widget build(BuildContext context){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(
          userName: userName,
          image: image,
          phone: phone,
        )));
      },
      child: Card(
        elevation: 4,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10) , borderSide: BorderSide.none),
        color: Colors.white,
        child: ListTile(
          title: Text(userName , style: TextStyle(color: Colors.black87 , fontSize: 17 , fontWeight: FontWeight.bold),),
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(image),
          ),
          subtitle: Row(
            children: [
              Text(message , style: TextStyle(color: Colors.black87 , fontSize: 12),),
            ],
          ),
        ),
      ),
    );
  }
}


class CartContainer extends StatelessWidget{
  final price;
  final image;
  final title;
  var nameProduct;
  var imageProduct;
  var priceProduct;
  final currentUser = FirebaseAuth.instance.currentUser;
  CartContainer({this.price  , this.title , this.image});

  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Container(
      height: 190,
      margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 20),
      child: InkWell(
        child: Stack(
          children: [
            Container(
              height: 166,
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(offset:  Offset(0,15), blurRadius: 25 , color: Colors.black26)
                ]
              ),
            ),

            Positioned(
              top: 0,
                left: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 160,
                  width: 170,
                  child:  Image.asset(image)
                ),
            ),

            Positioned(
                top: 0,
                bottom: 30,
                right: 0,
                child: SizedBox(
                  height: 100,
                  width: size.width-200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [

                      Spacer(),

                      Text(title ,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo-VariableFont_wght.ttf',
                            fontSize: 20,
                            color: Colors.indigo
                        ) ,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20  ,vertical: 2),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(offset: Offset(0,5) , blurRadius: 5 , color: Colors.black26)
                              ]
                          ),
                          child: Text("Price: ${price}\$" ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Cairo-VariableFont_wght.ttf',
                            ),
                          ),
                        ),
                      ),

                      Padding(padding: EdgeInsets.symmetric( horizontal: 20),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FloatingActionButton(
                                backgroundColor: Colors.blue[900],
                                child: Icon(CupertinoIcons.hand_thumbsup_fill),
                                onPressed: (){
                                }
                            ),
                            FloatingActionButton(
                                backgroundColor: Colors.red[900],
                                child: Icon(CupertinoIcons.delete),
                                onPressed: (){}
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}

class SearchIcon extends SearchDelegate{

  List<Products> searchItems = [
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

  @override
  List<Widget>? buildActions(BuildContext context) =>[
  IconButton(
  onPressed: (){
    if(query.isEmpty){
      close(context, null);
    }
    else
      query='';
  },
  icon: Icon(Icons.close)
  )
  ];

  @override
  Widget? buildLeading(BuildContext context) =>IconButton(
      onPressed: ()=> close(context, null),
      icon: Icon(Icons.arrow_back_rounded)
  );

  @override
  Widget buildResults(BuildContext context) {

    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Products> itemSearch = searchItems.where((searchItem){
      final result = searchItem.title;
      final input = query;
      return result.contains(input);
    }).toList();
     return ListView.builder(
         itemCount: itemSearch.length,
        itemBuilder: (context , index){
           final suggestion = itemSearch[index];
           return ListTile(
             title: Text(suggestion.title),
             onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(products: itemSearch[index])));
             },
           );
        }
    );
  }
}