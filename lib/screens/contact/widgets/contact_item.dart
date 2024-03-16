import 'package:assets/models/contact_model.dart';
import 'package:assets/utils/colors/app_colors.dart';
import 'package:assets/utils/styles/app_text_style.dart';
import 'package:flutter/material.dart';


class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.onCallTap,
    required this.onContactTap,
    required this.contactModel,
  });

  final VoidCallback onCallTap;
  final VoidCallback onContactTap;
  final ContactModel contactModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onContactTap,
      leading: const Icon(
        Icons.account_circle,
        size: 50,
      ),
      title: Text(
        "${contactModel.firstName} ${contactModel.lastName}",
        style: AppTextStyle.interSemiBold.copyWith(color: AppColors.black),
      ),
      subtitle: Text(
        contactModel.phoneNumber,
        style: AppTextStyle.interSemiBold.copyWith(
          color: AppColors.c_8B8B8B,
          fontSize: 14,
        ),
      ),
      trailing: IconButton(
        onPressed: onCallTap,
        icon: const Icon(
          Icons.call,
          color: AppColors.c_08AE2D,
          size: 30,
        ),
      ),
    );
  }
}
