import 'package:get/get.dart';
import 'package:portfolio_website/models/testimonial_model.dart';


class TestimonialsController extends GetxController {
  final testimonials = <TestimonialModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Sample testimonials; replace with your own
    testimonials.addAll([
      TestimonialModel(
        id: '1',
        clientName: 'John Doe',
        feedback: 'Working with [Your Name] was a fantastic experience. Their attention to detail and ability to deliver on time exceeded our expectations.',
        clientImageUrl: 'assets/images/client1.png',
        role: 'CEO, TechCorp',
      ),
      TestimonialModel(
        id: '2',
        clientName: 'Jane Smith',
        feedback: 'The app developed was user-friendly and perfectly aligned with our vision. Highly professional and reliable!',
        clientImageUrl: 'assets/images/client2.png',
        role: 'Freelance Client',
      ),
      TestimonialModel(
        id: '3',
        clientName: 'Alex Brown',
        feedback: 'Incredible work ethic and expertise in Flutter. The project was a huge success thanks to their skills.',
        role: 'Project Manager',
      ),
    ]);
  }
}