import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/Features/AuthenticationFeature/Data/AuthController.dart';
import 'package:semester_system/Features/AuthenticationFeature/Domain/User/UserRole.dart';
import 'package:semester_system/Features/_Shared/AbstractDataRepository.dart';

import '../../../Domain/Course.dart';
import '../../../Domain/SemesterStudent.dart';

part 'StudentCurrentSemesterNotifier.g.dart';

@riverpod
Future<List<Course>> studentSuccessCourses(StudentSuccessCoursesRef ref) async {
  return ref
      .watch(repositoryClientProvider)
      .coursesRepository
      .getStudentFinishedCourses(
          ref.read(authControllerProvider).requireValue!.user!.uid);
}

@riverpod
Stream<SemesterStudent> studentCurrentSemester(StudentCurrentSemesterRef ref) {
  final user = (ref.watch(authControllerProvider).requireValue as Student);
  return ref
      .read(repositoryClientProvider)
      .semestersRepository
      .getStudentCurrentSemester(user.currentSemester, user.user!.uid);
}
