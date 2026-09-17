import 'package:flutter/material.dart';

AppBar appBar(){
  return AppBar(
    centerTitle: true,
    title: Text(
      "Project CyberSim",
    ),
    foregroundColor: Colors.redAccent,
  );
}
class SimpleButton extends StatelessWidget {
  const new({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        color: Colors.redAccent,
        child: Row(
          spacing: 10,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}