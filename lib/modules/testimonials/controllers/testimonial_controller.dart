import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/models/testimonial_model.dart';

class TestimonialsController extends GetxController {
  final testimonials = <TestimonialModel>[].obs;
  final PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void onInit() {
    super.onInit();

    // Load sample testimonials (replace with dynamic fetch if needed)
    testimonials.addAll([
      TestimonialModel(
        id: '1',
        clientName: 'John Doe',
        feedback:
            'Working with Gufran was a fantastic experience. His attention to detail and ability to deliver on time exceeded our expectations.',
        clientImageUrl: 'assets/images/client1.png',
        role: 'CEO, TechCorp',
      ),
      TestimonialModel(
        id: '2',
        clientName: 'Jane Smith',
        feedback:
            'The app developed was user-friendly and perfectly aligned with our vision. Highly professional and reliable!',
        clientImageUrl: 'assets/images/client2.png',
        role: 'Freelance Client',
      ),
      TestimonialModel(
        id: '3',
        clientName: 'Alex Brown',
        feedback:
            'Incredible work ethic and expertise in Flutter. The project was a huge success thanks to his skills.',
        clientImageUrl: 'assets/images/client3.png',
        role: 'Project Manager',
      ),
    ]);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
