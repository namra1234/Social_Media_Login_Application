import 'package:flutter/material.dart';

class Choice {
  const Choice({this.title, this.img, this.price});

  final String title;
  final String img;
  final String price;

}

class ChoiceLst {

  const ChoiceLst({this.id,this.title, this.img});
  final int id;
  final String  title;
  final String img;

}