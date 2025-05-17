import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../Domain/Course.dart';
import '../../../Domain/SemesterCourse.dart';
import '../../../Domain/Time.dart';

part 'AddSemesterCourseEntity.mapper.dart';

@MappableClass()
class AddSemesterCourseEntity with AddSemesterCourseEntityMappable {
  final CourseDTO? course;
  final IList<CourseTime> theoryTime;
  final IList<CourseTime> practicalTime;
  final int capacity;
  final int studentsNumber;

  const AddSemesterCourseEntity(
      {required this.course,
      required this.theoryTime,
      required this.practicalTime,
      required this.capacity,
      required this.studentsNumber});

  factory AddSemesterCourseEntity.empty() => AddSemesterCourseEntity(
      course: null,
      theoryTime: IList(),
      practicalTime: IList(),
      capacity: 0,
      studentsNumber: 0);

  AddSemesterCourseEntity? toAddSemesterCourseEntity() {
    if (course == null) return null;
    return AddSemesterCourseEntity(
        course: course!,
        theoryTime: theoryTime,
        practicalTime: practicalTime,
        capacity: capacity,
        studentsNumber: studentsNumber);
  }

  SemesterCourseDTO toSemesterCourse() {
    return SemesterCourseDTO(
        courseId: course!.courseId,
        theoryTime: theoryTime,
        practicalTime: practicalTime,
        capacity: capacity,
        studentsNumber: studentsNumber);
  }
}
