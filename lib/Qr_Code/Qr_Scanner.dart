import 'package:flutter/material.dart';
import 'package:busicard/Qr_Code/Qr_Scanner.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:busicard/Qr_Code/QrGen.dart';




class MyApp extends StatefulWidget{
  var yourQR = "harsi";
  @override
  State<StatefulWidget> createState() => MyAppState();

}
class MyAppState extends State<MyApp>{
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  //var yourQR = "";
  QRViewController controller;



  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: <Widget>[
      Expanded(
        flex: 5,
        child: QRView(key: qrKey,
          overlay: QrScannerOverlayShape(
            borderRadius: 10,
            borderColor: Colors.red,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: 300,

          ),
          onQRViewCreated: _onQRViewCreate,),
      ),
      Expanded(
        flex: 1,
        child: Center(child: Text("Scan Result: $qrText"),),
      ),


    ],),
        floatingActionButton: FloatingActionButton(

        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => AnApp()));
        },
          tooltip: 'Increment',
          child: Icon(Icons.add),
    )

    );

  }
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller){
    this.controller = controller;
    controller.scannedDataStream.listen((scanData){
      setState(() {
        qrText = scanData;
      });
    });
  }
}
