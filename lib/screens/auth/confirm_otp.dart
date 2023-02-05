import 'package:flutter_blueprint/packages.dart';

class ConfirmOTPScreen extends StatelessWidget {
  ConfirmOTPScreen({Key? key}) : super(key: key);

  final otp = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ConfirmArgs;
    String username = args.username;
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm OTP'),
      ),
      body: Consumer<AuthVM>(builder: (context, model, _) {
        if (model.getIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NumberTextField(
                    controller: otp,
                    maxLength: 4,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange),
                    onPressed: () {
                      context.read<AuthVM>().reqOTP(username);
                    },
                    child: Text(
                      'Request OTP',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      /// Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        context
                            .read<AuthVM>()
                            .reqToken(username, otp.text, context);
                      }
                    },
                    child: Text(
                      'Confirm OTP',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
