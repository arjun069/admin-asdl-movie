import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final dbRef = FirebaseDatabase.instance.reference().child("movies");
  final dbRefupcoming =
      FirebaseDatabase.instance.reference().child("upcomingmovies");
  List<Map<dynamic, dynamic>> lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: dbRef.once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      lists.clear();
                      Map<dynamic, dynamic> values = snapshot.data.value;
                      values.forEach((key, values) {
                        lists.add(values);
                      });
                      return new ListView.builder(
                          shrinkWrap: true,
                          itemCount: lists.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (lists[index]["thisorthat"] == "Current") {
                              return Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Name: " + lists[index]["name"]),
                                    // Image.network(lists[index]["url"]),
                                    Text("Age: " + lists[index]["url"]),
                                    Text("Type: " + lists[index]["type"]),
                                    Text("thisorthat : " +
                                        lists[index]["thisorthat"])
                                  ],
                                ),
                              );
                            }
                          });
                    }
                    return CircularProgressIndicator();
                  }),
              FutureBuilder(
                  future: dbRefupcoming.once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      lists.clear();
                      Map<dynamic, dynamic> values = snapshot.data.value;
                      values.forEach((key, values) {
                        lists.add(values);
                      });
                      return new ListView.builder(
                          shrinkWrap: true,
                          itemCount: lists.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Name: " + lists[index]["name"]),
                                  // Image.network(lists[index]["url"]),
                                  Text("Age: " + lists[index]["url"]),
                                  Text("Type: " + lists[index]["type"]),
                                  Text("thisorthat : " +
                                      lists[index]["thisorthat"])
                                ],
                              ),
                            );
                          });
                    }
                    return CircularProgressIndicator();
                  })
            ],
          ),
        ));
  }
}
