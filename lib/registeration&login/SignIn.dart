import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shatably/tools/Buttons.dart';
import 'package:shatably/UsersScreens/NavigationBar1.dart';
import 'package:shatably/registeration&login/SignUp.dart';


class SignIn extends StatefulWidget{
  static String screenR = "SignIn";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isHidden = true;
  late String email;
  late String password;
  final _auth  = FirebaseAuth.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  late StreamSubscription<User?> user;

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      //to make user still login.
      if(user==null){
        print("User SignOut");
      }
      else
        print("User already LogIn");
    });
  }


  void _passShow(){
    //option to show pass or hide.
    setState(() {
      isHidden =!isHidden;
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  Widget build(BuildContext context){
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30 , horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset("tools/images/ImageBoarding/ShatablySplash.png"),

              Row(
                children: [
                  Text("New To Shatably?" , style: Theme.of(context).textTheme.titleLarge,),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                      },
                      child: Text("SignUp" , style: Theme.of(context).textTheme.titleSmall,)
                  )
                ],
              ),

              TextField(
                onChanged: (value){
                  email  =value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  label: Text("Email"),
                  border: OutlineInputBorder()
                ),
              ),

              SizedBox(height: 10,),

              TextField(
                onChanged: (value){
                  password = value;
                },
                obscureText:isHidden,
                keyboardType: TextInputType.visiblePassword,

                decoration: InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                  suffix: InkWell(
                    onTap: _passShow,
                    child: Icon(isHidden? Icons.visibility : Icons.visibility_off_rounded),
                  )
                ),
              ),

              TextButton(
                  //to reset the password if forgotten.
                  onPressed: ()async{
                    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                    Fluttertoast.showToast(
                        msg: "Please, Check Your Email",
                        backgroundColor: Colors.black87,
                        textColor: Colors.white
                    );
                  },
                  child: Text("Forget Password?" , style: Theme.of(context).textTheme.titleSmall,)),

              FirstBtn(
                  text: "SignIn"
                  , color:Colors.black87 ,
                  onPressed: ()async{
                    FocusManager.instance.primaryFocus?.unfocus();
                    try{
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(user!=null){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationBar1()), (route) => false);
                      }
                    }
                    on FirebaseAuthException catch(e){
                      //Error message to user if any mistakes founded
                      if(e.code=="user-not-found"){
                        Fluttertoast.showToast(msg: "Email is Valid");
                      }
                      else if(e.code =="wrong-password"){
                        Fluttertoast.showToast(msg: "Password is Valid");
                      }
                      else
                        Fluttertoast.showToast(msg: "${e.code}");
                    }

                  }
              ),

              SizedBox(height: 30,),

              Row(
                children: [
                  Flexible(
                    child: Divider(
                      color: Colors.indigo,
                    ),
                  ),
                  Text("Or" , style: Theme.of(context).textTheme.titleSmall,),

                  Flexible(
                    child: Divider(
                      color: Colors.indigo,
                    ),
                  )
                ],
              ),


              FacebookBtn(
                //fast login with facebook account.
                color: Colors.indigo,
                text: "Facebook",
                onPressed: ()async{
                  await signInWithFacebook();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationBar1()), (route) => false);
                },
              ),

              GoogleBtn(
                //fast login with google Account.
                  color: Colors.blue,
                  onPressed: ()async{
                    await signInWithGoogle();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationBar1()), (route) => false);

                  },
                  text: "SignIn With Google"
              )

            ],
          ),
        ),
      ),
    );
  }
}
