import 'package:dating_app/constants/constants.dart';
import 'package:dating_app/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../phone_number_screen.dart';
//import 'package:introduction_screen/introduction_screen.dart';
class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}
class _OnBoardingPageState extends State<OnBoardingPage> {
  static var stepOneTitle = "Find your partner in your own cast";
  static var stepOneContent = "Build your farm better Matches";
  static var stepTwoTitle = "Find Your Partener In your own Caste";
  static var stepTwoContent = "Be part of the agriculture and gives your team the  power you need to do your best";
  static var stepThreeTitle = "Find Your Best Matches";
  static var stepThreeContent = "Your will be proud to be part of agriculture and it’s harvest";
  late PageController _pageController;
  int currentIndex = 0;
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => PhoneNumberScreen()),
    );
  }
  @override
  void initState() {
    _pageController = PageController(
        initialPage: 0
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     /* appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: InkWell(onTap: (){
              _onIntroEnd(context);
            },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Skip', style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),),
              ),
            ),
          )
        ],
      ),*/
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: <Widget>[
              makePage(
                  image: 'assets/2.0x/slider1.png',
                  title: "assets/2.0x/slider1text.png",
                 // content: stepOneContent
              ),
              makePage(
                  reverse: true,
                  image: 'assets/2.0x/Sliders2.png',
                  title: "assets/2.0x/slider2text.png",
                 // content: stepTwoContent
              ),
              makePage(
                  image: 'assets/2.0x/Sliders3.png',
                  title: "assets/2.0x/slider3text.png",
                  //content: stepThreeContent
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          )
        ],
      ),
    );
  }
  Widget makePage({image, title,  reverse = false}) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(
       /*   gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Colors.black.withOpacity(.4)]),*/
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ) ,
        padding: EdgeInsets.only(left:20, right: 20, bottom:  MediaQuery.of(context).size.height*0.10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Expanded(flex: 8,
                    child: Container()),
             /*   Expanded(flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(right: 10, top: 20),
                    child: InkWell(onTap: (){
                      _onIntroEnd(context);
                    },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0,vertical: 25.0),
                        child: Container(decoration:
                          BoxDecoration(color: APP_PRIMARY_COLOR,
                          border: Border.all(
                              width: 0.0
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(30.0) //                 <--- border radius here
                          ),
                        ),
                          alignment: Alignment.center,

                          child: Text('Skip', style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400
                          ),),
                        ),
                      ),
                    ),
                  ),
                ),*/
              ],
            ),
           /* Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(image),
                ),
                SizedBox(height: 30,),
              ],
            ) : SizedBox(),*/
SizedBox(height: MediaQuery.of(context).size.height*0.73,),
          Container(child:Image.asset(title,height: 50,width: MediaQuery.of(context).size.width*.90 ,),),
           /* Text(title, style: TextStyle(
                color:Colors.white ,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),),*/
            SizedBox(height: 20,),
      InkWell(onTap: (){
        _onIntroEnd(context);
      },
        child: Center(
          child: Container(height: 45,width: MediaQuery.of(context).size.width*0.73,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xffde2657),
              ),child:   Center(
                child: Text('Get Started', textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400
                ),),
              ),

          ),
        ),
      ),

          ],
        ),
      ),
    );
  }
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 12,
      width: isActive ? 30 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(5)
      ),
    );
  }
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}
