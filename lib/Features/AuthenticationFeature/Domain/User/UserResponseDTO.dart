import 'package:dart_mappable/dart_mappable.dart';

import 'UserRole.dart';

part 'UserResponseDTO.mapper.dart';

@MappableClass()
class UserResponseDTO with UserResponseDTOMappable {
  final String email;
  final String password;
  final String name;
  final UserRoleEnum userRole;
  final String? universityId;
  final List<String> finishedCourses;
  final int currentSemester;

  const UserResponseDTO(
      {required this.email,
      required this.password,
      required this.name,
      required this.userRole,
      required this.finishedCourses,
      required this.currentSemester,
      this.universityId});

  static String get firebaseFinishedCourses => "finishedCourses";
  static String get firebaseCurrentSemester => "currentSemester";

  static const fromMap = UserResponseDTOMapper.fromMap;
}
