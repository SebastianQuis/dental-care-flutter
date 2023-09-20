import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mostrarAlerta( BuildContext context, String title,String descripcion, List<Widget> listActions){

  if( Platform.isAndroid ) {
    return showDialog(
      context: context, 
      builder: (context) => 
        AlertDialog(
          title: Text(title, style: TextStyle(fontWeight: FontWeight.w700),),
          content: Text(descripcion),
          // backgroundColor: Colors.grey,
          actions: listActions,
        )
    );
  } 
    
  showCupertinoDialog(
    context: context, 
    builder: (context) {
      return CupertinoAlertDialog(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(title)),
        content: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric( vertical: 8 ),
            child: Text(descripcion, style: TextStyle( fontSize: 14),),
          ),
        ),
        actions: listActions,
      );
    },
  );
  

}