import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_website/controllers/home_controller.dart';
import 'package:portfolio_website/controllers/project_controller.dart';
import 'package:portfolio_website/models/project_model.dart';

// Home state provider
final homeProvider = StateNotifierProvider<HomeController, HomeState>((ref) => HomeController());

// Projects provider
final projectsProvider = ChangeNotifierProvider<ProjectController>((ref) => ProjectController());

// Selected project provider for detail dialog
final selectedProjectProvider = StateProvider<Project?>((ref) => null);