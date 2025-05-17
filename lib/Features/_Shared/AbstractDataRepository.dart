import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:semester_system/Features/SemesterFeature/Data/CoursesRepository.dart';
import 'package:semester_system/Features/SemesterFeature/Data/SemestersRepository.dart';

import '../AuthenticationFeature/Data/AuthRepository.dart';

part 'AbstractDataRepository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(ref);
}

@Riverpod(keepAlive: true)
CoursesRepository coursesRepository(CoursesRepositoryRef ref) {
  return CoursesRepository(ref);
}

@Riverpod(keepAlive: true)
SemestersRepository semestersRepository(SemestersRepositoryRef ref) {
  return SemestersRepository(ref);
}

@Riverpod(keepAlive: true)
_RepositoryClient repositoryClient(RepositoryClientRef ref) {
  return _RepositoryClient(
      authRepository: ref.read(authRepositoryProvider),
      coursesRepository: ref.read(coursesRepositoryProvider),
      semestersRepository: ref.read(semestersRepositoryProvider));
}

abstract class AbstractRepository {
  final FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
}

class _RepositoryClient {
  final AuthRepository authRepository;
  final CoursesRepository coursesRepository;
  final SemestersRepository semestersRepository;

  const _RepositoryClient(
      {required this.authRepository,
      required this.coursesRepository,
      required this.semestersRepository});
}
