import 'package:portfolio_website/modules/home/bindings/home_binding.dart';
import 'package:portfolio_website/modules/about/bindings/about_binding.dart';
import 'package:portfolio_website/modules/projects/bindings/project_binding.dart';
import 'package:portfolio_website/modules/projects/bindings/project_detail_bindings.dart';
import 'package:portfolio_website/modules/testimonials/bindings/testimonials_binding.dart';
import 'package:portfolio_website/modules/contact/bindings/contact_binding.dart';

class AppBindings {
  static void init() {
    HomeBinding().dependencies();
    AboutBinding().dependencies();
    ProjectsBinding().dependencies();
    ProjectDetailBinding().dependencies();
    TestimonialsBinding().dependencies();
    ContactBinding().dependencies();
  }
}
