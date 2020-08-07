import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class BaobabLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[600],
      child: Center(
          child: SpinKitChasingDots(
        color: Colors.grey[300],
        size: 50.0,
      )),
    );
  }
}
