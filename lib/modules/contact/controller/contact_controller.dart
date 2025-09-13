import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/models/contact_model.dart';


class ContactController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      final contact = ContactModel(
        name: nameController.text,
        email: emailController.text,
        message: messageController.text,
      );
      // Simulate form submission (print to console for now)
      print('Form Submitted: ${contact.name}, ${contact.email}, ${contact.message}');
      Get.snackbar(
        'Success',
        'Your message has been sent! (Demo)',
        backgroundColor: Colors.blueAccent,
        colorText: Colors.white,
      );
      // Clear form
      nameController.clear();
      emailController.clear();
      messageController.clear();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    messageController.dispose();
    super.onClose();
  }
}