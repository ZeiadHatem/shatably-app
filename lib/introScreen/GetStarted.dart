import 'package:flutter/material.dart';
import 'package:shatably/registeration&login/SignIn.dart';
import 'package:shatably/registeration&login/SignUp.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

 class GetStarted extends StatelessWidget{
   final controller = PageController();

   @override
   void dispose(){
     controller.dispose();
   }

   Widget build(BuildContext context){
     return Scaffold(
       body: Container(
         child: PageView(
           controller: controller,
           children: [
             Container(
               color: Colors.black45,
               child: Padding(
                 padding: const EdgeInsets.symmetric(vertical: 50),
                 child: Column(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                             Image.asset('tools/images/ImageBoarding/onBoardingOne.png'),

                       ],
                     ),
               ),
             ),
             Container(
               color: Colors.blueAccent,
               child: Image(image: AssetImage('tools/images/ImageBoarding/onBoardingTwo.png') ),
             ),
             Container(
               child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.symmetric(vertical: 30 , horizontal: 20),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         TextButton(
                             onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                             },
                             child: Text("SignUp" , style: Theme.of(context).textTheme.titleMedium,)
                         ),
                         TextButton(
                             onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
                             },
                             child: Text("SignIn" , style: Theme.of(context).textTheme.titleMedium,)
                         )
                       ],
                     ),
                   ),

                   Padding(
                     padding: const EdgeInsets.symmetric(vertical: 60),
                     child: Center(
                       child: Image.asset("tools/images/ImageBoarding/onBoardingThree.png"),
                     ),
                   )

                 ],
               ),
               color: Colors.tealAccent,
             )
           ],
         ),
       ),
      // it`s disgn to show  the switch between pages to users.
       floatingActionButton: Padding(
         padding: const EdgeInsets.only(left: 20, bottom: 20),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               FloatingActionButton(
                 backgroundColor: Colors.black87,
                 onPressed: ()=>controller.jumpTo(1) ,
                 child: Icon(Icons.arrow_back_ios_new_outlined),
               ),
               
               SmoothPageIndicator(
                
                 controller: controller
                 , count: 3,
                 effect:WormEffect(
                   dotColor: Colors.black87,
                   activeDotColor: Colors.indigo
                 ) ,
               ),

               FloatingActionButton(
                //button to change the image to show more info about program.
                 backgroundColor: Colors.black87,
                   child: Icon(Icons.arrow_forward_ios_outlined),
                   onPressed: ()=>controller.nextPage(duration: Duration(seconds: 2), curve: Curves.bounceOut),
               ),

             ],
           ),
       ),
     );
   }
 }
