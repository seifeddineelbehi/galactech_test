import 'package:flutter/material.dart';
import 'package:flutter_template/utils/palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final double fontSize;
  final double borderRadius;
  final Color primary;
  final Color textColor;
  final bool disabled;
  CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.height = 48,
    this.fontSize = 16,
    this.borderRadius = 22.0,
    this.disabled = false,
    this.primary = Palette.textColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: 5.0,
        textStyle: GoogleFonts.poppins(
          color: Palette.textColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
      ).copyWith(
        minimumSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width,
            height,
          ),
        ),
      ),
    );
  }
}
