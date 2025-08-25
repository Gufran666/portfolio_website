import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controllers/home_controller.dart';
import 'controllers/project_controller.dart';

// Home state provider
final homeProvider = StateNotifierProvider<HomeController, HomeState>((ref) => HomeController());

// Projects provider
final projectsProvider = StateNotifierProvider<ProjectController, ProjectState>((ref) => ProjectController());