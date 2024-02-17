import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialscan/utils/colors.dart';

class ReusableTextField extends StatelessWidget {
  final String? hintText;
  final dynamic validator;
  final bool? obscure;
  final Widget? iconButton;
  final VoidCallback onTap;
  final dynamic controller;
  final String? initialValue;
  final TextInputType? textInputType;
  const ReusableTextField({
    Key? key,
    this.hintText,
    this.controller,
    required this.onTap,
    this.validator,
    this.obscure,
    this.iconButton,
    this.initialValue,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final keyBoardProvider = Provider.of<KeyboardProvider>(context);
    return SizedBox(
      width: 388,
      height: 53,
      child: TextFormField(
        initialValue: initialValue,
        style: const TextStyle(color: Colors.black, fontSize: 14),

        onTap: onTap,
        validator: validator,
        obscureText: obscure!,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        keyboardType: textInputType,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          // labelText: 'i3dn3kdnk3dn',
          suffixIcon: iconButton ?? iconButton,
          hintStyle: GoogleFonts.montserrat(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            color: Colors.black38,
          ),

          labelStyle: const TextStyle(fontSize: 16.0, color: Colors.grey),
          contentPadding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              width: 0,
              color: ProjectColors.mainGray,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(
              width: 0,
              color: ProjectColors.mainGray,
            ),
            // borderSide: const BorderSide(width: 1.5, color: Colors.grey),
          ),
          fillColor: ProjectColors.mainGray,
          filled: true,
        ),

        // onChanged: (text) {
        //   keyBoardProvider.setKeyboardOpen(text.isNotEmpty);
        // },
      ),
    );
  }
}
