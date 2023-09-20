import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputForm extends StatelessWidget {
  TextInputType textInputType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  String? labelText;
  Widget? suffixIcon;
  bool? enabled;
  String? initialValue;
  

  InputForm({
    super.key, 
    this.textInputType = TextInputType.none, 
    this.obscureText = false, 
    this.onChanged, 
    this.validator, 
    required this.hintText, 
    this.labelText, 
    this.suffixIcon,
    this.enabled = true,
    this.initialValue = '',
  });

  @override
  Widget build(BuildContext context) {
    // final focusNode = FocusNode();

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TextFormField(
        enabled: enabled,
        // focusNode: focusNode,
        // autofocus: true,
        keyboardType: textInputType,
        obscureText: obscureText,
        textCapitalization: TextCapitalization.words,
        onChanged: onChanged,
        validator: validator,
        initialValue: initialValue,
        // onTapOutside: (event) { // click fuera del teclado
        //   focusNode.unfocus(); 
        // },
        // validator: (value) {
        //   if ( value == null ) return 'Este campo es obligatorio';
        //   return value.length < 6 ? 'Este campo es obligatorio' : null;
        // },
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.blue),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // helperText: 'helperText',
          
          // counterText: '3 caracteres',
          // prefixIcon: Icon( Icons.verified_user_outlined),
          suffixIcon: suffixIcon,
          // icon: Icon(Icons.abc),
        ),
      ),
    );
    
  }
}