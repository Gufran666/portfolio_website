import 'package:get/get.dart';
import 'package:portfolio_website/modules/contact/controller/contact_controller.dart';


class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
  }
}