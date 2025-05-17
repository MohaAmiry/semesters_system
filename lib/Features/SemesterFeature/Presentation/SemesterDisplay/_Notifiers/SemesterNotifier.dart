import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudent.dart';
import 'package:semester_system/utils/Extensions.dart';

import '../../../../_Shared/AbstractDataRepository.dart';

part 'SemesterNotifier.g.dart';

@riverpod
class SemesterNotifier extends _$SemesterNotifier {
  @override
  IList<SemesterStudent> build({required IList<SemesterStudent> students}) {
    return students;
  }

  Future<void> changeCourseStatusForStudent(
      {required String studentId,
      required String semesterId,
      required String courseId,
      required bool didPass}) async {
    var result = await ref.operationPipeLine(
        func: () => ref
            .read(repositoryClientProvider)
            .semestersRepository
            .setSemesterCourseStatusForStudent(
                semesterId, studentId, courseId, didPass));
    if (result.hasValue) {
      state = state.replaceFirstWhere(
          (student) => student.studentId == studentId,
          (student) => student!.copyWith(
              selectedCourses: student.selectedCourses.replaceFirstWhere(
                  (course) => course.course.course.courseId == courseId,
                  (course) => course!.copyWith(didPass: didPass))));
    }
  }
}
