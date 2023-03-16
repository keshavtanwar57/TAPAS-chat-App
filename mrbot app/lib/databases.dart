import 'package:flutter/material.dart';
// //import 'package:dropdown_button2/dropdown_button2.dart';

// class Databases extends StatefulWidget {
//   const Databases({Key? key}) : super(key: key);

//   @override
//   State<Databases> createState() => _DatabasesState();
// }

// class _DatabasesState extends State<Databases> {
//   final List<String> items = [
//     'Database 1',
//     'Database 2',
//     'Database 3',
//     'Database 4',
//     'Database 5',
//     'Database 6',
//     'Database 7',
//     'Database 8',
//   ];
//   String? selectedValue;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               Text("DataBase 1"),
//               Expanded(
//                   child: Image.network(
//                       'https://drive.google.com/file/d/1Hd-RFI6ZSs6Qr407zZcY98VRTgdyjwWF/view?usp=sharing')),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class Databases extends StatefulWidget {
  const Databases({Key? key}) : super(key: key);

  @override
  State<Databases> createState() => _DatabasesState();
}

class _DatabasesState extends State<Databases> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Database 1"),
          Container(
              width: double.infinity,
              child: Image.network(
                'https://i.ibb.co/2hZmjXf/db.png',
              ))
        ],
      )),
    );
  }
}
