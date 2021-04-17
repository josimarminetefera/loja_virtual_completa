import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  CustomDrawerItem({@required this.iconData, @required this.titulo});

  final IconData iconData;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 32,
          color: Colors.grey[700],
        ),
        Text(
          titulo,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
