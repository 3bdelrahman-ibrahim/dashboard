import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  _QrScannerPageState createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController _scannerController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );
  String lastCode = '';
  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 27, 27),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                FutureBuilder(
                  future: _scannerController.start(), // بدء تشغيل الكاميرا
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      ); // تحميل أثناء فتح الكاميرا
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "لا يوجد إذن للوصول إلى الكاميرا",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ); // عرض رسالة عند رفض الإذن
                    }

                    return Stack(
                      children: [
                        MobileScanner(
                          controller: _scannerController,
                          onDetect: (capture) {
                            final List<Barcode> barcodes = capture.barcodes;
                            for (final barcode in barcodes) {
                              debugPrint('Barcode found: ${barcode.rawValue}');
                              setState(() {
                                lastCode = barcode.rawValue.toString();
                              });
                            }
                          },
                        ),
                        Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    color: Color.fromARGB(182, 15, 15, 15),
                                  ),
                                  Center(
                                    child: Text(
                                      'QR Code Scanner',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 240,
                                    color: const Color.fromARGB(
                                      182,
                                      15,
                                      15,
                                      15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 0,
                                        right: -0.3,

                                        child: Transform.rotate(
                                          angle: pi / 2,
                                          child: ClipPath(
                                            clipper: ArcClipper(),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              color: Color.fromARGB(
                                                182,
                                                15,
                                                15,
                                                15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: -0.3,

                                        child: Transform.rotate(
                                          angle: pi,
                                          child: ClipPath(
                                            clipper: ArcClipper(),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              color: Color.fromARGB(
                                                182,
                                                15,
                                                15,
                                                15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: -0.3,
                                        child: Transform.rotate(
                                          angle: pi * 1.5,
                                          child: ClipPath(
                                            clipper: ArcClipper(),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              color: Color.fromARGB(
                                                182,
                                                15,
                                                15,
                                                15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: -0.3,
                                        child: ClipPath(
                                          clipper: ArcClipper(),
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            color: Color.fromARGB(
                                              182,
                                              15,
                                              15,
                                              15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Opacity(
                                          opacity: 0.5,
                                          child: Image.asset(
                                            'assets/images/qr.png',
                                            width: 200,
                                            height: 200,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 240,
                                    color: const Color.fromARGB(
                                      182,
                                      15,
                                      15,
                                      15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    color: Color.fromARGB(182, 15, 15, 15),
                                  ),
                                  Center(
                                    child: Text(
                                      lastCode,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(50, 0);
    path.conicTo(0, 0, 0, 50, 1);
    path.lineTo(0, 50);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(theme: ThemeData.dark(), home: ClipPathTest());
//   }
// }

// class ClipPathTest extends StatefulWidget {
//   @override
//   _ClipPathTestState createState() => _ClipPathTestState();
// }

// class _ClipPathTestState extends State<ClipPathTest> {
//   bool isUpdated = false;

//   // Custom ClipPath
//   Path _clipPath() {
//     final path = Path();
//     path.lineTo(0, 0);
//     path.lineTo(200, 0);
//     path.lineTo(100, 100); // Clip this part to create a triangular shape
//     path.close();
//     return path;
//   }

//   // Method to simulate saving and updating the ClipPath
//   void _saveAndUpdateClip() {
//     setState(() {
//       isUpdated = !isUpdated; // Toggle update
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('ClipPath Update Test')),
//       body: Center(
//         child: GestureDetector(
//           onTap: _saveAndUpdateClip, // Update clip when tapped
//           child: ClipPath(
//             clipper:
//                 isUpdated
//                     ? CustomClipperPathUpdated() // Apply updated path
//                     : CustomClipperPath(), // Apply default path
//             child: Container(height: 200, width: 200, color: Colors.blue),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Default CustomClipperPath
// class CustomClipperPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, 0);
//     path.lineTo(50, 0);
//     path.conicTo(0, 0, 0, 50, 1);
//     path.lineTo(0, 50);
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// // Updated CustomClipperPath (New Path)
// class CustomClipperPathUpdated extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     path.lineTo(0, 0);
//     path.lineTo(250, 0);
//     path.lineTo(125, 150); // New triangular shape
//     path.close();
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true; // Update when the clip changes
//   }
// }
