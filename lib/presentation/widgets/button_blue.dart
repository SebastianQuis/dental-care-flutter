import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final void Function()? onPressed;
  final String nombre;

  const ButtonBlue({super.key,required this.onPressed, required this.nombre});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 45),
        backgroundColor: Colors.blue[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed, 
      child: Text(nombre, style: TextStyle(color: Colors.white, fontSize: 18),)
    );
  }
}