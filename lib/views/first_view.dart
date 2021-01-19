import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ninja/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFF00BFA5);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Container(
          width: _width,
          height: _height,
          color: primaryColor,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(

                children: <Widget>[
                  SizedBox(height: _height * 0.10),
                  Text(
                    "Shift",
                    style: TextStyle(fontSize: 44, color: Colors.white , fontFamily: 'Phamelo'),
                  ),
                  SizedBox(height: _height * 0.06),
                  AutoSizeText(
                    "Manage all the employees shift",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: _height * 0.15),
                  RaisedButton(
                    color: Colors.white,

                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12.0, left: 30.0, right: 30.0),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    onPressed: () {
                      showDialog(

                        context: context,
                        builder: (BuildContext context) => CustomDialog(

                          title: "Would you like to create an account?",
                          description:
                              " ",
                          primaryButtonText: "Sign Up",
                          primaryButtonRoute: "/signUp",

                        ),
                      );
                    },
                  ),
                  SizedBox(height: _height * 0.05),
                  RaisedButton(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, bottom: 12.0, left: 30.0, right: 30.0),
                      child: Text(
                        "Sign In",

                        style: TextStyle(
                        color: primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                      ),
                    ),

                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/signIn');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
