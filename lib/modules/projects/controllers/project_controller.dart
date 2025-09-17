import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/models/project_model.dart';

class ProjectsController extends GetxController {
  final projects = <ProjectModel>[].obs;
  final PageController pageController = PageController(viewportFraction: 0.4);

  @override
  void onInit() {
    super.onInit();

    // Load sample projects (replace with dynamic fetch if needed)
    projects.addAll([
      ProjectModel(
        id: '1',
        title: 'E-Commerce App',
        description: 'A fully responsive e-commerce platform with payment integration.',
        imageUrl: 'assets/images/project1.png',
        technologies: ['Flutter', 'Firebase', 'Stripe'],
        githubUrl: 'https://github.com/yourusername/ecommerce',
        liveUrl: 'https://yourapp.com',
      ),
      ProjectModel(
        id: '2',
        title: 'Task Manager',
        description: 'A productivity app for managing tasks with real-time sync.',
        imageUrl: 'assets/images/project2.png',
        technologies: ['Flutter', 'Node.js', 'MongoDB'],
        githubUrl: 'https://github.com/yourusername/task-manager',
      ),
      ProjectModel(
        id: '3',
        title: 'Portfolio Website',
        description: 'A personal portfolio to showcase projects and skills.',
        imageUrl: 'assets/images/project3.png',
        technologies: ['Flutter', 'GetX', 'Dart'],
      ),
    ]);
  }

  void navigateToProjectDetail(ProjectModel project) {
    Get.toNamed('/project-detail', arguments: project);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
