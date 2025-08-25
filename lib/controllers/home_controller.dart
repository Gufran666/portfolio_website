import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartz/dartz.dart';
import '../models/failure.dart';

class HomeState {
  final bool isDarkMode;
  final String currentSection;

  HomeState({this.isDarkMode = true, this.currentSection = 'home'});

  HomeState copyWith({bool? isDarkMode, String? currentSection}) {
    return HomeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      currentSection: currentSection ?? this.currentSection,
    );
  }
}

class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(HomeState());

  void toggleTheme() {
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }

  void navigateToSection(String section) {
    state = state.copyWith(currentSection: section);
  }

  // Example error-handled method (for future backend)
  Either<Failure, bool> performAction() {
    // Logic here
    return const Right(true);
  }
}