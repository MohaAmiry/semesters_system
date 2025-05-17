import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../Domain/Course.dart';
import '../../../Domain/Time.dart';

class SelectedCourseEntity {
  CourseDTO? course;
  IList<CourseTime> theoryTime;
  IList<CourseTime> practicalTime;

  SelectedCourseEntity(this.course, this.theoryTime, this.practicalTime);
}
