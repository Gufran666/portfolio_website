import 'package:get/get.dart';
import 'package:portfolio_website/modules/projects/screens/project_detail_screen.dart';
import 'package:portfolio_website/routes/app.dart';

class AppRoutes {
  static const String home = '/';
  static const String projectDetail = '/project-detail';

  static final routes = [
    GetPage(
      name: home,
      page: () => const PortfolioScreen(),
    ),
    GetPage(
      name: projectDetail,
      page: () => const ProjectDetailScreen(),
    ),
  ];
}
