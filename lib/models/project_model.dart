import 'package:dartz/dartz.dart';
import 'package:portfolio_website/models/failure.dart';

class Project {
  final String title;
  final String description;
  final String techStack;
  final String githubUrl;
  final List<String> images;

  const Project({
    required this.title,
    required this.description,
    required this.techStack,
    this.githubUrl = '',
    this.images = const [],
  });

  static Either<Failure, List<Project>> getProjects() {
    return Right([
      const Project(
        title: 'ChartNodes',
        description: 'Minecraft servers hosting',
        techStack: 'HTML, SCSS, Python Flask',
        githubUrl: 'https://github.com/user/chartnodes',
        images: [
          'https://via.placeholder.com/800x400/FF0000/FFFFFF?text=ChartNodes+Image+1',
          'https://via.placeholder.com/800x400/00FF00/FFFFFF?text=ChartNodes+Image+2',
          'https://via.placeholder.com/800x400/0000FF/FFFFFF?text=ChartNodes+Image+3',
        ],
      ),
      const Project(
        title: 'ProtectX',
        description: 'Discord anti-crash bot',
        techStack: 'React, Express, Discord.Js, Node.Js',
        githubUrl: 'https://github.com/user/protectx',
        images: [
          'https://via.placeholder.com/800x400/FFFF00/000000?text=ProtectX+Image+1',
          'https://via.placeholder.com/800x400/00FFFF/000000?text=ProtectX+Image+2',
        ],
      ),
      const Project(
        title: 'Kahoot Answers',
        description: 'Get answers to your kahoot quiz',
        techStack: 'CSS, Express, Node.Js',
        githubUrl: 'https://github.com/user/kahoot-answers',
        images: [
          'https://via.placeholder.com/800x400/FF00FF/FFFFFF?text=Kahoot+Image+1',
          'https://via.placeholder.com/800x400/FFFFFF/000000?text=Kahoot+Image+2',
          'https://via.placeholder.com/800x400/000000/FFFFFF?text=Kahoot+Image+3',
        ],
      ),
    ]);
  }
}