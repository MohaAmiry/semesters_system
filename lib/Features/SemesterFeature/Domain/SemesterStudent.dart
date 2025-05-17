import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:semester_system/Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudentCourse.dart';

part 'SemesterStudent.mapper.dart';

@MappableClass()
class SemesterStudent with SemesterStudentMappable {
  final String studentId;
  final String studentName;
  final String universityId;
  final String semesterId;
  final IList<SemesterStudentCourse> selectedCourses;

  const SemesterStudent({
    required this.studentId,
    required this.studentName,
    required this.universityId,
    required this.semesterId,
    required this.selectedCourses,
  });
}

@MappableClass()
class SemesterStudentDTO with SemesterStudentDTOMappable {
  final String studentId;
  final String semesterId;
  final IList<SemesterStudentCourseDTO> selectedCourses;

  const SemesterStudentDTO(
      {required this.studentId,
      required this.semesterId,
      required this.selectedCourses});

  SemesterStudent toStudentSemester(
          UserResponseDTO user, List<SemesterStudentCourse> courses) =>
      SemesterStudent(
          studentId: studentId,
          studentName: user.name,
          universityId: user.universityId!,
          semesterId: semesterId,
          selectedCourses: courses.toIList());
}
