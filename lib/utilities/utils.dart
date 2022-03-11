import 'package:flutter/material.dart';
import 'package:laam_assignment/constants/color_constants.dart';

class Utils{

  static void showInSnackBar(var scaffoldKey , String value) {
    scaffoldKey.currentState.showSnackBar( SnackBar(
        content: Text(value) , duration: const Duration(milliseconds: 700),
    ));
  }

  static alertMessage(BuildContext context, String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.error, size: 40.0, color: Colors.white,),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 16.0, right: 16.0, bottom: 10),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      message, style: const TextStyle(color: Colors.black, fontSize: 18.0),),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Container(
                      margin: const EdgeInsets.only(right: 5.0),
                      child: RaisedButton(
                          color: const Color(ColorConstants.mainAppDarkColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Color(ColorConstants.mainAppDarkColor))),
                          elevation: 8.0,
                          disabledTextColor: Colors.white,
                          child: Text(
                            'Close'.toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

}