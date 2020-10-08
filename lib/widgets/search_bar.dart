import 'package:covidapp/services/map_service.dart';
import 'package:covidapp/services/type_ahead_search_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _typeAheadController = TextEditingController();
  // ignore: unused_field
  MapEngine _mapEngineProvider;

  @override
  void initState() {
    super.initState();
    _mapEngineProvider = Provider.of<MapEngine>(context, listen: false);
  }

  @override
  void dispose() {
    _typeAheadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: -10.0, // has the effect of extending the shadow
            offset: Offset(
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
            ),
          )
        ],
      ),
      margin: EdgeInsets.only(
        top: 10,
        right: 10,
      ),
      height: 50,
      // child:,
      child: TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          onEditingComplete: () => {
            // print(this._typeAheadController.text),
            _mapEngineProvider
                .changeMapCameraPosition(this._typeAheadController.text),
            FocusScope.of(context).unfocus()
          },
          decoration: InputDecoration(
            suffix: Container(
              margin: EdgeInsets.only(
                right: 10,
              ),
              child: GestureDetector(
                onTap: () => {
                  _mapEngineProvider
                      .changeMapCameraPosition(this._typeAheadController.text),
                  FocusScope.of(context).unfocus()
                },
                child: Text(
                  "Go",
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            icon: Container(
                margin: EdgeInsets.only(left: 10, top: 5),
                width: 22,
                height: 22,
                child: new Image.asset('assets/icons/search.png')),
            border: InputBorder.none,
            hintText: "Search Country",
            // contentPadding: EdgeInsets.only(left: 10)
          ),
          controller: this._typeAheadController,
        ),
        suggestionsCallback: (pattern) {
          return CitiesService.getSuggestions(pattern);
        },
        itemBuilder: (context, suggestion) {
          return this._typeAheadController.text == ''
              ? Container()
              : ListTile(
                  title: Text(suggestion),
                );
        },
        hideOnEmpty: true,
        onSuggestionSelected: (suggestion) {
          this._typeAheadController.text = suggestion;
        },
      ),
    );
  }
}

class HelpIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 10),
      height: 35,
      width: 35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                    title: new Text("HELP"),
                    content: new Text(
                        "Virus icons represent countries with recorded cases.\nTap on a country to display case details"),
                  ));
        },
        child: Icon(
          FontAwesomeIcons.info,
          color: Colors.white,
          size: 14,
        ),
      ),
    );
  }
}
