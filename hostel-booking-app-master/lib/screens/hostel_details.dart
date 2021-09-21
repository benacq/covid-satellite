import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hts/models/hostel_nearby.dart';
import 'package:hts/screens/homeScreen.dart';
import 'package:hts/services/auth.dart';
// import 'package:hts/models/hostel_nearby.dart';

class DetailsScreen extends StatefulWidget {
  final HostelNearby hostel;

  const DetailsScreen({this.hostel});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0,
                  )
                ]),
                child: Hero(
                  tag: widget.hostel.imageUrl,
                  child: Image(
                    image: AssetImage(widget.hostel.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                  top: 50,
                  left: 10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.6),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                      ),
                    ),
                  ))
            ],
          ),
          SizedBox(height: 10.0), //was 20
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text(widget.hostel.title,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 15.0),
            child: Text(
              widget.hostel.description,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0),
            child: Row(children: <Widget>[
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Price',
                        style: TextStyle(
                            color: Color(0xFF004AAB).withOpacity(0.5),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10.0),
                      Text('\$${widget.hostel.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF004AAB).withOpacity(0.9),
                          ))
                    ]),
              ),
              //reviews
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Reviews',
                          style: TextStyle(
                              color: Color(0xFF004AAB).withOpacity(0.5),
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500)),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Text(
                            '${widget.hostel.rating}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          ),
                          Icon(Icons.star, size: 14, color: Colors.blue),
                          Icon(Icons.star, size: 14, color: Colors.blue),
                          Icon(Icons.star, size: 14, color: Colors.blue),
                          Icon(Icons.star, size: 14, color: Colors.blue),
                          Icon(Icons.star_half, size: 14, color: Colors.blue)
                        ],
                      )
                    ]),
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Recently booked',
                        style: TextStyle(
                            color: Color(0xFF004AAB).withOpacity(0.5),
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Stack(children: <Widget>[
                        Container(height: 20, width: 80),
                        Positioned(
                            left: 20,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: AssetImage(hostels[0].imageUrl),
                                      fit: BoxFit.cover)),
                            )),
                        Positioned(
                            left: 30,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: AssetImage(hostels[1].imageUrl),
                                      fit: BoxFit.cover)),
                            )),
                        Positioned(
                            left: 40,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      image: AssetImage(hostels[2].imageUrl),
                                      fit: BoxFit.cover)),
                            )),
                        Positioned(
                            left: 50,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFF003AAB)),
                              child: Center(
                                  child: Text(
                                '+3',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              )),
                            ))
                      ])
                    ]),
              )
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
            child: Text(
              'Amenities',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
          ),
          SizedBox(height: 10 //was 20
              ),
          Row(children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 2),
                        ]),
                    child: Center(
                        child: Icon(Icons.directions_car,
                            color: Color(0xFF003AA8).withOpacity(0.8))),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Parking',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF004AAB).withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 2),
                        ]),
                    child: Center(
                        child: Icon(Icons.hot_tub,
                            color: Color(0xFF003AA8).withOpacity(0.8))),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bath',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF004AAB).withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 2),
                        ]),
                    child: Center(
                        child: Icon(Icons.local_bar,
                            color: Color(0xFF003AA8).withOpacity(0.8))),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Bar',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF004AAB).withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 2),
                        ]),
                    child: Center(
                        child: Icon(Icons.wifi,
                            color: Color(0xFF003AA8).withOpacity(0.8))),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Wifi',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF004AAB).withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 2),
                        ]),
                    child: Center(
                        child: Icon(Icons.directions_bike,
                            color: Color(0xFF003AA8).withOpacity(0.8))),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Gym',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF004AAB).withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4.0, 6.0),
                              blurRadius: 10.0,
                              spreadRadius: 2),
                        ]),
                    child: Center(
                        child: Icon(Icons.more_horiz,
                            color: Color(0xFF003AA8).withOpacity(0.8))),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'More',
                    style: TextStyle(
                      fontSize: 10,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF004AAB).withOpacity(0.7),
                    ),
                  )
                ],
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 15.0, bottom: 5),
            child: Row(children: <Widget>[
              Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0)
                      ]),
                  child: Center(
                      child: Icon(Icons.favorite_border,
                          color: Color(0xFF003AA8).withOpacity(0.5),
                          size: 40.0))),
              SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  _addData();
                },
                child: Container(
                    width: 220,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0xFF003AA8),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0)
                        ]),
                    child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Book now',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ))),
              )
            ]),
          )
        ],
      ),
    );
  }

  void _addData() {
    setState(() {
      isLoading = true;
    });
    Firestore.instance.collection('Bookings').add({
      'user':
          Firestore.instance.collection('Users').document(userProfile["email"]),
      'price': widget.hostel.price,
      'location': widget.hostel.description,
      'hostel_name': widget.hostel.title,
      'image_url': widget.hostel.imageUrl,
      'rating': widget.hostel.rating
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Hostel booked successfully")));
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occured, please try again")));
    });
  }
}
