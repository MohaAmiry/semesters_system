import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Semester.dart';

import 'AddSemesterCourseEntity.dart';

part 'AddSemesterEntity.mapper.dart';

@MappableClass()
class AddSemesterEntity with AddSemesterEntityMappable {
  final String semesterId;
  final int semesterNumber;
  final IList<String> studentsIds;
  final IList<AddSemesterCourseEntity> courses;
  final bool isSummerSemester;

  const AddSemesterEntity(
      {required this.semesterId,
      required this.semesterNumber,
      required this.studentsIds,
      required this.courses,
      required this.isSummerSemester});

  factory AddSemesterEntity.empty() => AddSemesterEntity(
      semesterId: "",
      isSummerSemester: false,
      semesterNumber: 0,
      studentsIds: IList(),
      courses: IList());

  SemesterDTO toSemesterDTO() => SemesterDTO(
      semesterId: semesterId,
      isSummerSemester: isSummerSemester,
      semesterNumber: semesterNumber,
      students: IList(),
      courses: courses.map((element) => element.toSemesterCourse()).toIList());

  static const fromMap = AddSemesterEntityMapper.fromMap;

  static String get firebaseSemesterId => "semesterId";

  static String get firebaseSemesterNumber => "semesterNumber";
}
