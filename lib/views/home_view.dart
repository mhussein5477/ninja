import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninja/widgets/card.dart';


class HomeView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: StreamBuilder(
          stream: shifts(context),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Container(child: Center(child: Text("No one available")));
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildCard(context, snapshot.data.documents[index])); // buildcard in custom widget
          }
      ),
    );
  }

  Stream<QuerySnapshot>  shifts(BuildContext context) async* {
    yield*  Firestore.instance.collection('shifts').snapshots();
  }



}