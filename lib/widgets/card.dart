import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninja/views/endshift.dart';


Widget buildCard(BuildContext context, DocumentSnapshot shift) {


  return new Container(
    child: FlatButton(
      onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Endshift(
              name: shift['name'],
              time :shift['time'],
              date : shift['date'],
              shiftid : shift.documentID
          )),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(top : 16.0 , bottom: 16),
          child: Column(
            children: <Widget>[

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(
                      shift['name'].toUpperCase(),
                      style:TextStyle(fontSize: 18 , fontWeight: FontWeight.w600, color: Colors.green) ,),
                  ),
                ],
              ),


           
              Padding(
                padding: const EdgeInsets.only(top:8.0,left: 8),
                child: Row(
                  children: <Widget>[
                    Text(shift['time'], style: TextStyle(fontSize: 14),),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 2.0, bottom: 5.0,left: 8),
                child: Row(
                  children: <Widget>[
                    Text(shift['date'], style: new TextStyle(fontSize: 14.0),),


                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    ),
  );
}
Future delete(context , shiftid) async{
  String documentId = shiftid;
  Firestore.instance.collection('shifts').document(documentId).delete();
}

Future successfullyDeleted(context, task){
  String name = task;
  showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text("Deleted", style: TextStyle(color: Colors.red),),
          content: Text( name.toUpperCase() + " is deleted from the list" , style: TextStyle(fontSize: 13),),
        );
      }
  );
}


