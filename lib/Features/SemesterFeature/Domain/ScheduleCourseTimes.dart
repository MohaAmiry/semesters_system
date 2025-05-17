import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterCourse.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Time.dart';

import 'Course.dart';

part 'ScheduleCourseTimes.mapper.dart';

@MappableClass()
class ScheduleCourseTime with ScheduleCourseTimeMappable {
  final Course course;
  final bool isPractical;
  final CourseTime time;

  const ScheduleCourseTime(
      {required this.course, required this.time, required this.isPractical});

  static IList<ScheduleCourseTime> getTimesFromAllCourse(
          IList<SemesterCourse> courses) =>
      courses.fold(
        IList(),
        (previousCourse, course) => previousCourse.addAll(course.theoryTime
            .map((element) => ScheduleCourseTime(
                isPractical: false, time: element, course: course.course))
            .toIList()
            .addAll(course.practicalTime.map((element) => ScheduleCourseTime(
                isPractical: true, time: element, course: course.course)))),
      );

  @override
  String toString() {
    return "${course.courseName}, ${time.toString()}, ${isPractical ? "عملي" : "نظري"}";
  }
}
