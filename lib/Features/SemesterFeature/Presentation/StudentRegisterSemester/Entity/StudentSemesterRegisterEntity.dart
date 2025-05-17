import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudent.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudentCourse.dart';

import '../../../Domain/SemesterCourse.dart';

part 'StudentSemesterRegisterEntity.mapper.dart';

@MappableClass()
class StudentSemesterRegisterEntity with StudentSemesterRegisterEntityMappable {
  final IList<SemesterCourse> remainingCourses;
  final String semesterId;
  final IList<SemesterCourse> selectedCourse;
  final bool isSummerSemester;

  const StudentSemesterRegisterEntity(
      {required this.selectedCourse,
      required this.remainingCourses,
      required this.isSummerSemester,
      required this.semesterId});

  bool get isOverTheLimit =>
      selectedCourse.fold(
        0,
        (previousValue, element) => previousValue + element.course.hours,
      ) >
      hoursLimit;

  int get hoursLimit => (isSummerSemester ? 12 : 18);

  int get currentRegisteredHours => selectedCourse.fold(
      0, (previousValue, element) => previousValue + element.course.hours);

  SemesterStudentDTO toSemesterStudentDTO(
    String studentId,
  ) =>
      SemesterStudentDTO(
          studentId: studentId,
          semesterId: semesterId,
          selectedCourses: selectedCourse
              .map((e) => SemesterStudentCourseDTO(course: e.course.courseId))
              .toIList());
}
