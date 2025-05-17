import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/ExceptionHandler/MessageEmitter.dart';
import 'package:semester_system/Features/AuthenticationFeature/Data/AuthController.dart';
import 'package:semester_system/Features/AuthenticationFeature/Domain/User/UserRole.dart';
import 'package:semester_system/Features/_Shared/AbstractDataRepository.dart';
import 'package:semester_system/utils/Extensions.dart';
import 'package:semester_system/utils/Resouces/ColorManager.dart';

import '../../../Domain/SemesterCourse.dart';
import '../Entity/StudentSemesterRegisterEntity.dart';

part 'StudentSemesterRegisterNotifiers.g.dart';

@riverpod
Future<bool> canStudentRegisterNextSemester(
    CanStudentRegisterNextSemesterRef ref) async {
  var result = ref
      .read(repositoryClientProvider)
      .semestersRepository
      .canStudentRegisterForNextSemester(
          ref.read(authControllerProvider).requireValue!.user!.uid);
  return await result;
}

@riverpod
class StudentSemesterRegisterNotifier
    extends _$StudentSemesterRegisterNotifier {
  @override
  FutureOr<StudentSemesterRegisterEntity> build() async {
    var canRegister =
        await ref.read(canStudentRegisterNextSemesterProvider.future);

    if (!canRegister) {
      throw Exception("لا يمكن التسجيل بالفصل بعد لسبب ما");
    }
    var nextSemester = ref
        .read(repositoryClientProvider)
        .semestersRepository
        .getStudentNextSemesterByStudentId(
            ref.read(authControllerProvider).requireValue!.user!.uid);

    var remainingCourses = ref
        .read(repositoryClientProvider)
        .semestersRepository
        .getStudentRemainingCoursesForNextSemesterBySemester(await nextSemester,
            ref.read(authControllerProvider).requireValue!.user!.uid);

    return StudentSemesterRegisterEntity(
        selectedCourse: IList(),
        remainingCourses: await remainingCourses,
        isSummerSemester: (await nextSemester).isSummerSemester,
        semesterId: (await nextSemester).semesterId);
  }

  void addCourse(SemesterCourse course) {
    if (!canInsertCourse(course)) {
      return;
    }
    state = AsyncData(state.requireValue.copyWith(
        selectedCourse: state.requireValue.selectedCourse.add(course)));
  }

  void removeCourse(SemesterCourse course) {
    state = AsyncData(state.requireValue.copyWith(
        selectedCourse: state.requireValue.selectedCourse.remove(course)));
  }

  bool canInsertCourse(SemesterCourse course) {
    if (state.requireValue.currentRegisteredHours + course.course.hours >
        state.requireValue.hoursLimit) {
      ref.read(messageEmitterProvider.notifier).setFailed(
          message: Exception(
              "لا يمكن إضافة المادة لان عدد الساعات المختارة سيزيد عن الحد الأعلى"));
      return false;
    }
    if (state.requireValue.selectedCourse.contains(course)) {
      ref
          .read(messageEmitterProvider.notifier)
          .setFailed(message: Exception("لا يمكن إضافة مادة موجودة"));
      return false;
    }
    if (doesIntersectWithAny(course)) {
      return false;
    }
    final finishedCourses =
        (ref.read(authControllerProvider).requireValue as Student)
            .finishedCourses;
    var result = course.course.preRequisites.every((element) {
      var result = finishedCourses.contains(element.courseId);
      if (!result) {
        ref.read(messageEmitterProvider.notifier).setFailed(
            message: Exception(
                "لا يمكن إضافة ${course.course.courseName} بسبب عدم تحقيق المتطلب السابق: ${element.overViewString}"));
        return false;
      }
      return true;
    });

    return result;
  }

  bool doesIntersectWithAny(SemesterCourse courseToAdd) {
    for (var course in state.requireValue.selectedCourse) {
      var result = course.doesIntersectWith(courseToAdd);
      if (result.$1) {
        ref.read(messageEmitterProvider.notifier).setFailed(
            message: Exception(
                "لا يمكن إضافة المادة ${courseToAdd.course.courseName} بسبب تعارض الأوقات مع ${course.course.courseName}، وقت التعارض هو: ${result.$2.toString()}"));
        return true;
      }
    }
    return false;
  }

  Color? getColor(SemesterCourse course) {
    final finishedCourses =
        (ref.read(authControllerProvider).requireValue as Student)
            .finishedCourses;
    var hasFinishedAll = course.course.preRequisites.every((element) {
      var result = finishedCourses.contains(element.courseId);
      if (!result) {
        return false;
      }
      return true;
    });
    if (!hasFinishedAll) {
      return ColorManager.onSurfaceVariant1LightRedPink;
    }
    return null;
  }

  Future<bool> registerSemester() async {
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .semestersRepository
            .registerNewStudentInSemester(state.requireValue
                .toSemesterStudentDTO(
                    ref.read(authControllerProvider).requireValue!.user!.uid)));

    if (result.hasValue) {
      return true;
    }
    return false;
  }
}
