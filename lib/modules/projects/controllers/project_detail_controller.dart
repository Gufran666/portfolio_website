import 'package:get/get.dart';
import 'package:portfolio_website/models/project_model.dart';

class ProjectDetailController extends GetxController {
  late final ProjectModel project;

  @override
  void onInit() {
    super.onInit();

    final arg = Get.arguments;
    if (arg is ProjectModel) {
      project = arg;
    } else {
      // Fallback mock project
      project = ProjectModel(
        id: '1',
        title: 'Project 1',
        description: 'This is a fallback description for Project 1, showcasing innovative solutions built with modern technologies.',
        imageUrl: 'assets/images/project1.jpg',
        technologies: ['Flutter', 'Dart', 'Firebase'],
        githubUrl: 'https://github.com/yourusername/project1',
        liveUrl: 'https://example.com/project1',
      );
    }
  }
}
