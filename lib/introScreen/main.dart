import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shatably/introScreen/GetStarted.dart';
import 'package:shatably/UsersScreens/NavigationBar1.dart';
import 'package:shatably/registeration&login/SignIn.dart';


void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Shatably());
}

class Shatably extends StatelessWidget{
  
  //final _fireStore = FirebaseFirestore.instance;



  Widget build(BuildContext context){

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      ),
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
              titleMedium: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              fontFamily: 'Cairo-VariableFont_wght.ttf',
              color: Colors.black87
            ),
            titleSmall: TextStyle(
              fontFamily: 'Cairo-VariableFont_wght.ttf',
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.indigo
            ),
            titleLarge: TextStyle(
              fontSize: 17,
              fontFamily: "Cairo-VariableFont_wght.ttf",
              color: Colors.black87,
              fontWeight: FontWeight.bold
            ),
            bodyLarge: TextStyle(
              fontSize: 50,
              fontFamily: "Cairo-VariableFont_wght.ttf",
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
              fontStyle: FontStyle.italic
            ),
            bodyMedium: TextStyle(
              fontSize: 17,
              fontFamily: 'Cairo-VariableFont_wght.ttf',
              fontWeight: FontWeight.bold,
                color: Colors.white
            )
          )
        ),
        home: SplashScreen(),
        routes: {
          NavigationBar1.screenR :(context)=>NavigationBar1(),
          SignIn.screenR :(context)=> SignIn()
        },
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Image(
          image: AssetImage("tools/images/ImageBoarding/ShatablySplash.png"),
          color: Colors.white,),
      ),
      backgroundColor: Colors.deepPurple,
        nextScreen: FirebaseAuth.instance.currentUser != null ?  NavigationBar1():GetStarted(),
      splashIconSize: 150,
    );
  }
}
