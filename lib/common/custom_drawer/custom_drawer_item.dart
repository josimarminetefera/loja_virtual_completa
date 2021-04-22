import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({@required this.iconData, @required this.titulo, @required this.pagina});

  final IconData iconData;
  final String titulo;
  final int pagina;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("Cliquei na página $pagina");
      },
      child: SizedBox(
        height: 60,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: 32,
                color: Colors.grey[700],
              ),
            ),
            Text(
              titulo,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
