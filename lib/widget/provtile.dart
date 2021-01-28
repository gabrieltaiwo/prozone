import 'package:flutter/material.dart';

class ProvTile extends StatelessWidget {
  final String provTitle;

  ProvTile({this.provTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(provTitle),
    );
  }
}
