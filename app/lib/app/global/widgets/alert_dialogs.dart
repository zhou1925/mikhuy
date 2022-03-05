import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


show_add_cart_dialog(String title) {
  return
  Get.snackbar(
    '${title}',
    'Fue agregado a tu carrito',
    icon: Icon(Icons.notification_important_outlined, color: Colors.white),
    snackPosition: SnackPosition.TOP,
    backgroundColor: Color(0xffF00314),
    borderRadius: 20,
    margin: EdgeInsets.all(15),
    colorText: Colors.white,
    duration: Duration(seconds: 3),
    isDismissible: true,
    dismissDirection: SnackDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

show_failure_dialog() {
  return 
  Get.defaultDialog(
    onConfirm: () {Get.back();},
    buttonColor: Colors.black,
    title: 'Ups!',
    confirmTextColor: Colors.white,
    backgroundColor: Colors.white,
    textConfirm: "Aceptar",
    barrierDismissible: false,
    radius: 25,
    content: Column(
      children: [
        Lottie.asset(
          'assets/json/failure_animation.json',
          width: Get.height * 0.15,
          height: Get.height * 0.15,),
        Text('Algo salio mal, vuelve a intentarlo.')
      ],
    )
  );
}

show_password_not_match_dialog() {
  return 
  Get.defaultDialog(
    onConfirm: () {Get.back();},
    buttonColor: Colors.black,
    title: 'Ups!',
    confirmTextColor: Colors.white,
    backgroundColor: Colors.white,
    textConfirm: "Aceptar",
    barrierDismissible: false,
    radius: 25,
    content: Column(
      children: [
        Lottie.asset(
          'assets/json/failure_animation.json',
          width: Get.height * 0.15,
          height: Get.height * 0.15,),
        Text('Algo salio mal. Al parecer tu contraseña no coincide. vuelve a intentarlo.')
      ],
    )
  );
}


show_order_success_dialog() {
  return
   Get.defaultDialog(
      onConfirm: () {Get.offAllNamed('/home');},
      buttonColor: Colors.black,
      title: '',
      confirmTextColor: Colors.white,
      backgroundColor: Colors.white,
      textConfirm: "Aceptar",
      barrierDismissible: false,
      radius: 25,
      content: Column(
        children: [
          Lottie.asset(
            'assets/json/success_animation.json',
            width: Get.height * 0.15,
            height: Get.height * 0.15,),
          Text('Orden creada exitosamente. Revisa el estado de tu orden en Mis Ordenes')
        ],
      )
    );
}


show_truck_active_dialog() {
  return
   Get.defaultDialog(
      onConfirm: () {Get.back();},
      buttonColor: Colors.black,
      title: '',
      confirmTextColor: Colors.white,
      backgroundColor: Colors.white,
      textConfirm: "Aceptar",
      barrierDismissible: false,
      radius: 25,
      content: Column(
        children: [
          Lottie.asset(
            'assets/json/success_animation.json',
            width: Get.height * 0.15,
            height: Get.height * 0.15,),
          Text('Estamos trabajando en estos momentos :)')
        ],
      )
    );
}

show_no_trucks_active_dialog() {
  return
  Get.defaultDialog(
    onConfirm: () {Get.offAllNamed('/home');},
    buttonColor: Colors.black,
    title: 'Ups!',
    confirmTextColor: Colors.white,
    backgroundColor: Colors.white,
    textConfirm: "Aceptar",
    barrierDismissible: false,
    radius: 25,
    content: Column(
      children: [
        Lottie.asset(
          'assets/json/no_truck_active.json',
          width: Get.height * 0.15,
          height: Get.height * 0.15,),
        Text('Ningun Remolque esta trabajando en estos momentos. :(')
      ],
    )
  );
}


show_success_phone_update_dialog() {
  return
  Get.defaultDialog(
    onConfirm: () {
      Get.offAllNamed('/home');
    },
    buttonColor: Colors.black,
    title: '',
    confirmTextColor: Colors.white,
    backgroundColor: Colors.white,
    textConfirm: "Aceptar",
    barrierDismissible: false,
    radius: 25,
    content: Column(
      children: [
        Lottie.asset(
          'assets/json/success_animation.json',
          width: Get.height * 0.15,
          height: Get.height * 0.15,),
        Text('Tu Numero ha sido actualizado correctamente. Usa tu nuevo numero cuando vuelvas a ingresar :)')
      ],
    )
  );
}


show_password_update_success_dialog() {
  return
  Get.defaultDialog(
    onConfirm: () {
      Get.offAllNamed('/home');
    },
    buttonColor: Colors.black,
    title: '',
    confirmTextColor: Colors.white,
    backgroundColor: Colors.white,
    textConfirm: "Aceptar",
    barrierDismissible: false,
    radius: 25,
    content: Column(
      children: [
        Lottie.asset(
          'assets/json/success_animation.json',
          width: Get.height * 0.15,
          height: Get.height * 0.15,),
        Text('Tu Contraseña ha sido actualizada correctamente. No la olvides :)')
      ],
    )
  );
}

show_password_update_fail_dialog() {
  return
  Get.defaultDialog(
    onConfirm: () {Get.back();},
    buttonColor: Colors.black,
    title: 'Ups!',
    confirmTextColor: Colors.white,
    backgroundColor: Colors.white,
    textConfirm: "Aceptar",
    barrierDismissible: false,
    radius: 25,
    content: Column(
      children: [
        Lottie.asset(
          'assets/json/failure_animation.json',
          width: Get.height * 0.15,
          height: Get.height * 0.15,),
        Text('Algo salio mal. Al parecer tu contraseña no coincide, vuelve a intentarlo. :)')
      ],
    )
  );
}

show_cancel_order_dialog() {
  Get.defaultDialog(
    onConfirm: () {
      Get.offAllNamed('/home');
    },
    buttonColor: Colors.black,
    title: '',
    confirmTextColor: Colors.white,
    backgroundColor: Colors.white,
    textConfirm: "Aceptar",
    barrierDismissible: false,
    radius: 25,
    content: Column(
      children: [
        Text('Tu orden ha sido cancelada correctamente.')
      ],
    )
  );
}

show_account_success() {
  return
  Get.dialog(AlertDialog(
    title: const Text('Hurra!'),
    content: const Text('Tu cuenta ha sido creada correctamente.'),
    actions: [
      TextButton(
          onPressed: () => Get.offAllNamed('/login'), // Close the dialog
          child: const Text('Ingresar'))
    ],
    ));
}


show_contact_manager_dialog() {
  return
  Get.dialog(AlertDialog(
    title: const Text('Atencion al cliente'),
    content: const Text('Para comunicarse con nosotros directamente puede llamarnos al numero: 974292791'),
    actions: [
      TextButton(
          onPressed: () => Get.back(), // Close the dialog
          child: const Text('Cerrar'))
    ],
  ));
}