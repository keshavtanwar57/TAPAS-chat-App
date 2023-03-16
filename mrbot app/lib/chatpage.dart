import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'pdfviewer.dart';
import 'package:grouped_list/grouped_list.dart';
import 'constant.dart';
import 'widget.dart';

TextEditingController CHAT_CONTROLLER = new TextEditingController();

class Messages {
  final String text;
  final String time;
  final bool isSentByUser;
  final isLoading;
  final ispdf;

  const Messages(
      {required this.text,
      required this.time,
      required this.isSentByUser,
      required this.isLoading,
      final this.ispdf});
}

DateTime mssgtime = DateTime.now();

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Messages> messages = [
    Messages(
        text: "Hello 👋\nI am chatter bot 🤖\nHow can i help you",
        isSentByUser: false,
        time: DateTime.now().toString(),
        isLoading: false,
        ispdf: false)
  ].reversed.toList();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      // endDrawer: NavDrawer(),
      appBar: AppBar(
        title: Text(
          "ChatBot",
          style: TextStyle(color: Colors.white60),
        ),
        backgroundColor: Color(0xff3C58EC),
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 48,
            width: 48,
            child: Hero(
              tag: "bot",
              child: Center(
                  child: LottieBuilder.network(
                      'https://assets10.lottiefiles.com/packages/lf20_xh83pj1c.json')),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.green,
            ),
          ),
        ),
      ),
      body: Container(
        color: kChatPageBackgroundColor,
        child: Column(
          children: [
            Expanded(
                child: GroupedListView<Messages, DateTime>(
              padding: EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              elements: messages,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              groupBy: (messages) => DateTime(2022),
              groupHeaderBuilder: (Messages messages) => SizedBox(),
              itemBuilder: (context, Messages message) => Align(
                alignment: message.isSentByUser == true
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                child: message.isLoading == true
                    ? Container(
                        width: w / 7,
                        child: LottieBuilder.network(
                            'https://assets8.lottiefiles.com/private_files/lf30_hpg4y97o.json'),
                      )
                    : message.ispdf == true
                        ? GestureDetector(
                            onTap: () async {
                              PdfDocument document = PdfDocument();
                              final page = document.pages.add();
                              page.graphics.drawString(message.text,
                                  PdfStandardFont(PdfFontFamily.helvetica, 30));
                              dynamic bytes = await document.save();
                              document.dispose();
                              saveAndLaunchFile(bytes, "output.pdf");
                            },
                            child: Card(
                                elevation: 8,
                                color: message.isSentByUser == true
                                    ? kUserResponseColor
                                    : kserverResponseColor,
                                child: const Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(
                                    "Response is too large\nTap to view your message",
                                  ),
                                )),
                          )
                        : Card(
                            elevation: 8,
                            color: message.isSentByUser == true
                                ? kUserResponseColor
                                : kserverResponseColor,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                message.text,
                                style: message.isSentByUser == true
                                    ? kUserChatTextStyle
                                    : kServerChatTextStyle,
                              ),
                            ),
                          ),
              ),
            )),
            Container(
              padding: EdgeInsets.all(5),
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: CHAT_CONTROLLER,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Type Query",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      String query = CHAT_CONTROLLER.text;
                      final message1 = Messages(
                          text: CHAT_CONTROLLER.text,
                          time: DateTime.now().toString(),
                          isSentByUser: true,
                          isLoading: false,
                          ispdf: false);
                      CHAT_CONTROLLER.clear();
                      final message2 = Messages(
                          text: CHAT_CONTROLLER.text,
                          time: DateTime.now().toString(),
                          isSentByUser: false,
                          isLoading: true,
                          ispdf: false);

                      setState(() {
                        messages.add(message1);
                        messages.add(message2);
                      });

                      // Server working

                      await Future.delayed(Duration(seconds: 1));
                      messages.removeLast();
                      var dio = Dio();
                      dynamic response1 = await dio.post(
                          'http://bd67-34-87-145-32.ngrok.io/command',
                          data: {'query': query});
                      print(response1.data);
                      dynamic FlaskAPIResponse = response1.data['answer'];

                      String result = FlaskAPIResponse;
                      final message3 = Messages(
                          text: result,
                          time: DateTime.now().toString(),
                          isSentByUser: false,
                          isLoading: false,
                          ispdf: query.length > 1 && w < 500 ? true : false);
                      messages.add(message3);
                      setState(() {});
                      //
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


// 'James \nWilliam \nHenry \nGeorge \nEdward \nRichard \nChristopher \nThomas \nAlexander \nOliver';