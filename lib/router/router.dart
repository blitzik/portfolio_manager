import 'package:auto_route/auto_route.dart';
import 'package:portfolio_manager/screens/homepage/home_page.dart';
import 'package:portfolio_manager/screens/project/project_page.dart';
import 'package:portfolio_manager/screens/project_detail/project_detail_page.dart';
import 'package:portfolio_manager/screens/transaction/transaction_page.dart';

@CustomAutoRouter(
    replaceInRouteName: 'Page,Route',
    transitionsBuilder: TransitionsBuilders.fadeIn,
    reverseDurationInMilliseconds: 100,
    durationInMilliseconds: 100,
    routes: <AutoRoute> [
      AutoRoute(page: HomePage, initial: true),
      AutoRoute(page: ProjectPage),
      AutoRoute(page: ProjectDetailPage),
      AutoRoute(page: TransactionPage),
    ]
)
class $Router {}