import 'package:get/get.dart';
import 'package:portfolio_website/modules/projects/controllers/project_controller.dart';


class ProjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectsController>(() => ProjectsController());
  }
}