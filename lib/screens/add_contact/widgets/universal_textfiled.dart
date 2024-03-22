import 'package:contact/utils/colors/app_colors.dart';
import 'package:contact/utils/extensions/project_extensions.dart';
import 'package:contact/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UniversalTextField extends StatelessWidget {
  const UniversalTextField(
      {super.key,
      required this.hintText,
      required this.onChanged,
      required this.onSubmit,
      required this.title,
      this.keyboardType, this.inputController});

  final String title;
  final String hintText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmit;
  final TextInputType? keyboardType;
  final TextEditingController? inputController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.interMedium,
        ),
        5.getH(),
        TextField(
          controller: inputController,
          inputFormatters: [
          if(keyboardType == TextInputType.phone)  FilteringTextInputFormatter.digitsOnly
          ],
          maxLength: keyboardType == TextInputType.phone ? 9 : null,
          decoration: InputDecoration(
            prefixIcon: keyboardType == TextInputType.phone
                ? SizedBox(
                    width: 60.w(),
                    child: Center(
                      child: Text(
                        "+998",
                        style: AppTextStyle.interMedium,
                      ),
                    ),
                  )
                : null,
            fillColor: AppColors.c_9E9E9E,
            hintStyle: AppTextStyle.interMedium.copyWith(fontSize: 18),
            hintText: hintText,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(width: 1, color: Colors.green),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(width: 1, color: Colors.blue),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: BorderSide(width: 1, color: Colors.red),

            ),
          ),
          onChanged: onChanged,
          onSubmitted: onSubmit,
          keyboardType: keyboardType,

        ),
      ],
    );
  }
}
