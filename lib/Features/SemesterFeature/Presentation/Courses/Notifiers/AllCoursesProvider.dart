import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/Features/_Shared/AbstractDataRepository.dart';

import '../../../Domain/Course.dart';

part 'AllCoursesProvider.g.dart';

@riverpod
Stream<List<Course>> allCourses(AllCoursesRef ref) {
  return ref
      .read(repositoryClientProvider)
      .coursesRepository
      .getAllCoursesStream();
}
