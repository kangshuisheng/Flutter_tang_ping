import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RandomColorCotnainer extends StatefulWidget {
  RandomColorCotnainer({Key? key}) : super(key: key);

  @override
  _RandomColorCotnainerState createState() => _RandomColorCotnainerState();
}

class _RandomColorCotnainerState extends State<RandomColorCotnainer> {
  final color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
