import 'package:flutter/material.dart';
class TextSection extends StatelessWidget {
  final String _title;
  final String _body;
  static const hPad =  16.0;
  //constructor
  TextSection( this._title, this._body);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
         padding: const EdgeInsets.fromLTRB( hPad, 32.0, hPad, 4.0),
          child: Text(
              _title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB( hPad, 4.0, hPad, 32.0),
          child: Text(_body,
            style: TextStyle(
                fontSize: 16.0,
            ),),
        )
      ],
    );;
  }
}
