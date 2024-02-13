import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shatably/Sanai3yScreens/Samai3yScreen.dart';
import 'package:shatably/detailsScreens/CarpentryPage.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/tools/Products.dart';
import 'package:shatably/tools/Widgets.dart';
import 'package:path/path.dart';


class Sanai3ySignIn extends StatefulWidget{

  @override
  State<Sanai3ySignIn> createState() => _Sanai3ySignInState();
}

class _Sanai3ySignInState extends State<Sanai3ySignIn> {

  late String phone;
  late String job;
  late String userName;
  late String imageSanai3y;
  File? image;
  var urlImage;
  final imagePicker = ImagePicker();
  final controllerPage = PageController();
  var _FireStore = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  final Auth = FirebaseAuth.instance;
  late User signedInUser;
  CroppedFile? croppedFile;
  var idSanai3y = Random().nextInt(10000);

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() {
    final User = Auth.currentUser;
    if(User!=null){
      signedInUser=User;
      print(signedInUser.displayName);
    }
  }

  uploadImage()async{

    final gallery = await imagePicker.pickImage(source: ImageSource.gallery);
    if(gallery!=null){
       croppedFile = await ImageCropper().cropImage(
          sourcePath: gallery.path,
         aspectRatioPresets: [
           CropAspectRatioPreset.ratio3x2,
           CropAspectRatioPreset.original,
           CropAspectRatioPreset.ratio4x3,
           CropAspectRatioPreset.ratio16x9,
           CropAspectRatioPreset.square
         ],
          uiSettings: [
            AndroidUiSettings(
          toolbarTitle: 'Cropper',
        toolbarColor: Colors.blue[900],
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false
        ),
        IOSUiSettings(
           title: 'Cropper'
        ),
            /*WebUiSettings(
                context: context
            )*/
          ]
      );
      setState(() {
        image=File(croppedFile!.path);
      });
    }
  }

  Widget build(BuildContext context){

    //Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controllerPage,

          children: [
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 30),
                child: Column(
                  children: [
                    Image.asset('tools/images/ImageBoarding/ShatablySplash.png'),

                    SizedBox(height: 100,),


                    InkWell(
                      onTap: uploadImage,
                      child: CircleAvatar(
                          radius: 40,
                          child: image==null?CircleAvatar(
                            radius: 40,
                            backgroundImage: Image.asset('tools/images/defaultcover.jpg').image,
                          ): CircleAvatar(radius:40 , backgroundImage: Image.file(image!).image,),
                        ),
                    ),


                    SizedBox(height: 20,),

                    TextField(
                      keyboardType: TextInputType.name,
                      onChanged: (value){
                        userName = value;
                      },
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: "UserName",
                        border: OutlineInputBorder()
                      ),
                    ),

                    SizedBox(height: 50,),

                    FirstBtn(
                        text: 'Next',
                        color: Colors.blue[900]!,
                        onPressed: (){
                          FocusManager.instance.primaryFocus?.unfocus();
                          controllerPage.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                        }
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 30),
                child: Column(
                  children: [
                    Image.asset("tools/images/ImageBoarding/ShatablySplash.png"),

                        SizedBox(height: 200,),

                        TextField(
                            onChanged: (value){
                              phone = value;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: "Enter Your Phone",
                              border: OutlineInputBorder()
                            ),
                          ),

                     SizedBox(height: 50,),

                     FirstBtn(
                         text: "Next",
                         color: Colors.black87,
                         onPressed: (){
                             FocusManager.instance.primaryFocus?.unfocus();
                             controllerPage.nextPage(duration: Duration(milliseconds: 500), curve: Curves.linear);
                         }
                     )
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 30),
                child: Column(
                  children: [
                    Image.asset("tools/images/ImageBoarding/ShatablySplash.png"),

                    SizedBox(height: 200,),

                    TextField(
                      onChanged: (value){
                        job = value;
                      },
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "Enter Your Job",
                        border: OutlineInputBorder()
                      ),
                    ),

                    SizedBox(height: 50,),

                    FirstBtn(
                        text: "Next",
                        color: Colors.red,
                        onPressed: ()async{
                          FocusManager.instance.primaryFocus?.unfocus();
                          var nameImage = basename(croppedFile!.path);
                          var random = Random().nextInt(1000000000);
                          nameImage = '$random&&$nameImage';
                          var storageImage= FirebaseStorage.instance.ref('imageSanai3y/$nameImage');
                          await storageImage.putFile(image!);
                          urlImage = await storageImage.getDownloadURL();
                          print(urlImage);
                          _FireStore.collection("Sanai3yAccounts").doc(currentUser!.email).set(
                            {
                              'userName' : userName,
                              'email' :signedInUser.email,
                              "phone" : phone,
                              "job" : job,
                              'image' : urlImage,
                              'id' : idSanai3y
                              //'time' : FieldValue.serverTimestamp()
                            }
                          );
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Sanai3yScreen()) , (route) => false);
                          setState(() {
                            if(job=="carpenter"){
                              carpenters.add(Sanai3yContainer(phone: phone, job: job, image: image, userName: userName , email: signedInUser.email,));
                            }
                            else if(job == 'smith'){
                              smith.add(Sanai3yContainer(image: urlImage,userName: userName,job: job,phone: phone,email: signedInUser.email,));
                            }
                            else if(job=='electrical'){
                              electrical.add(Sanai3yContainer(image: urlImage,userName: userName,job: job,phone: phone,email: signedInUser.email,));
                            }
                            else if(job=="paint"){
                              paint.add(Sanai3yContainer(image: urlImage,userName: userName,job: job,phone: phone,email: signedInUser.email,));
                            }
                            else if(job=="plumber"){
                              plumber.add(Sanai3yContainer(image: urlImage,userName: userName,job: job,phone: phone, email: signedInUser.email,));
                            }
                            else{
                              Fluttertoast.showToast(
                                  msg: "Please Try Again",
                                 backgroundColor: Colors.black87,
                                 textColor: Colors.white
                              );
                            }
                          });
                        }
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}