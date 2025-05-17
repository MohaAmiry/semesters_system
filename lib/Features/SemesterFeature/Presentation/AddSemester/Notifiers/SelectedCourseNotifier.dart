import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Time.dart';

import '../../../../../ExceptionHandler/MessageEmitter.dart';
import '../../../Domain/Course.dart';
import '../Enitities/AddSemesterCourseEntity.dart';

part 'SelectedCourseNotifier.g.dart';

@riverpod
class SelectedCourseNotifier extends _$SelectedCourseNotifier {
  @override
  AddSemesterCourseEntity build() {
    return AddSemesterCourseEntity.empty();
  }

  void setCourse(CourseDTO course) {
    state = state.copyWith(course: course);
  }

  void setCapacity(String capacity) {
    state = state.copyWith(capacity: int.tryParse(capacity));
  }

  void addTime(CourseTime timeToAdd, bool isPractical) {
    bool isValidTime = Time.isStartBeforeEnd(timeToAdd.from, timeToAdd.to);
    if (!isValidTime) {
      ref.read(messageEmitterProvider.notifier).setFailed(
          message: Exception("لا يمكن أن يكون وقت النهاية قبل البداية"));
      return;
    }
    bool doesIntersectWithAny = checkForTimeIntersection(timeToAdd);

    if (doesIntersectWithAny) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("لا يمكن إضافة اوقات محاضرات متعارضة"));
      return;
    }

    if (isPractical) {
      state = state.copyWith(practicalTime: state.practicalTime.add(timeToAdd));
      return;
    }
    state = state.copyWith(theoryTime: state.theoryTime.add(timeToAdd));
  }

  void removeTime(CourseTime time, bool isPractical) {
    if (isPractical) {
      state = state.copyWith(practicalTime: state.practicalTime.remove(time));
      return;
    }
    state = state.copyWith(theoryTime: state.theoryTime.remove(time));
  }

  bool checkForTimeIntersection(CourseTime timeToAdd) {
    bool doesIntersectWithAnyTheory =
        state.theoryTime.any((element) => element.doesIntersectWith(timeToAdd));
    bool doesIntersectWithAnyPractical = state.practicalTime
        .any((element) => element.doesIntersectWith(timeToAdd));
    return doesIntersectWithAnyPractical || doesIntersectWithAnyTheory;
  }
}
