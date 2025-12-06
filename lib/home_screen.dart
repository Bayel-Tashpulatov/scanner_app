import 'package:flutter/material.dart';
import 'package:scanner_app/qr_scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 24, 16, 120),
        child: Column(
          children: [
            ListTile(
              title: Text('QR Scanner'),
              leading: Icon(Icons.qr_code_scanner),
              tileColor: Colors.blue.shade200,
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QRScannerScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
