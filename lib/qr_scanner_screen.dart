import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  String qrResult = "";
  final MobileScannerController controller = MobileScannerController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scanner"),
        actions: [
          IconButton(
            onPressed: () => controller.toggleTorch(),
            icon: ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, MobileScannerState value, child) {
                switch (value.torchState) {
                  case TorchState.off:
                    return Icon(Icons.flashlight_off);
                  case TorchState.on:
                    return Icon(Icons.flashlight_on);
                  case TorchState.unavailable:
                    return Icon(Icons.flashlight_on);
                  case TorchState.auto:
                    return Icon(Icons.flash_auto);
                }
              },
            ),
          ),
          ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, MobileScannerState value, child) {
              return IconButton(
                onPressed: () => controller.switchCamera(),
                icon: Icon(Icons.switch_camera),
              );
            },
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
                setState(() {
                  qrResult = barcodes.first.rawValue!;
                });
              }
            },
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black26,
          ),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.white, width: 2.0),
            ),
          ),
          Positioned(
            bottom: 80,
            child: Center(
              child: qrResult.isNotEmpty
                  ? Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => _launchURL(qrResult),
                          child: Text(qrResult),
                        ),
                        SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: qrResult));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Скопировано в буфер обмена'),
                              ),
                            );
                          },
                          icon: Icon(Icons.copy, color: Colors.white),
                        ),
                      ],
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String text) async {
    final Uri url = Uri.parse('https://www.google.com/search?q=$text');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
