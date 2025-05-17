// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:fast_immutable_collections/fast_immutable_collections.dart'
    as _i16;
import 'package:flutter/material.dart' as _i15;
import 'package:semester_system/Features/_Shared/UtilsViews/SplashView.dart'
    as _i10;
import 'package:semester_system/Features/AuthenticationFeature/Presentation/LoginView.dart'
    as _i5;
import 'package:semester_system/Features/AuthenticationFeature/Presentation/RegisterNewStudentView.dart'
    as _i6;
import 'package:semester_system/Features/SemesterFeature/Domain/Semester.dart'
    as _i19;
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterCourse.dart'
    as _i17;
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudent.dart'
    as _i18;
import 'package:semester_system/Features/SemesterFeature/Presentation/AddSemester/AddSemesterView.dart'
    as _i2;
import 'package:semester_system/Features/SemesterFeature/Presentation/Courses/AddCourseView.dart'
    as _i1;
import 'package:semester_system/Features/SemesterFeature/Presentation/Courses/AllCoursesView.dart'
    as _i3;
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/AdminViews/AllSemestersView.dart'
    as _i4;
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/AdminViews/SemesterCoursesView.dart'
    as _i7;
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/AdminViews/SemesterStudentCoursesView.dart'
    as _i8;
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/AdminViews/SemesterStudentsView.dart'
    as _i9;
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/StudentViews/StudentCurrentSemesterView.dart'
    as _i11;
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/StudentViews/StudentSuccessCoursesView.dart'
    as _i13;
import 'package:semester_system/Features/SemesterFeature/Presentation/StudentRegisterSemester/StudentSemesterRegisterView.dart'
    as _i12;

abstract class $MyRoutes extends _i14.RootStackRouter {
  $MyRoutes({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    AddCourseRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddCourseView(),
      );
    },
    AddSemesterRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.AddSemesterView(),
      );
    },
    AllCoursesRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.AllCoursesView(),
      );
    },
    AllSemestersRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.AllSemestersView(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginView(),
      );
    },
    RegisterNewStudentRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterNewStudentView(),
      );
    },
    SemesterCoursesRoute.name: (routeData) {
      final args = routeData.argsAs<SemesterCoursesRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SemesterCoursesView(
          key: args.key,
          courses: args.courses,
        ),
      );
    },
    SemesterStudentCoursesRoute.name: (routeData) {
      final args = routeData.argsAs<SemesterStudentCoursesRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SemesterStudentCoursesView(
          key: args.key,
          studentIndex: args.studentIndex,
          students: args.students,
        ),
      );
    },
    SemesterStudentsRoute.name: (routeData) {
      final args = routeData.argsAs<SemesterStudentsRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.SemesterStudentsView(
          key: args.key,
          semester: args.semester,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SplashView(),
      );
    },
    StudentCurrentSemesterRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.StudentCurrentSemesterView(),
      );
    },
    StudentSemesterRegisterRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.StudentSemesterRegisterView(),
      );
    },
    StudentSuccessCoursesRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.StudentSuccessCoursesView(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddCourseView]
class AddCourseRoute extends _i14.PageRouteInfo<void> {
  const AddCourseRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AddCourseRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddCourseRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i2.AddSemesterView]
class AddSemesterRoute extends _i14.PageRouteInfo<void> {
  const AddSemesterRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AddSemesterRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddSemesterRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i3.AllCoursesView]
class AllCoursesRoute extends _i14.PageRouteInfo<void> {
  const AllCoursesRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AllCoursesRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllCoursesRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i4.AllSemestersView]
class AllSemestersRoute extends _i14.PageRouteInfo<void> {
  const AllSemestersRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AllSemestersRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllSemestersRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginView]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterNewStudentView]
class RegisterNewStudentRoute extends _i14.PageRouteInfo<void> {
  const RegisterNewStudentRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RegisterNewStudentRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterNewStudentRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SemesterCoursesView]
class SemesterCoursesRoute
    extends _i14.PageRouteInfo<SemesterCoursesRouteArgs> {
  SemesterCoursesRoute({
    _i15.Key? key,
    required _i16.IList<_i17.SemesterCourse> courses,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SemesterCoursesRoute.name,
          args: SemesterCoursesRouteArgs(
            key: key,
            courses: courses,
          ),
          initialChildren: children,
        );

  static const String name = 'SemesterCoursesRoute';

  static const _i14.PageInfo<SemesterCoursesRouteArgs> page =
      _i14.PageInfo<SemesterCoursesRouteArgs>(name);
}

class SemesterCoursesRouteArgs {
  const SemesterCoursesRouteArgs({
    this.key,
    required this.courses,
  });

  final _i15.Key? key;

  final _i16.IList<_i17.SemesterCourse> courses;

  @override
  String toString() {
    return 'SemesterCoursesRouteArgs{key: $key, courses: $courses}';
  }
}

/// generated route for
/// [_i8.SemesterStudentCoursesView]
class SemesterStudentCoursesRoute
    extends _i14.PageRouteInfo<SemesterStudentCoursesRouteArgs> {
  SemesterStudentCoursesRoute({
    _i15.Key? key,
    required int studentIndex,
    required _i16.IList<_i18.SemesterStudent> students,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SemesterStudentCoursesRoute.name,
          args: SemesterStudentCoursesRouteArgs(
            key: key,
            studentIndex: studentIndex,
            students: students,
          ),
          initialChildren: children,
        );

  static const String name = 'SemesterStudentCoursesRoute';

  static const _i14.PageInfo<SemesterStudentCoursesRouteArgs> page =
      _i14.PageInfo<SemesterStudentCoursesRouteArgs>(name);
}

class SemesterStudentCoursesRouteArgs {
  const SemesterStudentCoursesRouteArgs({
    this.key,
    required this.studentIndex,
    required this.students,
  });

  final _i15.Key? key;

  final int studentIndex;

  final _i16.IList<_i18.SemesterStudent> students;

  @override
  String toString() {
    return 'SemesterStudentCoursesRouteArgs{key: $key, studentIndex: $studentIndex, students: $students}';
  }
}

/// generated route for
/// [_i9.SemesterStudentsView]
class SemesterStudentsRoute
    extends _i14.PageRouteInfo<SemesterStudentsRouteArgs> {
  SemesterStudentsRoute({
    _i15.Key? key,
    required _i19.Semester semester,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SemesterStudentsRoute.name,
          args: SemesterStudentsRouteArgs(
            key: key,
            semester: semester,
          ),
          initialChildren: children,
        );

  static const String name = 'SemesterStudentsRoute';

  static const _i14.PageInfo<SemesterStudentsRouteArgs> page =
      _i14.PageInfo<SemesterStudentsRouteArgs>(name);
}

class SemesterStudentsRouteArgs {
  const SemesterStudentsRouteArgs({
    this.key,
    required this.semester,
  });

  final _i15.Key? key;

  final _i19.Semester semester;

  @override
  String toString() {
    return 'SemesterStudentsRouteArgs{key: $key, semester: $semester}';
  }
}

/// generated route for
/// [_i10.SplashView]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i11.StudentCurrentSemesterView]
class StudentCurrentSemesterRoute extends _i14.PageRouteInfo<void> {
  const StudentCurrentSemesterRoute({List<_i14.PageRouteInfo>? children})
      : super(
          StudentCurrentSemesterRoute.name,
          initialChildren: children,
        );

  static const String name = 'StudentCurrentSemesterRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i12.StudentSemesterRegisterView]
class StudentSemesterRegisterRoute extends _i14.PageRouteInfo<void> {
  const StudentSemesterRegisterRoute({List<_i14.PageRouteInfo>? children})
      : super(
          StudentSemesterRegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'StudentSemesterRegisterRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i13.StudentSuccessCoursesView]
class StudentSuccessCoursesRoute extends _i14.PageRouteInfo<void> {
  const StudentSuccessCoursesRoute({List<_i14.PageRouteInfo>? children})
      : super(
          StudentSuccessCoursesRoute.name,
          initialChildren: children,
        );

  static const String name = 'StudentSuccessCoursesRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}
