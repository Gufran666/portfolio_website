import 'package:get/get.dart';
import 'package:portfolio_website/models/project_model.dart';


class ProjectDetailController extends GetxController {
  late ProjectModel project;

  @override
  void onInit() {
    super.onInit();
    project = Get.arguments as ProjectModel;
  }
}