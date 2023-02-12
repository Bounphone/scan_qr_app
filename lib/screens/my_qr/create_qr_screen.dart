import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scan_qr_app/packages.dart';

class CreateQRScreen extends StatefulWidget {
  CreateQRScreen({super.key});

  @override
  State<CreateQRScreen> createState() => _CreateQRScreenState();
}

class _CreateQRScreenState extends State<CreateQRScreen> {
  final qrName = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isOpenLocation = false;
  GoogleMapController? mapController;
  final LatLng _center = const LatLng(45.521563, -54.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarker() {
    return {
      Marker(markerId: MarkerId("marker_1"), position: _center),
      Marker(
        markerId: MarkerId("marker_2"),
        position: LatLng(18.997962200185533, 72.8379758747611),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ສ້າງ QR'),
        backgroundColor: AppColors.BASE_COLOR,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Form(
          key: _formKey,
          child: Column(children: [
            CustomFormField(
              hintText: 'QR Name',
              controller: qrName,
              validator: (val) {
                if (!val!.isValidName) {
                  return 'Please enter qr name';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                Expanded(child: Text('ທ່ານຕ້ອງການລະບຸຕຳແໜ່ງຂອງ QR ຫຼື ບໍ?')),
                SizedBox(
                  width: 15.w,
                ),
                Switch(
                  value: isOpenLocation,
                  onChanged: (value) {
                    setState(() {
                      isOpenLocation = value;
                    });
                  },
                ),
              ],
            ),
            if (isOpenLocation)
              Expanded(
                child: GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 20.0,
                  ),
                ),
              ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
          height: 60.h,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.BASE_COLOR,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0))),
            onPressed: () {
              if (_formKey.currentState!.validate()) {}
            },
            child: Text('ສ້າງ QR'),
          )),
    );
  }
}
