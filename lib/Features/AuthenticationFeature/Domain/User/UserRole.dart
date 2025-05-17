import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'UserRole.mapper.dart';

@MappableEnum()
enum UserRoleEnum { admin, student }

@MappableClass()
sealed class UserRole with UserRoleMappable {
  final User? user;
  final String name;
  final String email;
  final String password;

  const UserRole(
      {this.user,
      required this.name,
      required this.email,
      required this.password});

  static String get firebaseFinishedCourses => "finishedCourses";

  @override
  String toString() {
    return 'Customer{user: $user, name: $name, email: $email, password: $password}';
  }
}

@MappableClass()
class Admin extends UserRole with AdminMappable {
  const Admin(
      {super.user,
      required super.name,
      required super.email,
      required super.password});

  static const fromMap = AdminMapper.fromMap;
}

@MappableClass()
class Student extends UserRole with StudentMappable {
  final String universityId;
  final IList<String> finishedCourses;
  final int currentSemester;

  const Student(
      {super.user,
      required super.name,
      required super.email,
      required super.password,
      required this.universityId,
      required this.finishedCourses,
      required this.currentSemester});

  static const fromMap = StudentMapper.fromMap;
}
