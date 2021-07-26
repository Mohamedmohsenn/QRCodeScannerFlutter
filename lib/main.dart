import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_code_scanner_example/page/qr_scan_page.dart';
import 'package:qr_code_scanner_example/widget/button_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'QR Code Scanner';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primaryColor: Color(0xffa80f14),
          scaffoldBackgroundColor: Colors.black,
        ),
        home: QRScanPage(),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    this.title,
  });






  @override
  _MainPageState createState() => _MainPageState();
}





class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
      );
}


