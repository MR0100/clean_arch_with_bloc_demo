import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kgk/core/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String) onChange;
  const AppTextField(
      {required this.label,
      required this.controller,
      required this.onChange,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          SizedBox(height: 4),
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.kBlack.withAlpha(
                  Color.getAlphaFromOpacity(0.2),
                ),
              ),
            ),
            alignment: Alignment.center,
            child: TextFormField(
              controller: controller,
              onChanged: onChange,
              scrollPadding: EdgeInsets.zero,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.singleLineFormatter,
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
