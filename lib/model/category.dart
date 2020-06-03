import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class Category{
  final String category;
  final double amount;
  final charts.Color color;
  Category(this.category , this.amount , Color color) :
    this.color = new charts.Color(
      r: 0XFFf5eaea , g: 0XFF7fcd91
    );

}