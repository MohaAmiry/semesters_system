// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudentCurrentSemesterNotifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studentSuccessCoursesHash() =>
    r'b7ee48f9695165153fb52ff8a8a59af071692ae6';

/// See also [studentSuccessCourses].
@ProviderFor(studentSuccessCourses)
final studentSuccessCoursesProvider =
    AutoDisposeFutureProvider<List<Course>>.internal(
  studentSuccessCourses,
  name: r'studentSuccessCoursesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studentSuccessCoursesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StudentSuccessCoursesRef = AutoDisposeFutureProviderRef<List<Course>>;
String _$studentCurrentSemesterHash() =>
    r'0cad945ae80bd989b0face36b3286e4289ab1046';

/// See also [studentCurrentSemester].
@ProviderFor(studentCurrentSemester)
final studentCurrentSemesterProvider =
    AutoDisposeStreamProvider<SemesterStudent>.internal(
  studentCurrentSemester,
  name: r'studentCurrentSemesterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$studentCurrentSemesterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef StudentCurrentSemesterRef
    = AutoDisposeStreamProviderRef<SemesterStudent>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
