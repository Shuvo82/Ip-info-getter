import 'package:flutter/material.dart';
class IPInfoValue extends StatelessWidget {
  String text;
  IPInfoValue({
    Key? key,required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(text,
        style: const TextStyle(
            color: Color(0x66ffffff),
            fontSize: 20,

        ),
      ),
    );
  }
}
