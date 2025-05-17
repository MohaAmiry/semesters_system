// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SemesterNotifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$semesterNotifierHash() => r'09504f28dbe49703ce5c31c1653171bd626c81d1';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$SemesterNotifier
    extends BuildlessAutoDisposeNotifier<IList<SemesterStudent>> {
  late final IList<SemesterStudent> students;

  IList<SemesterStudent> build({
    required IList<SemesterStudent> students,
  });
}

/// See also [SemesterNotifier].
@ProviderFor(SemesterNotifier)
const semesterNotifierProvider = SemesterNotifierFamily();

/// See also [SemesterNotifier].
class SemesterNotifierFamily extends Family<IList<SemesterStudent>> {
  /// See also [SemesterNotifier].
  const SemesterNotifierFamily();

  /// See also [SemesterNotifier].
  SemesterNotifierProvider call({
    required IList<SemesterStudent> students,
  }) {
    return SemesterNotifierProvider(
      students: students,
    );
  }

  @override
  SemesterNotifierProvider getProviderOverride(
    covariant SemesterNotifierProvider provider,
  ) {
    return call(
      students: provider.students,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'semesterNotifierProvider';
}

/// See also [SemesterNotifier].
class SemesterNotifierProvider extends AutoDisposeNotifierProviderImpl<
    SemesterNotifier, IList<SemesterStudent>> {
  /// See also [SemesterNotifier].
  SemesterNotifierProvider({
    required IList<SemesterStudent> students,
  }) : this._internal(
          () => SemesterNotifier()..students = students,
          from: semesterNotifierProvider,
          name: r'semesterNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$semesterNotifierHash,
          dependencies: SemesterNotifierFamily._dependencies,
          allTransitiveDependencies:
              SemesterNotifierFamily._allTransitiveDependencies,
          students: students,
        );

  SemesterNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.students,
  }) : super.internal();

  final IList<SemesterStudent> students;

  @override
  IList<SemesterStudent> runNotifierBuild(
    covariant SemesterNotifier notifier,
  ) {
    return notifier.build(
      students: students,
    );
  }

  @override
  Override overrideWith(SemesterNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: SemesterNotifierProvider._internal(
        () => create()..students = students,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        students: students,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SemesterNotifier, IList<SemesterStudent>>
      createElement() {
    return _SemesterNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SemesterNotifierProvider && other.students == students;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, students.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SemesterNotifierRef
    on AutoDisposeNotifierProviderRef<IList<SemesterStudent>> {
  /// The parameter `students` of this provider.
  IList<SemesterStudent> get students;
}

class _SemesterNotifierProviderElement
    extends AutoDisposeNotifierProviderElement<SemesterNotifier,
        IList<SemesterStudent>> with SemesterNotifierRef {
  _SemesterNotifierProviderElement(super.provider);

  @override
  IList<SemesterStudent> get students =>
      (origin as SemesterNotifierProvider).students;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
