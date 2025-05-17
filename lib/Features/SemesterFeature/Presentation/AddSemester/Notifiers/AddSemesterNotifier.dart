import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/ExceptionHandler/MessageEmitter.dart';
import 'package:semester_system/Features/_Shared/AbstractDataRepository.dart';
import 'package:semester_system/utils/Extensions.dart';

import '../Enitities/AddSemesterCourseEntity.dart';
import '../Enitities/AddSemesterEntity.dart';

part 'AddSemesterNotifier.g.dart';

@riverpod
class AddSemesterNotifier extends _$AddSemesterNotifier {
  @override
  AddSemesterEntity build() {
    return AddSemesterEntity.empty();
  }

  void removeCourse(AddSemesterCourseEntity course) {
    state = state.copyWith(courses: state.courses.remove(course));
  }

  void setSemesterType(bool isSummerSemester) =>
      state = state.copyWith(isSummerSemester: isSummerSemester);

  void addCourse(AddSemesterCourseEntity? semesterCourse) {
    if (semesterCourse == null) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("لم يتم تحديد المادة بعد"));
      return;
    }
    if (semesterCourse.theoryTime.isEmpty) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("لا يمكن إضافة مادة بلا محاضرات نظري"));
      return;
    }
    if (semesterCourse.capacity < 1) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("لا يمكن أن تكون السعة اقل من 1"));

      return;
    }
    if (state.courses.any((element) =>
        element.course!.courseId == semesterCourse.course!.courseId)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("لا يمكن إضافة المادة أكثر من مرة"));
      return;
    }
    state = state.copyWith(courses: state.courses.add(semesterCourse));
  }

  Future<bool> addSemester() async {
    if (state.courses.isEmpty) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("لا يمكن إضافة فصل بلا مواد"));
      return false;
    }
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .semestersRepository
            .addNewSemester(state.toSemesterDTO()));
    return result.hasValue;
  }
}
