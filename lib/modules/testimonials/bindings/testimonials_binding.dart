import 'package:get/get.dart';
import 'package:portfolio_website/modules/testimonials/controllers/testimonial_controller.dart';

class TestimonialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestimonialsController>(() => TestimonialsController());
  }
}