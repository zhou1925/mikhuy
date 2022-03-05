
import 'package:app/app/constants/constants.dart';
import 'package:app/app/global/widgets/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final controller;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.phone,
    this.onChanged,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        validator: (value){
          if(value.isEmpty){
            return 'Campo requerido';
          }
          if(value.length < 9) {
            return 'Minimo 9 caracteres';
          }
          return null;
        },
        controller: controller,
        onChanged: onChanged,
        
        cursorColor: kBlackButtonColor,
        decoration: InputDecoration(
          fillColor: Colors.blueAccent,
          icon: Icon(
            icon,
            color: Get.theme.primaryColorLight,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}