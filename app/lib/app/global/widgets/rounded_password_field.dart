
import 'package:app/app/global/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



// ignore: must_be_immutable
class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final controller;
  bool showPassword;
  Function showPassBtn;

  RoundedPasswordField({
    Key key,
    this.onChanged,
    this.controller,
    this.showPassword = false,
    this.showPassBtn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      
      child: TextFormField(
        validator: (value){
          if(value.isEmpty){
            return 'Campo requerido';
          }
          if(value.length < 6) {
            return 'Minimo 6 caracteres';
          }
          return null;
        },
        obscureText: !showPassword,
        controller: controller,
        onChanged: onChanged,
        cursorColor: Get.theme.primaryColorLight,
        decoration: InputDecoration(
          hintText: "Contraseña",
          // fillColor: Colors.blueAccent,
          // filled: true,
          icon: Icon(
            Icons.lock,
            color: Get.theme.primaryColorLight,
          ),
          suffixIcon: IconButton(icon: Icon(
            Icons.visibility,
            color: Get.theme.primaryColorLight,
            ),
            onPressed: showPassBtn,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}