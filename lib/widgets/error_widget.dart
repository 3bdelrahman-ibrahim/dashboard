// import 'package:flutter/material.dart';
// import 'package:salamspace/widgets/custom_text.dart';

// class ErrorWidget extends StatelessWidget {
//   final String errorMessage;

//   const ErrorWidget({Key? key, this.errorMessage = "An error occurred."})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               Icons.error_outline,
//               color: Colors.red,
//               size: 50,
//             ),
//             const SizedBox(height: 16),
//             CustomText(
//               errorMessage,
//               color: Colors.red,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 // Define an action, such as retrying
//                 Navigator.pop(context);
//               },
//               child: CustomText("Retry"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
