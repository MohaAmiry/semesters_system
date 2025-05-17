import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/Features/_Shared/AbstractDataRepository.dart';

import '../../../Domain/Semester.dart';

part 'AllSemestersProvider.g.dart';

@riverpod
Stream<IList<Semester>> allSemesters(AllSemestersRef ref) {
  return ref
      .watch(repositoryClientProvider)
      .semestersRepository
      .getAllSemesters();
}

@riverpod
Stream<Semester> semester(SemesterRef ref, String id) {
  return ref
      .watch(repositoryClientProvider)
      .semestersRepository
      .getSemesterById(id);
}
