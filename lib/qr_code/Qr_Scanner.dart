import 'package:busicard/models/user.dart';
import 'package:busicard/services/database.dart';
import 'package:busicard/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:busicard/Qr_Code/QrGen.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/qr_scanner_overlay_shape.dart';

class QrScan extends StatefulWidget{
  //var yourQR = "harsi";
  @override
  State<StatefulWidget> createState() => QrScanState();

}
class QrScanState extends State<QrScan>{
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
  //var yourQR = "";
  QRViewController controller;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {

          if (snapshot.hasData) {
            UserData userData = snapshot.data;

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
                child: Center(
                  child: RaisedButton(
                    color: Colors.pink[400],
                    child: Text("$qrText"),
                    onPressed: () async {
                      if (!userData.networkHash.contains("$qrText")) {
                        String newHash = userData.networkHash + "$qrText";

                        await DatabaseService(uid: user.uid).updateUserData(
                            userData.businessName,
                            userData.name,
                            userData.tagline,
                            userData.jobTitle,
                            userData.website,
                            userData.email,
                            userData.phone,
                            newHash
                        );
                      }
                    },
                  ),
                ),
              ),


            ],),


            );
          } else {
            return Loading();
          }
        }
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
