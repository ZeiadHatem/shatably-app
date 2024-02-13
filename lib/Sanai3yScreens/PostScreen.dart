import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../tools/Widgets.dart';
import 'package:path/path.dart';


class PostPage extends StatefulWidget{

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final Auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  var name;
  String? post;
  File? image;
  final imagePicker = ImagePicker();
  CroppedFile? croppedImage;
  var urlImagePost;

  uploadImage()async{

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
        ]

      );
      setState(() {
        image = File(croppedImage!.path);
      });
    }
  }

  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[850],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Create Post" , style:  TextStyle(
                fontSize: 17,
                fontFamily: 'Cairo-VariableFont_wght.ttf',
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),),

            MaterialButton(
                shape: OutlineInputBorder(borderSide: BorderSide.none),
                color: Colors.grey[800],
                onPressed: ()async{
                  FocusManager.instance.primaryFocus?.unfocus();
                  try{
                    var nameImagePost = basename(croppedImage!.path);
                    var randomNum = Random().nextInt(1000000);
                    nameImagePost = '$randomNum%%$nameImagePost';
                    var storageImagePost = FirebaseStorage.instance.ref('ImagePosts/$nameImagePost');
                    await storageImagePost.putFile(image!);
                    urlImagePost = await storageImagePost.getDownloadURL();
                    print(urlImagePost);
                    _fireStore.collection('PostsSanai3y').add(
                        {
                          'image' : urlImagePost,
                          'text':post,
                          'email' : Auth.currentUser?.email,
                          'time' :FieldValue.serverTimestamp()
                        });
                  }
                  catch(e){
                    print(e);
                  }
                  Navigator.pop(context);
                },
                child: Text('Post' , style:  TextStyle(
                    fontSize: 17,
                    fontFamily: 'Cairo-VariableFont_wght.ttf',
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                ),),
            ),
          ],
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.only(left: 10 , right: 10 , bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Colors.white,),

            SizedBox(height: 5,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
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
                              final accounts = snapshot.data?.docs;
                              for(var account in accounts!){

                                final currentUser = account.get('email');
                                if(currentUser==Auth.currentUser?.email){

                                  name = account.get('userName');

                                }
                              }
                            }

                            return Text(name , style:  TextStyle(
                                fontSize: 17,
                                fontFamily: 'Cairo-VariableFont_wght.ttf',
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                            ),);

                          }
                        }
                    ),
                  ],
                ),
                //SizedBox(width: 120,),
                IconButton(
                    onPressed: (){
                      uploadImage();
                    },
                    icon: Icon(CupertinoIcons.photo , size: 50,color: Colors.deepOrangeAccent,)
                )
              ],
            ),
            TextField(
              onChanged: (value){
                post = value;
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  hintText: 'Write Some Thing....',
                  hintStyle: TextStyle(color: Colors.grey[400] , fontWeight: FontWeight.w100),
                  border: InputBorder.none
              ),
            ),

            Container(
              child: image!=null?Image.file(image!):Container(),
            ),

            Spacer(),


          ],
        ),
      ),
    );
  }
}