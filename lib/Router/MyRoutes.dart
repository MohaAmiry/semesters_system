import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'MyRoutes.gr.dart';

part 'MyRoutes.g.dart';

@AutoRouterConfig(replaceInRouteName: "View,Route")
class MyRoutes extends $MyRoutes {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterNewStudentRoute.page),
        AutoRoute(page: AddSemesterRoute.page),
        AutoRoute(page: AddCourseRoute.page),
        AutoRoute(page: StudentCurrentSemesterRoute.page),
        AutoRoute(page: AllCoursesRoute.page),
        AutoRoute(page: AllSemestersRoute.page),
        AutoRoute(page: SemesterCoursesRoute.page),
        AutoRoute(page: SemesterStudentCoursesRoute.page),
        AutoRoute(page: SemesterStudentsRoute.page),
        AutoRoute(page: StudentSemesterRegisterRoute.page),
        AutoRoute(page: StudentSuccessCoursesRoute.page)
      ];
}

class MyObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: ${route.settings.name}');
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('Tab route visited: ${route.name}');
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('Tab route re-visited: ${route.name}');
  }
}

@riverpod
RouterConfig<UrlState> myRoutes(MyRoutesRef ref) {
  return MyRoutes().config(
    navigatorObservers: () => [MyObserver()],
  );
}
