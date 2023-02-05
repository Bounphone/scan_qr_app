import 'package:flutter_blueprint/packages.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthLocal.getUserName().then((value) {
      if (value != null) {
        phoneNumber.text = value ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NumberTextField(
                controller: phoneNumber,
                maxLength: 10,
              ),
              SizedBox(
                height: 20.h,
              ),
              ElevatedButton(
                onPressed: () {
                  /// Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    context.read<AuthVM>().validateUser(phoneNumber.text);
                    Navigator.pushNamed(context, AppRoutes.confirmOTP,
                        arguments: ConfirmArgs(username: phoneNumber.text));
                  }
                },
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
