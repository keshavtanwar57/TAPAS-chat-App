import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mrbot/about.dart';
import 'package:mrbot/constant.dart';
import 'chatpage.dart';
import 'databases.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double buttonHeight = h / 12;
    double buttonWidth = w / 1.45;
    return Scaffold(
      body: Container(
          color: Color(0xff3C58EC),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: "logo",
                child: Container(
                  height: h / 2.4,
                  child: LottieBuilder.network(
                      'https://assets7.lottiefiles.com/packages/lf20_96bovdur.json'),
                ),
              ),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Chat()),
                      );
                    },
                    child: Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                          color: kbuttonColor,
                          //   boxShadow: kboxShadowWelcomePage,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          "Chat",
                          style: kbutonTextStyle,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Databases()),
                      );
                    },
                    child: Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                          color: kbuttonColor,
                          // boxShadow: kboxShadowWelcomePage,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Text(
                        "Databases",
                        style: kbutonTextStyle,
                      )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const aboutPage()),
                      );
                    },
                    child: Container(
                      height: buttonHeight,
                      width: buttonWidth,
                      decoration: BoxDecoration(
                          color: kbuttonColor,
                          //boxShadow: kboxShadowWelcomePage,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Text(
                        "About",
                        style: kbutonTextStyle,
                      )),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
