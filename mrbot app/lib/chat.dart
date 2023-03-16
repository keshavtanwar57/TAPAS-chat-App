import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'pdfviewer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

TextEditingController ChatController = TextEditingController();
DateTime mssgtime = DateTime.now();
String messageTime =
    mssgtime.hour.toString() + ":" + mssgtime.minute.toString();
List<dynamic> messages = [
  ["Hello how can i help you ?", "bot", messageTime]
];

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text("Mr.Bot"),
          leading: Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: Colors.green),
            child: LottieBuilder.network(
                'https://assets5.lottiefiles.com/private_files/lf30_um4sz3z5.json'),
          )),
      body: Container(
        decoration: BoxDecoration(color: Color(0xff3C58EC)),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: ListView.builder(
                  itemCount: messages.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    if (messages[index] == "ServerTyping") {
                      return Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            width: 60,
                            child: LottieBuilder.network(
                                'https://assets8.lottiefiles.com/private_files/lf30_hpg4y97o.json')),
                      );
                    } else if (messages[index][1] == "serverFile") {
                      return Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () async {
                              PdfDocument document = PdfDocument();
                              final page = document.pages.add();
                              page.graphics.drawString(messages[index][0],
                                  PdfStandardFont(PdfFontFamily.helvetica, 30));

                              dynamic bytes = await document.save();
                              document.dispose();

                              saveAndLaunchFile(bytes, "output.pdf");
                            },
                            child: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Color(0xff649EED),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text("Tap to view file")),
                          ),
                        ),
                      );
                    } else {
                      return Align(
                        alignment: messages[index][1] == "user"
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        child: Container(
                          padding: messages[index][1] == "user"
                              ? EdgeInsets.fromLTRB(50, 8, 8, 8)
                              : EdgeInsets.fromLTRB(8, 8, 50, 8),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: messages[index][1] == "user"
                                    ? Color(0xff2D47D1)
                                    : Color(0xff649EED),
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              children: [
                                Text(
                                  messages[index][0].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  messages[index][2],
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: ChatController,
                decoration: InputDecoration(
                  hintText: "Type..",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      String query = ChatController.text;
                      DateTime mssgtime = DateTime.now();
                      String messageTime = mssgtime.hour.toString() +
                          ":" +
                          mssgtime.minute.toString();
                      messages.add([query, "user", messageTime]);
                      ChatController.clear();
                      messages.add("ServerTyping");
                      setState(() {});
                      // var dio = Dio();
                      // dynamic response1 = await dio.post(
                      //     'https://delta-diagnose-api.herokuapp.com/predict_predict_image/',
                      //     data: {
                      //       'url':
                      //           "https://res.cloudinary.com/doeq0cvif/image/upload/v1656428621/c1b1iu7akf3tvg2kpuxj.jpg"
                      //     });
                      // String queryResult = response1.data['class'];
                      await Future.delayed(Duration(seconds: 10));
                      messages.removeLast();
                      String queryResult = query;
                      String serverMessageTime = mssgtime.hour.toString() +
                          ":" +
                          mssgtime.minute.toString();
                      if (queryResult.length < 10) {
                        messages
                            .add([queryResult, "server", serverMessageTime]);
                        setState(() {});
                      } else {
                        messages.add(
                            [queryResult, "serverFile", serverMessageTime]);
                        setState(() {});
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  dynamic _showPDF(String queryResult) async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    page.graphics
        .drawString(queryResult, PdfStandardFont(PdfFontFamily.helvetica, 30));

    dynamic bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(bytes, "output.pdf");
  }
}
