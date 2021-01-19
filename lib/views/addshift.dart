import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Addshift extends StatefulWidget {
  @override
  _AddshiftState createState() => _AddshiftState();
}

class _AddshiftState extends State<Addshift> {
  String name;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String appointmentdate= DateFormat('dd/MM/yyyy').format(selectedDate).toString();
    String appointmenttime = selectedTime.toString();
    return Scaffold(
      body: SingleChildScrollView(
          child: Container(
                child: Form(
                  key: _formKey ,
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
                        padding: const EdgeInsets.only(top: 8.0,),
                        child: Text("Add shift"),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 38, right: 38 , bottom: 8),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {
                            setState(() =>   name = value.trim());
                          } ,
                          keyboardType: TextInputType.text ,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "Name",
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top:18.0),
                        child: Text(DateFormat('dd/MM/yyyy').format(selectedDate).toString() +" , "+ appointmenttime),
                      ),

                      RaisedButton(
                        onPressed: () => _selectDate(context),
                        child: Text('Select Date', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.green,
                      ),

                      RaisedButton(
                        onPressed: () => _selecttime(context),
                        child: Text("Select Time" , style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        color: Colors.green,
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
                          onPressed:
                          name == null ? null : () async{

                            Firestore.instance.collection('shifts').add({
                              "name" : name,
                              "time" : appointmenttime,
                              "date": appointmentdate

                            });
                            Navigator.of(context).pushReplacementNamed('/home');
                            successfullysent(context, name);

                          },
                        ),
                      ),

                        ],
                  ),
                ) ,
          ) ,
      ),
    );
  }
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
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
              borderRadius: BorderRadius.circular(0),
            ),
            title: Text("Successfully add", style: TextStyle(color: Colors.green),),
            content: Text( name.toUpperCase() + " shift has started" , style: TextStyle(fontSize: 13),),
          );
        }
    );
  }
}
