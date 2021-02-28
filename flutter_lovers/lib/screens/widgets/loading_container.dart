import 'package:flutter/material.dart';

Widget loadingContainer({BuildContext context, double opacity}) {
  return Opacity(
    opacity: opacity,
    child: Container(
      height: 50,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
}
