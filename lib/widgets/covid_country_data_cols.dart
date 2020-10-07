import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CountriesDataView extends StatelessWidget {
  final String name;
  final int dataCount;
  final Color color;
  final NumberFormat f = new NumberFormat();

  CountriesDataView({this.name, this.dataCount, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 70,
      // color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              f.format(dataCount),
              style: TextStyle(
                  color: color, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Center(
            child: Text(
              name,
              style: TextStyle(color: color, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
