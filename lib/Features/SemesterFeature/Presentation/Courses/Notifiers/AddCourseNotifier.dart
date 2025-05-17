import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/ExceptionHandler/MessageEmitter.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Course.dart';
import 'package:semester_system/Features/_Shared/AbstractDataRepository.dart';
import 'package:semester_system/utils/Extensions.dart';
import 'package:semester_system/utils/SharedOperations.dart';

part 'AddCourseNotifier.g.dart';

@riverpod
Future<List<Course>> allAvailableCourses(AllAvailableCoursesRef ref) async {
  return ref.read(repositoryClientProvider).coursesRepository.getAllCourses();
}

@riverpod
class AddCourseNotifier extends _$AddCourseNotifier with SharedUserOperations {
  @override
  Course build() {
    return Course.empty();
  }

  void setName(String name) {
    state = state.copyWith(courseName: name);
  }

  void setNumber(String number) {
    state = state.copyWith(courseNumber: number);
  }

  void addPrerequisite(Course course) {
    if (state.preRequisites.contains(course.toCourseDTO())) return;
    state = state.copyWith(
        preRequisites: state.preRequisites.add(course.toCourseDTO()));
  }

  void removePrerequisite(int index) {
    state = state.copyWith(preRequisites: state.preRequisites.removeAt(index));
  }

  void setHours(String hours) {
    hours.isEmpty
        ? state = state.copyWith(hours: 0)
        : state = state.copyWith(hours: int.parse(hours));
  }

  Future<bool> addCourse() async {
    if (!validate()) {
      return false;
    }
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .coursesRepository
            .addCourse(state.toCourseDTO()));
    if (result.hasValue) return true;
    return false;
  }

  bool validate() {
    if (state.courseName.isEmpty) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("اسم المادة فارغ!"));
      return false;
    }
    if (state.courseNumber.isEmpty) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("رقم المادة فارغ"));
      return false;
    }
    if (state.hours < 1) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("عدد ساعات خاطئ"));
      return false;
    }
    return true;
  }
}
