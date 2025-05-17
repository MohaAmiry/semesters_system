import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudent.dart';

import 'SemesterCourse.dart';

part 'Semester.mapper.dart';

@MappableClass()
class SemesterDTO with SemesterDTOMappable {
  final String semesterId;
  final int semesterNumber;
  final IList<SemesterStudentDTO> students;
  final IList<SemesterCourseDTO> courses;
  final bool isSummerSemester;

  const SemesterDTO(
      {required this.semesterId,
      required this.isSummerSemester,
      required this.semesterNumber,
      required this.students,
      required this.courses});

  factory SemesterDTO.empty() => SemesterDTO(
      semesterId: "",
      semesterNumber: 0,
      isSummerSemester: true,
      students: IList(),
      courses: IList());

  static const fromMap = SemesterDTOMapper.fromMap;

  static String get firebaseSemesterId => "semesterId";

  static String get firebaseSemesterNumber => "semesterNumber";
  static String get firebaseStudents => "students";
  static String get firebaseCourses => "courses";

  Semester toSemester(
          IList<SemesterCourse> courses, IList<SemesterStudent> students) =>
      Semester(
          semesterId: semesterId,
          isSummerSemester: isSummerSemester,
          semesterNumber: semesterNumber,
          students: students,
          courses: courses);
}

@MappableClass()
class Semester with SemesterMappable {
  final String semesterId;
  final int semesterNumber;
  final IList<SemesterStudent> students;
  final IList<SemesterCourse> courses;
  final bool isSummerSemester;

  const Semester(
      {required this.semesterId,
      required this.isSummerSemester,
      required this.semesterNumber,
      required this.students,
      required this.courses});

  factory Semester.empty() => Semester(
      semesterId: "",
      semesterNumber: 0,
      isSummerSemester: true,
      students: IList(),
      courses: IList());

  static const fromMap = SemesterMapper.fromMap;

  static String get firebaseSemesterId => "semesterId";

  static String get firebaseSemesterNumber => "semesterNumber";
}
