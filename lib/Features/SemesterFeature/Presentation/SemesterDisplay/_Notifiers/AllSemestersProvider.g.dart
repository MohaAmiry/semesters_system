// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllSemestersProvider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allSemestersHash() => r'af155e8ac8097e696419c8d66fb61fcfac9b1bc3';

/// See also [allSemesters].
@ProviderFor(allSemesters)
final allSemestersProvider =
    AutoDisposeStreamProvider<IList<Semester>>.internal(
  allSemesters,
  name: r'allSemestersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allSemestersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllSemestersRef = AutoDisposeStreamProviderRef<IList<Semester>>;
String _$semesterHash() => r'77cbf91a1891953320dcd1c0386322f9252081aa';

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

/// See also [semester].
@ProviderFor(semester)
const semesterProvider = SemesterFamily();

/// See also [semester].
class SemesterFamily extends Family<AsyncValue<Semester>> {
  /// See also [semester].
  const SemesterFamily();

  /// See also [semester].
  SemesterProvider call(
    String id,
  ) {
    return SemesterProvider(
      id,
    );
  }

  @override
  SemesterProvider getProviderOverride(
    covariant SemesterProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'semesterProvider';
}

/// See also [semester].
class SemesterProvider extends AutoDisposeStreamProvider<Semester> {
  /// See also [semester].
  SemesterProvider(
    String id,
  ) : this._internal(
          (ref) => semester(
            ref as SemesterRef,
            id,
          ),
          from: semesterProvider,
          name: r'semesterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$semesterHash,
          dependencies: SemesterFamily._dependencies,
          allTransitiveDependencies: SemesterFamily._allTransitiveDependencies,
          id: id,
        );

  SemesterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Semester> Function(SemesterRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SemesterProvider._internal(
        (ref) => create(ref as SemesterRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Semester> createElement() {
    return _SemesterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SemesterProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SemesterRef on AutoDisposeStreamProviderRef<Semester> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SemesterProviderElement
    extends AutoDisposeStreamProviderElement<Semester> with SemesterRef {
  _SemesterProviderElement(super.provider);

  @override
  String get id => (origin as SemesterProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
