import 'package:dartz/dartz.dart';
import '../models/failure.dart';

class Project {
  final String title;
  final String description;
  final String techStack;
  final String liveUrl;
  final String cachedUrl; // Optional

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    required this.liveUrl,
    this.cachedUrl = '',
  });

  // Example factory for error handling (if fetching from backend later)
  static Either<Failure, List<Project>> getProjects() {
    // Hardcoded for frontend; replace with API call later
    return Right([
      const Project(
        title: 'ChartNodes',
        description: 'Minecraft servers hosting',
        techStack: 'HTML, SCSS, Python Flask',
        liveUrl: 'https://example.com/chartnodes',
        cachedUrl: 'https://example.com/cached',
      ),
      const Project(
        title: 'ProtectX',
        description: 'Discord anti-crash bot',
        techStack: 'React, Express, Discord.Js, Node.Js',
        liveUrl: 'https://example.com/protectx',
      ),
      const Project(
        title: 'Kahoot Answers',
        description: 'Get answers to your kahoot quiz',
        techStack: 'CSS, Express, Node.Js',
        liveUrl: 'https://example.com/kahoot',
      ),
    ]);
  }
}