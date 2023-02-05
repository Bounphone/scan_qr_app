import '../../packages.dart';

class NumberTextField extends StatelessWidget {
  TextEditingController controller;
  int? maxLength;
  String? hintText;

  NumberTextField({
    required this.controller,
    this.hintText,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintText: hintText ?? "",
        counterText: "",
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide(
            color: Colors.grey,
            width: (2.h + 2.w) / 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide(
            color: Colors.grey,
            width: (2.h + 2.w) / 2,
          ),
        ),
      ),
      controller: controller,
    );
  }
}
