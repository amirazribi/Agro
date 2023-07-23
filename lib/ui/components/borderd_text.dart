import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final String? text ;
   const BorderedText(this.text,{Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
      ),
      child: Text(text ?? ""),
    );
  }
}
