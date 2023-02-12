import '../../packages.dart';

class AppDialog extends StatelessWidget {
  String message;
  AppDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30.h,
          ),
          Text(message),
          SizedBox(
            height: 30.h,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.w),
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ປິດ'),
            ),
          )
        ],
      ),
    );
  }
}
