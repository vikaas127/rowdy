import 'package:flutter/material.dart';


/// Default Card border
RoundedRectangleBorder defaultCardBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(10.0),
    topRight: Radius.circular(10.0),
    topLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0),
  ));
}
