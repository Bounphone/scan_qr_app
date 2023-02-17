import '../../packages.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController surname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ລົງທະບຽນ'),
        backgroundColor: AppColors.BASE_COLOR,
        elevation: 0,
        centerTitle: true,
      ),
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
                  'ລົງທະບຽນ',
                  style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 20.sp),
                ),
                SizedBox(
                  height: 35.h,
                ),
                CustomFormField(
                  hintText: 'ຊື່ແທ້',
                  validator: (val) {
                    if (!val!.isValidName) return 'ກະລຸນາປ້ອນຊື່ກ່ອນ';
                    return null;
                  },
                  controller: firstName,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomFormField(
                  hintText: 'ນາມສະກຸນ',
                  validator: (val) {
                    if (!val!.isValidName) return 'ກະລຸນາປ້ອນນາມສະກຸນກ່ອນ';
                    return null;
                  },
                  controller: surname,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomFormField(
                  hintText: 'ອີເມລ',
                  validator: (val) {
                    if (!val!.isValidEmail) return 'ກະລຸນາປ້ອນອີເມລໃຫ້ຖືກຕ້ອງ';
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
                    if (val!.length < 8)
                      return 'ລະຫັດຂອງທ່ານຄວນມີ 8 ຕົວອັກສອນຂຶ້ນໄປ';
                    return null;
                  },
                  controller: password,
                  isObscureText: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomFormField(
                  hintText: 'ຢືນຢັນລະຫັດຜ່ານ',
                  validator: (val) {
                    if (confirmPassword.text != password.text)
                      return 'ລະຫັດຂອງທ່ານບໍ່ກົງກັນ';
                    return null;
                  },
                  controller: confirmPassword,
                  isObscureText: true,
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.BASE_COLOR,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthVM>().onSignUp(
                            firstName.text.trim(),
                            surname.text.trim(),
                            email.text.trim(),
                            password.text.trim(),
                            context);
                      }
                    },
                    child: Text(
                      'ລົງທະບຽນ',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
