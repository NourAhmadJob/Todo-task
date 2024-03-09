import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todotask/core/components/custom_text.dart';
import 'package:todotask/core/utils/app_color.dart';
import 'package:todotask/core/utils/app_size.dart';

class StaticContainer extends StatelessWidget {
   const StaticContainer({Key? key , required this.text , this.color = AppColor.primary}) : super(key: key);
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: AppSize.s60.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppSize.s14.r),
      ),
      child: CustomText(
        text:text,
        size: AppSize.s20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

