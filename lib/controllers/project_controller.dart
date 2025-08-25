import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/failure.dart';
import '../models/project_model.dart';

enum LoadingStatus { loading, success, error }

class ProjectState {
  final List<Project> projects;
  final LoadingStatus status;
  final Failure? failure;

  ProjectState({
    this.projects = const [],
    this.status = LoadingStatus.loading,
    this.failure,
  });

  ProjectState copyWith({
    List<Project>? projects,
    LoadingStatus? status,
    Failure? failure,
  }) {
    return ProjectState(
      projects: projects ?? this.projects,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}

class ProjectController extends StateNotifier<ProjectState> {
  ProjectController() : super(ProjectState()) {
    loadProjects();
  }

  void loadProjects() {
    state = state.copyWith(status: LoadingStatus.loading);
    final result = Project.getProjects();
    result.fold(
      (failure) => state = state.copyWith(status: LoadingStatus.error, failure: failure),
      (projects) => state = state.copyWith(status: LoadingStatus.success, projects: projects),
    );
  }
}