import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/FirebaseConstants.dart';
import '../../_Shared/AbstractDataRepository.dart';
import '../Domain/User/UserResponseDTO.dart';
import '../Domain/User/UserRole.dart';
import 'RequestsModels/LoginRequest/LoginEntityRequest.dart';
import 'RequestsModels/RegisterRequestsModels/RegisterRequest.dart';

class AuthRepository extends AbstractRepository {
  final Ref ref;

  AuthRepository(this.ref);

  User? get getCurrentUser => FirebaseAuth.instance.currentUser;

  String get getCurrentUserID => getCurrentUser!.uid;

  Future<void> signUp(RegisterRequest registerRequest) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: registerRequest.email, password: registerRequest.password);
      if (firebaseAuth.currentUser != null) {
        await getCurrentStudentDoc().set(registerRequest.toMap());
      }
      await firebaseAuth.signInWithEmailAndPassword(
          email: "admin@admin.com", password: "1231231");
    } on Exception {
      rethrow;
    }
  }

  DocumentReference<Map<String, dynamic>> getCurrentStudentDoc() =>
      FirebaseFirestore.instance
          .collection(FirebaseConstants.userDataCollection)
          .doc(AuthRepository(ref).getCurrentUser!.uid);

  Future<void> createAdminUser() async {
    var req = RegisterRequest(
        name: "admin",
        email: "admin@admin.com",
        password: "1231231",
        universityId: "",
        finishedCourses: IList(),
        userRole: UserRoleEnum.admin);
    await firebaseAuth.createUserWithEmailAndPassword(
        email: req.email, password: req.password);
    if (firebaseAuth.currentUser != null) {
      await getCurrentStudentDoc().set(req.toMap());
    }
    await firebaseAuth.signOut();
  }

  Future<UserRole> signIn(LoginRequest loginReqModel) async {
    try {
      var userCredentials = (await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: loginReqModel.email, password: loginReqModel.password));
      if (userCredentials.user == null) {
        throw Exception("User is Null");
      }
      var userData = await getUserTypeDoc();

      return userData;
    } on Exception {
      rethrow;
    }
  }

  Future<UserResponseDTO> getStudentInfoById(String studentId) async {
    return UserResponseDTO.fromMap((await firebaseFireStore
            .collection(FirebaseConstants.userDataCollection)
            .doc(studentId)
            .get())
        .data()!);
  }

  Future<void> signOut() async => await firebaseAuth.signOut();

  Future<UserRole> getUserTypeDoc() async {
    try {
      var userID = getCurrentUser?.uid ?? " ";
      if ((await FirebaseFirestore.instance
              .collection(FirebaseConstants.userDataCollection)
              .doc(userID)
              .get())
          .exists) {
        var userData = UserResponseDTO.fromMap((await FirebaseFirestore.instance
                .collection(FirebaseConstants.userDataCollection)
                .doc(userID)
                .get())
            .data()!);
        switch (userData.userRole) {
          case UserRoleEnum.admin:
            return Admin(
                user: getCurrentUser!,
                name: userData.name,
                email: userData.email,
                password: userData.password);
          case UserRoleEnum.student:
            return Student(
                user: getCurrentUser!,
                name: userData.name,
                email: userData.email,
                password: userData.password,
                universityId: userData.universityId!,
                finishedCourses: userData.finishedCourses.toIList(),
                currentSemester: userData.currentSemester);
        }
      }
      throw Exception("User Document Does Not Exist");
    } on Exception {
      rethrow;
    }
  }
}
