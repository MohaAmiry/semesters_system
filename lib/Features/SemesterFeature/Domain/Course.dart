import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../Presentation/AddSemester/Enitities/AddSemesterCourseEntity.dart';

part 'Course.mapper.dart';

@MappableClass()
class CourseDTO with CourseDTOMappable {
  final String courseId;
  final String courseNumber;
  final String courseName;
  final IList<String> preRequisitesIds;
  final int hours;

  const CourseDTO(
      {required this.courseId,
      required this.courseNumber,
      required this.courseName,
      required this.preRequisitesIds,
      required this.hours});

  factory CourseDTO.empty() => CourseDTO(
      courseId: "",
      courseNumber: "",
      courseName: "",
      preRequisitesIds: IList(),
      hours: 0);

  static const fromMap = CourseDTOMapper.fromMap;

  static String get firebaseCourseId => "courseId";

  String get overViewString => "$courseNumber, $courseName";

  Course toCourse(List<CourseDTO> prerequisites) => Course(
      courseId: courseId,
      courseNumber: courseNumber,
      courseName: courseName,
      preRequisites: prerequisites.toIList(),
      hours: hours);
}

@MappableClass()
class Course with CourseMappable {
  final String courseId;
  final String courseNumber;
  final String courseName;
  final IList<CourseDTO> preRequisites;
  final int hours;

  const Course(
      {required this.courseId,
      required this.courseNumber,
      required this.courseName,
      required this.preRequisites,
      required this.hours});

  factory Course.empty() => Course(
      courseId: "",
      courseNumber: "",
      courseName: "",
      preRequisites: IList(),
      hours: 0);

  CourseDTO toCourseDTO() => CourseDTO(
      courseId: courseId,
      courseNumber: courseNumber,
      courseName: courseName,
      preRequisitesIds:
          preRequisites.map((element) => element.courseId).toIList(),
      hours: hours);

  AddSemesterCourseEntity toAddSemesterCourseEntity() =>
      AddSemesterCourseEntity(
          course: toCourseDTO(),
          theoryTime: IList(),
          practicalTime: IList(),
          capacity: 0,
          studentsNumber: 0);

  static const fromMap = CourseMapper.fromMap;

  static String get firebaseCourseId => "courseId";

  String get overViewString => "$courseNumber, $courseName";
}
