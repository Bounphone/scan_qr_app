import 'package:scan_qr_app/view_models/auth_vm.dart';

import '../../packages.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25.h,
                  ),
                  Text(
                    'ເຂົ້າສູ່ລະບົບ',
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 25.sp),
                  ),
                  SizedBox(
                    height: 35.h,
                  ),
                  CustomFormField(
                    hintText: 'ອີເມລ',
                    validator: (val) {
                      if (!val!.isValidEmail)
                        return 'ກະລຸນາປ້ອນອີເມລໃຫ້ຖືກຕ້ອງ';
                      return null;
                    },
                    controller: email,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomFormField(
                    hintText: 'ລະຫັດຜ່ານ',
                    validator: (val) {
                      if (!val!.isValidPassword)
                        return 'ກະລຸນາປ້ອນລະຫັດຜ່ານໃຫ້ຖືກຕ້ອງ';
                    },
                    isObscureText: true,
                    controller: password,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),

                  /// Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthVM>().onLogin(
                              email.text.trim(), password.text.trim(), context);
                        }
                      },
                      child: Text(
                        'ເຂົ້າສູ່ລະບົບ',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'ລືມລະຫັດຜ່ານ',
                          style: TextStyle(
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ທ່ານຍັງບໍ່ທັນມີບັນຊີແມ່ນບໍ?',
                          style: TextStyle(fontSize: 14.sp)),
                      SizedBox(
                        width: 20.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.signup);
                        },
                        child: Text('ລົງທະບຽນ',
                            style: TextStyle(
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 160.h,
                  ),
                  // Center(
                  //     child: Text('Power by CEIT-IoT',
                  //         style: TextStyle(fontSize: 14.sp))),
                  SizedBox(
                    height: 25.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
