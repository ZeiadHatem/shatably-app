import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:dropdown_plus/dropdown_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shatably/registeration&login/SignIn.dart';
import 'package:shatably/tools/Buttons.dart';



class SignUp extends StatefulWidget{

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String userName , email , password , phone;

  late dynamic yourBirthday;
  var _auth = FirebaseAuth.instance;
  var _FireStore = FirebaseFirestore.instance;
  var currentUser = FirebaseAuth.instance.currentUser;
  bool isHidden = true;
  bool notVisible = true;
  final imagePicker = ImagePicker();
  File? image;
  CroppedFile? croppedImage;
  var urlImage;



  void passView(){
    setState(() {
      isHidden=!isHidden;
    });
  }

  void passIsVisible(){
    setState(() {
      notVisible =!notVisible;
    });
  }

  uploadImage()async{
    //to upload user image and edite on it and upload it to database(firebase>Storage).
    final gallery = await imagePicker.pickImage(source: ImageSource.gallery);
    if(gallery!=null){
      croppedImage = await ImageCropper().cropImage(
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
        image=File(croppedImage!.path);
      });

    }


  }


  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30 , horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SignUp ,Now" , style: Theme.of(context).textTheme.bodyLarge,),

              SizedBox(height: 10,),

                     Row(
                       children: [
                         Flexible(
                             child: InkWell(
                               onTap: uploadImage,
                               child: CircleAvatar(
                                 radius: 40,
                                 backgroundImage: image!=null?Image.file(image!).image:Image.asset('tools/images/defaultcover.jpg').image,
                               ),
                             )
                         ),
                         SizedBox(width: 10,),
                         Flexible(
                           flex: 3,
                           child: TextField(
                            keyboardType: TextInputType.name,
                            onChanged: (value){
                              userName = value;
                            },
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              label: Text("UserName"),
                              border: OutlineInputBorder(),
                            ),
                    ),
                         ),
                       ],
                     ),

              SizedBox(height: 10,),

              TextField(
                onChanged: (value){
                  email = value;
                },
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder()
                ),
              ),

              SizedBox(height: 10,),

              TextField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: isHidden,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                  suffix: InkWell(
                    onTap: passView,
                    child: Icon(isHidden? Icons.visibility : Icons.visibility_off_rounded),
                  )
                ),
              ),

              SizedBox(height: 10,),

              TextField(
                onChanged: (value){
                  password = value;
                },
                obscureText: notVisible,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  label: Text("ConfirmPassword"),
                  border: OutlineInputBorder(),
                  suffix: InkWell(
                    onTap: passIsVisible,
                    child: Icon(notVisible? Icons.visibility : Icons.visibility_off_rounded),
                  )
                ),
              ),

              SizedBox(height: 10,),

              TextField(
                onChanged: (value){
                  phone = value;
                },
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: Text("Phone Number"),
                  border: OutlineInputBorder()
                ),
              ),

              SizedBox(height: 10,),

              Row(
                children: [
                  Flexible(
                    child:DateTimeFormField(

                      dateTextStyle: TextStyle(color: Colors.black87),

                      decoration: InputDecoration(
                          labelStyle: TextStyle(fontSize: 20),
                          labelText: "Your Birthday",
                          contentPadding: EdgeInsets.symmetric(vertical: 15 , horizontal: 5),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.event_note)
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                    ),
                  ),
                  SizedBox(width: 10,),

                  Flexible(
                      child: Material(

                        textStyle: TextStyle(color: Colors.black87),

                        child: TextDropdownFormField(
                          options: ["Male"  ,"Female"],
                          decoration: InputDecoration(
                              labelText: "Gender",
                              labelStyle: TextStyle(fontSize: 20),
                              contentPadding: EdgeInsets.symmetric(vertical: 15 , horizontal: 5),
                              border: OutlineInputBorder()
                          ),
                        ),
                      )
                  ),

                ],
              ),

              SizedBox(height: 20,),

              FirstBtn(
                  text: "SignUp",
                  color: Colors.black87,
                  onPressed: ()async{
                    FocusManager.instance.primaryFocus?.unfocus();
                    try{
                      //method to make any image unique to 
                      var nameImage = basename(croppedImage!.path);
                      var random = Random().nextInt(1000000000);
                      nameImage = '$random%%%$nameImage';
                      var storageImage = FirebaseStorage.instance.ref('image/$nameImage');
                      await storageImage.putFile(image!);
                      urlImage = await storageImage.getDownloadURL();
                      print(urlImage);
                      _FireStore.collection("Accounts").doc(currentUser?.uid).set(
                          {
                            "UserName" : userName,
                            "Email" : email,
                            "Phone" : phone,
                            "YourBirthday" : yourBirthday,
                            'image': urlImage
                          }
                      );
                      //just create user with email and password without phone number and push to sign in page to login.
                      final newUser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));

                    }
                    catch(e){
                      print(e);
                    }
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
