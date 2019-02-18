import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

var unescape = new HtmlUnescape();
var naira = unescape.convert("&#8358;");

class PriceTag extends StatelessWidget {
  final String _price;

  PriceTag(this._price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        naira + _price,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
