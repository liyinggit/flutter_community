
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData _kTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  accentColor: Colors.redAccent,
);

class PestoDemo extends StatefulWidget {
  @override
  _PestoDemoState createState() => _PestoDemoState();
}

class _PestoDemoState extends State<PestoDemo> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _kTheme.copyWith(platform: Theme.of(context).platform),

    ) ;
  }
}
