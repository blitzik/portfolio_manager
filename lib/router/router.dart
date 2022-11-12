import 'package:auto_route/auto_route.dart';
import 'package:portfolio_manager/screens/homepage/home_page.dart';

@CustomAutoRouter(
    replaceInRouteName: 'Page,Route',
    transitionsBuilder: TransitionsBuilders.slideLeft,
    durationInMilliseconds: 125,
    routes: <AutoRoute> [
      AutoRoute(page: HomePage, initial: true)
    ]
)
class $Router {}