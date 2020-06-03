import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenses_calculator/model/category.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class BarGraph extends StatelessWidget {
  final DocumentSnapshot data;
  final String type;
  BarGraph({this.data , this.type});
  choseColor(String type , String chosenType){
    if(type == chosenType){
      return Colors.green;
    }
    else{
      return Colors.white;
    }
  }
  @override
  Widget build(BuildContext context) {
    var barData = [
      new Category('Total', data['total'], Colors.white),
      new Category('Transport', data['$type'], choseColor('Transport' , this.type)),
      new Category('Telephone', data['$type'], choseColor('Telephone' , this.type)),
      // new Category('Stationery', data[type], choseColor('Stationery' , this.type)),
      // new Category('Shopping', data[type], choseColor('Shopping' , this.type)),
      // new Category('Rent', data[type], choseColor('Rent' , this.type)),
      // new Category('Personal', data[type], choseColor('Personal' , this.type)),
      // new Category('Office', data[type], choseColor('Office' , this.type)),
      // new Category('Miscellaneous', data[type], choseColor('Miscellaneous' , this.type)),
      // new Category('Household', data[type], choseColor('Household' , this.type)),
      // new Category('Food', data[type], choseColor('Food' , this.type)),
      // new Category('Entertainment', data[type], choseColor('Entertainment' , this.type)),
      // new Category('Educational', data[type], choseColor('Educational' , this.type)),
      // new Category('Conveyance', data[type], choseColor('Conveyance' , this.type)),
      // new Category('Beauty', data[type], choseColor('Beauty' , this.type)),
    ];
    var series = [
      new charts.Series<Category , String>(
        id: 'Amount',
        domainFn: (Category data , _) => data.category,
        measureFn: (Category data , _) => data.amount,
        colorFn: (Category data , _) => data.color,
        data: barData,
      ),
    ];
    var chart = new charts.BarChart(
      series,
      animate: true,
    );
    var chartWidget = new Padding(
      padding: EdgeInsets.all(8.0),
      child: new SizedBox(
        height: 200,
        child: chart,
      ),
    );
    return chartWidget;
  }
}