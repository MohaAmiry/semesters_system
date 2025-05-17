import 'package:dart_mappable/dart_mappable.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterCourse.dart';

part 'SemesterStudentCourse.mapper.dart';

@MappableClass()
class SemesterStudentCourseDTO with SemesterStudentCourseDTOMappable {
  final String course;
  final bool? didPass;

  const SemesterStudentCourseDTO({required this.course, this.didPass});

  static const fromMap = SemesterStudentCourseDTOMapper.fromMap;
}

@MappableClass()
class SemesterStudentCourse with SemesterStudentCourseMappable {
  final SemesterCourse course;
  final bool? didPass;

  const SemesterStudentCourse({required this.course, this.didPass});
}
