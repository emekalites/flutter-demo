import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

var unescape = new HtmlUnescape();
var naira = unescape.convert("&#8358;");

class TextEntity extends StatelessWidget {
final String _price;
final Color _color;

  TextEntity(this._price, this._color);

  @override
  Widget build(BuildContext context) {
    return Text(
        naira + _price,
        style: TextStyle(color: _color),
      );
  }
}