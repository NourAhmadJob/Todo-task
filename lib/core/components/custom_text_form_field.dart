// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:todotask/core/utils/app_color.dart';
import 'package:todotask/core/utils/app_size.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller; 
  final String hint;
  final validator;
  const CustomTextFormField({super.key, required this.controller, required this.hint , this.validator});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      style: const TextStyle(
          color: Colors.black
      ),
      cursorColor: Colors.black,
      controller: controller,
      onSaved: (String?value){},
      validator: validator,
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSize.s12))
      ),
    );
  }
}
