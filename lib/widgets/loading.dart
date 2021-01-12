import 'package:flutter/material.dart';
import 'package:jitney/helpers/style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: white,
      child: SpinKitFadingCircle(
        color: orange,
        size: 30,
      ),
    );
  }
}