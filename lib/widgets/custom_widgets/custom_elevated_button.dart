// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class CustomELevatedButton extends StatelessWidget {
  const CustomELevatedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.prefixIcon,
    this.size,
    this.textColor,
  });
  final String title;
  final Color? backgroundColor;
  final Color? borderColor;
  final Icon? prefixIcon;
  final Size? size;
  final Color? textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: size ?? Size(_size.width / 2, 50),
          backgroundColor: backgroundColor ?? Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: borderColor ?? Colors.transparent)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefixIcon ?? Container(),
            Text(
              title,
              style: TextStyle(
                  fontSize: 17, fontWeight: FontWeight.w600, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}
