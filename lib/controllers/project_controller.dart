import 'package:flutter/material.dart';
import 'package:portfolio_website/models/failure.dart';
import 'package:portfolio_website/models/project_model.dart';

enum LoadingStatus { initial, loading, success, error }

class ProjectController extends ChangeNotifier {
  ProjectState _state = const ProjectState(status: LoadingStatus.initial, projects: [], failure: null);

  ProjectState get state => _state;

  ProjectController() {
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    _state = const ProjectState(status: LoadingStatus.loading, projects: [], failure: null);
    notifyListeners();

    final result = Project.getProjects();

    result.fold(
      (failure) {
        _state = ProjectState(status: LoadingStatus.error, projects: [], failure: failure);
        notifyListeners();
      },
      (projects) {
        _state = ProjectState(status: LoadingStatus.success, projects: projects, failure: null);
        notifyListeners();
      },
    );
  }
}

class ProjectState {
  final LoadingStatus status;
  final List<Project> projects;
  final Failure? failure;

  const ProjectState({
    required this.status,
    required this.projects,
    this.failure,
  });
}