import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? boardType;

  final bool obscureText;

  final Widget? suffixIcon;
  final String valueKey;

  const CustomField({
    super.key,
    required this.title,
    required this.hint,
    this.controller,
    required this.validator,
    required this.boardType,
    required this.valueKey,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    TextTheme textContext = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: deviceSize.height * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textContext.bodyMedium,
          ),
          TextFormField(
            key: ValueKey(valueKey),
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: deviceSize.width * 0.040,
                color: Colors.black54,
                fontWeight: FontWeight.w800,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              filled: true,
              fillColor: const Color(0xfff9b13e),
              suffixIcon: suffixIcon,
            ),
            style: TextStyle(
              fontSize: deviceSize.width * 0.048,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            textInputAction: TextInputAction.next,
            keyboardType: boardType,
            validator: validator,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
