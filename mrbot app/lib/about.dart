import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'constant.dart';
import 'aboutData.dart';

class aboutPage extends StatefulWidget {
  const aboutPage({Key? key}) : super(key: key);

  @override
  State<aboutPage> createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff3C58EC),
      ),
      body: Container(
        color: Color(0xff3C58EC),
        height: h,
        width: w,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                tag: "logo",
                child: Container(
                  height: h / 2.4,
                  child: LottieBuilder.network(
                      'https://assets7.lottiefiles.com/packages/lf20_96bovdur.json'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: w,
                decoration: const BoxDecoration(
                    color: Colors.white60,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40))),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      "About",
                      style: GoogleFonts.montserrat(
                          fontSize: 40, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      AboutBody1,
                      style: GoogleFonts.roboto(fontSize: 19),
                    ),
                    Text(
                      AboutBody2,
                      style: GoogleFonts.roboto(fontSize: 19),
                    ),
                    Text(
                      AboutBody3,
                      style: GoogleFonts.roboto(fontSize: 19),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
