import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hts/services/auth.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: new StreamBuilder(
                stream: Firestore.instance
                    .collection('Bookings')
                    .where("user",
                        isEqualTo: Firestore.instance
                            .collection('Users')
                            .document(userProfile["email"]))
                    .snapshots(),

                // Firestore.instance.collection("Bookings").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text(
                        'Loading...',
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Sorry an error occured"),
                    );
                  }
                  List<DocumentSnapshot> items = snapshot.data.documents;

                  return new ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image(
                                image:
                                    AssetImage(items[index].data['image_url'])),
                            title: Text(items[index].data['hostel_name']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(items[index].data['location']),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.star,
                                        size: 14, color: Colors.blue),
                                    Icon(Icons.star,
                                        size: 14, color: Colors.blue),
                                    Icon(Icons.star,
                                        size: 14, color: Colors.blue),
                                    Icon(Icons.star,
                                        size: 14, color: Colors.blue),
                                    Icon(Icons.star_half,
                                        size: 14, color: Colors.blue)
                                  ],
                                )
                              ],
                            ),
                            trailing: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "GHS ${items[index].data['price'].toString()}"),
                                SizedBox(
                                  height: 8,
                                ),
                                GestureDetector(
                                  onTap: () =>
                                      _deleteBooking(items[index].documentID),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                )
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        );
                      });
                })),
      ),
    );
  }

  void _deleteBooking(docId) {
    Firestore.instance
        .collection('Bookings')
        .document(docId)
        .delete()
        .then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Booking cancelled")));
    });
  }
}
