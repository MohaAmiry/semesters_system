// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AddCourseNotifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allAvailableCoursesHash() =>
    r'2c19425d14df25f9ca28ea94aff0be36977608dd';

/// See also [allAvailableCourses].
@ProviderFor(allAvailableCourses)
final allAvailableCoursesProvider =
    AutoDisposeFutureProvider<List<Course>>.internal(
  allAvailableCourses,
  name: r'allAvailableCoursesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allAvailableCoursesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllAvailableCoursesRef = AutoDisposeFutureProviderRef<List<Course>>;
String _$addCourseNotifierHash() => r'9a5fd0ba4c8c8b8b1f4b4784febab6e886f63b33';

/// See also [AddCourseNotifier].
@ProviderFor(AddCourseNotifier)
final addCourseNotifierProvider =
    AutoDisposeNotifierProvider<AddCourseNotifier, Course>.internal(
  AddCourseNotifier.new,
  name: r'addCourseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addCourseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AddCourseNotifier = AutoDisposeNotifier<Course>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
