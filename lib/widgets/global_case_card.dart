import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalCaseCard extends StatelessWidget {
  final Icon dataIcon;
  final String name;
  final Color textColor;
  final int recordedValue;
  final NumberFormat f = new NumberFormat();

  GlobalCaseCard(
      {key, this.dataIcon, this.name, this.textColor, this.recordedValue})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      child: Card(
        elevation: 5,
        shadowColor: Colors.white,
        child: Container(
          height: 100,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  dataIcon,
                  SizedBox(width: 8),
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  f.format(recordedValue),
                  style: TextStyle(color: textColor, fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
