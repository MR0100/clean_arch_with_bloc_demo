import 'package:flutter/material.dart';
import 'package:kgk/core/styles/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isOutlined;
  const AppButton(
      {required this.label,
      required this.onTap,
      this.isOutlined = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isOutlined
              ? AppColors.kTransparent
              : (onTap == null
                  ? AppColors.kButtonDisabled
                  : AppColors.kPrimary),
          borderRadius: BorderRadius.circular(6),
          border: isOutlined
              ? Border.all(
                  color: onTap == null
                      ? AppColors.kButtonDisabled
                      : AppColors.kPrimary)
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: onTap == null
                ? (isOutlined ? AppColors.kButtonDisabled : AppColors.kWhite)
                : (isOutlined ? AppColors.kPrimary : AppColors.kWhite),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
