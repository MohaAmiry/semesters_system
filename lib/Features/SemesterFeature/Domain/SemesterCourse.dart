import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Course.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Time.dart';

part 'SemesterCourse.mapper.dart';

@MappableClass()
class SemesterCourse with SemesterCourseMappable {
  final Course course;
  final IList<CourseTime> theoryTime;
  final IList<CourseTime> practicalTime;
  final int capacity;
  final int studentsNumber;

  const SemesterCourse(
      {required this.course,
      required this.theoryTime,
      required this.practicalTime,
      required this.capacity,
      required this.studentsNumber});

  factory SemesterCourse.empty() => SemesterCourse(
      course: Course.empty(),
      theoryTime: IList(),
      practicalTime: IList(),
      capacity: -1,
      studentsNumber: -1);

  (bool, CourseTime?) doesIntersectWith(SemesterCourse course) {
    var allTimes = practicalTime.addAll(theoryTime);
    var otherAllTimes = course.practicalTime.addAll(course.theoryTime);
    for (var time in allTimes) {
      for (var otherTime in otherAllTimes) {
        var doesIntersect = time.doesIntersectWith(otherTime);
        if (doesIntersect) {
          return (true, time);
        }
      }
    }
    return (false, null);
  }
}

@MappableClass()
class SemesterCourseDTO with SemesterCourseDTOMappable {
  final String courseId;
  final IList<CourseTime> theoryTime;
  final IList<CourseTime> practicalTime;
  final int capacity;
  final int studentsNumber;

  const SemesterCourseDTO(
      {required this.courseId,
      required this.theoryTime,
      required this.practicalTime,
      required this.capacity,
      required this.studentsNumber});

  factory SemesterCourseDTO.empty() => SemesterCourseDTO(
      courseId: "",
      theoryTime: IList(),
      practicalTime: IList(),
      capacity: -1,
      studentsNumber: -1);

  SemesterCourse toSemesterCourse(Course course) => SemesterCourse(
      course: course,
      theoryTime: theoryTime,
      practicalTime: practicalTime,
      capacity: capacity,
      studentsNumber: studentsNumber);
}
