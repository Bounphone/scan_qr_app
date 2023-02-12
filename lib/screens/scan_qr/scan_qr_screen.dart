import 'package:scan_qr_app/packages.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  Position? position;

  @override
  void reassemble() {
    super.reassemble();

    controller!.resumeCamera();
  }

  @override
  void initState() {
    super.initState();
    Geolocator.getLastKnownPosition().then((value) {
      setState(() {
        position = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
        backgroundColor: AppColors.BASE_COLOR,
        elevation: 0,
      ),
      backgroundColor: AppColors.BASE_COLOR,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r)),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Column(children: [
                  Icon(Icons.document_scanner_sharp, size: (60.h + 60.w) / 2, color: Colors.orange,),
                  SizedBox(height: 20.h,),
                  Text(
                    'Scanning our standard QR code is a quick and easy way to access valuable information and services.',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.r)),
                    height: 300.h,
                    child: QRView(
                      key: qrKey,
                      onQRViewCreated: (QRViewController controller) {
                        this.controller = controller;
                        controller.resumeCamera();
                        controller.scannedDataStream.listen((scanData) async {
                          result = scanData;
                          if (result != null) {
                            if (result!.code!.isNotEmpty) {}
                          }
                        });
                      },
                      overlay: QrScannerOverlayShape(
                        borderColor: Colors.white,
                        borderLength: 20,
                        borderRadius: 15.r,
                        borderWidth: 10,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h,)
                ]),
              ),
            ),
          ],
        ),
      ),
      // body: Stack(
      //   children: [
      //     Column(
      //       children: [
      //         Expanded(
      // child: QRView(
      //   key: qrKey,
      //   onQRViewCreated: (QRViewController controller) {
      //     this.controller = controller;
      //     controller.resumeCamera();
      //     controller.scannedDataStream.listen((scanData) async {
      //       result = scanData;
      //       if (result != null) {
      //         if (result!.code!.isNotEmpty) {}
      //       }
      //     });
      //   },
      //   overlay: QrScannerOverlayShape(
      //       borderColor: Colors.white,
      //       borderLength: 20,
      //       borderRadius: 15.r,
      //       borderWidth: 10,
      //       cutOutSize: MediaQuery.of(context).size.width * 0.75),
      // ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
