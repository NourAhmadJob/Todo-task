import 'package:flutter/material.dart';
import 'package:todotask/core/components/custom_text.dart';
import 'package:todotask/core/utils/app_color.dart';
import 'package:todotask/core/utils/app_size.dart';

class CustomAppButton extends StatelessWidget {
  const CustomAppButton({Key? key, required this.text}) : super(key: key);
  final String text ;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: AppSize.s60,
        decoration: BoxDecoration(
          color: AppColor.primary,
          borderRadius: BorderRadius.circular(AppSize.s14),
        ),
        child: CustomText(
          text:  text,
          size: AppSize.s20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
