import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_code_scanner_example/widget/button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../main.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String dropdownValue = 'Helwan';
  String qrCode = 'Unknown';
  List<String> array = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyApp.title),
        ),
        body:
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Column(

              children: [
                Center(
                  child: ButtonWidget(
                        text: 'Start QR scan',
                        onClicked: () => scanQRCode(),
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  value: dropdownValue,
                  icon: Icon(Icons.keyboard_arrow_down),
                  items:<String>[ "Helwan",
                    "Ain Helwan",
                    "Helwan University",
                    "Wadi Hof",
                    "Hadayek Helwan",
                    "El-Maasara",

                    "Tora El-Asmant",
                    "Kozzika",
                    "Tora El-Balad",
                    "Sakanat El-Maadi",
                    "Maadi",
                    "Hadayek El-Maadi",
                    "Dar El-Salam",
                    "El-Zahraa'",
                    "Mar Girgis",
                    "El-Malek El-Saleh",
                    "Al-Sayeda Zeinab",
                    "Saad Zaghloul",

                    "Sadat",

                    "Nasser",
                    "Orabi",

                    "Al-Shohadaa",
                    "Ghamra",
                    "El-Demerdash",

                    "Manshiet El-Sadr",
                    "Kobri El-Qobba",
                    "Hammamat El-Qobba",

                    "Saray El-Qobba",
                    "Hadayeq El-Zaitoun",

                    "Helmeyet El-Zaitoun",

                    "El-Matareyya",
                    "Ain Shams",

                    "Ezbet El-Nakhl",
                    "El-Marg",
                    "New El-Marg",
                    "moneb",
                    "Sakiat Mekky",
                    "Omm El-Masryeen",
                    "Giza",
                    "Faisal",
                    "Cairo University",
                    "El Bohoth",
                    "Dokki",
                    "opera",
                    "Sadat",
                    "Mohamed Naguib",
                    "Attaba",
                    "Al Shohadaa",
                    "Masarra",
                    "Rod El-Farag",
                    "St. Teresa",
                    "Khalafawy",
                    "Mezallat",
                    "Kolleyyet El-Zeraa",
                    "Shubra El-Kheima",
                    "Airport",
                    "Ahmed Galal",
                    "Adly Mansour",
                    "El Haykestep",
                    "Omar Ibn El-Khattab",
                    "Qobaa",
                    "Hesham Barakat",
                    "El-Nozha",
                    "Nadi El-Shams",
                    "Alf Maskan",
                    "Heliopolis Square",
                    "Haroun",
                    "Al-Ahram",
                    "Koleyet El-Banat",
                    "Stadium",
                    "Fair Zone",
                    "Abbassiya",
                    "Abdou Pasha",
                    "El-Geish",
                    "Bab El-Shaaria",
                    "Attaba",
                    "Nasser","Maspero","Zamalek","Kit Kat"].map((String items) {
                    return DropdownMenuItem(
                        value: items,
                        child: Text(items,style: TextStyle( color:Colors.red,fontSize: 25),)
                    );
                  }
                  ).toList(),
                  onChanged: (String newValue){
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                )
              ],
            ),
          ),
        )

      );

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;
      Map<String, String> queryParams = {
        "ApiKey":"123456789abcd",
        "Connection":"keep-alive",
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      array = qrCode.split("-");
      print(array[0]);
      print(array[1]);
      var Url = "https://metro-user-api.azurewebsites.net/Machine";
      Uri url = Uri.parse(Url);
      await http.post(url,body: json.encode(
          {"type":array[0] , "reqID":array[1] , "station":dropdownValue} ),headers: queryParams ).then((value) {
        print(value.body);
       var result=jsonDecode(value.body);
       var finalResult=result['message'];
        Fluttertoast.showToast(
            msg: finalResult,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 15,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );


      } );
      setState(()  {
        this.qrCode = qrCode;
      });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
