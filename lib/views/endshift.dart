import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Endshift extends StatefulWidget {
  final String name, date ,  time , shiftid;

  const Endshift({Key key, this.name, this.date, this.time, this.shiftid}) : super(key: key);
  @override
  _EndshiftState createState() => _EndshiftState();
}

class _EndshiftState extends State<Endshift> {
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    String appointmenttime = selectedTime.toString();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0 ,left: 10),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text("End shift",  style: TextStyle(fontSize: 18),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:29.0),
                child: Text(widget.name.toUpperCase()),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text(widget.date.toUpperCase()),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text("Start : "+ widget.time.toUpperCase()),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text("End : "+appointmenttime),
              ),

              RaisedButton(
                onPressed: () => _selecttime(context),
                child: Text("End shift" , style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(top:35.0, bottom: 200),
                child: RaisedButton(
                  color: Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 13.0, bottom: 13.0, left: 23.0, right: 23.0),
                    child: Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  onPressed: () async{

                    Firestore.instance.collection('endshifts').add({
                      "name" : widget.name,
                      "starttime" : widget.time,
                      "date": widget.date,
                      "endtime": appointmenttime

                    });
                    delete(context, widget.shiftid);
                    Navigator.of(context).pushReplacementNamed('/home');
                    successfullysent(context, widget.name);

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _selecttime(BuildContext context) async{
    TimeOfDay timepicked = await showTimePicker(
      context: context,
      initialTime: selectedTime,

    );
    if (timepicked != null && timepicked != selectedTime){
      setState(() {
        selectedTime = timepicked;
      });
    }
  }
  Future successfullysent(context, workername){
    String name = workername;
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text("Successfully Ended", style: TextStyle(color: Colors.green),),
            content: Text( name.toUpperCase() + " ended the shift" , style: TextStyle(fontSize: 13),),
          );
        }
    );
  }
  Future delete(context , shiftid) async{
    String documentId = shiftid;
    Firestore.instance.collection('shifts').document(documentId).delete();
  }
}
