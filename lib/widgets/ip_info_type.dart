import 'package:flutter/material.dart';
class IPInfoType extends StatelessWidget {
  String text;
  IPInfoType({
    Key? key,required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
