import 'package:flutter/material.dart';

class AuthSocialButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color textColor;
  final String icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle textStyle;

  const AuthSocialButton({
    Key? key,
    required this.title,
    required this.icon,
    this.onTap,
    this.textColor = Colors.black,
    this.backgroundColor,
    this.borderColor,
    required this.textStyle,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            side:
                BorderSide(color: borderColor ?? Colors.transparent, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
      ),
      onPressed: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 48,
          minHeight: 48,
          maxWidth: double.infinity,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 8.33,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
