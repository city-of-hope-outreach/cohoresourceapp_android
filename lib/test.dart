import 'package:cohoresourceapp_android/data/model/county_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  DatabaseReference _databaseRef;

  List<CountyModel> counties;

  @override
  void initState() {
    super.initState();
    _databaseRef = FirebaseDatabase.instance.reference();

//    Query query = _databaseRef.child("counties").orderByChild("name").once();
//    query.
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("TEST APP")),
      body: Center(
          child: FutureBuilder (
          future: _databaseRef.child("resources").orderByChild("name").once(),
          builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
            if (snapshot.hasData) {
              Map<dynamic, dynamic> values = snapshot.data.value;
              values.forEach((key, values) {
                print('$key: $values');
              });
            }

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget list() {

  }

  ListTile _tile(BuildContext context, String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.deepOrangeAccent,
    ),
  );
}