import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final Color color;
  final Color borderColor;
  final double borderWidth;
  final double radius;
  final double height;
  final Widget icon;
  final VoidCallback onPressed;

  const SocialLoginButton({
    Key key,
    @required this.text,
    this.color: Colors.white,
    this.borderWidth: 1,
    this.textColor: Colors.white,
    this.borderColor: Colors.black12,
    this.fontSize: 15,
    this.radius: 5,
    this.height: 50,
    @required this.icon,
    @required this.onPressed,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: color, side: BorderSide(color: borderColor, width: borderWidth),),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon != null ? icon : SizedBox(),
            Text(
              text,
              style: TextStyle(color: textColor, fontSize: fontSize),
            ),
            icon != null ? Opacity(child: icon, opacity: 0) : SizedBox()
          ],
        ));
  }
}
