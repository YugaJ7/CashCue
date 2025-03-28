import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/app_colors.dart';
import '../../style/text.dart';

class AuthTextField extends StatelessWidget {
  final String label, hint, icon;
  final TextEditingController controller;
  final RxBool obscureText; 
  final VoidCallback? toggleObscureText;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.obscureText, 
    this.toggleObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.withColor(textcolor: AppColors.grey).bodytext1,
        ),
        const SizedBox(height: 4),
        Obx(() {
          return TextField(
            controller: controller,
            obscureText: obscureText.value, 
            style: TextStyles.withColor(textcolor: AppColors.grey).bodytext1,
            cursorColor: AppColors.grey,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyles.withColor(textcolor: AppColors.grey).bodytext1,
              prefixIcon: Image.asset(icon, scale: 3),
              suffixIcon: toggleObscureText != null
                  ? IconButton(
                      icon: Icon(
                        obscureText.value ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: toggleObscureText,
                      color: AppColors.grey,
                    )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:  Color(0xFFDADADA)),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color:  Color(0xFFDADADA)),
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: const Color(0xFFF7F8F9),
              filled: true,
            ),
          );
        }),
      ],
    );
  }
}