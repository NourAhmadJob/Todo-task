import 'package:flutter/material.dart';
import 'package:todotask/app/features/todo/presentation/pages/add_update_todo_list.dart';
import 'package:todotask/core/utils/app_color.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key , required this.icon , required this.onPressed}) : super(key: key);
  final IconData icon;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.primary,
      onPressed: onPressed,
      child:  Icon(icon , color: Colors.white,),
    );
  }
}
