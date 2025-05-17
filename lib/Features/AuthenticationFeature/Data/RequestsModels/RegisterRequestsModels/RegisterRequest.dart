import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../Domain/User/UserRole.dart';

part 'RegisterRequest.mapper.dart';

@MappableClass()
class RegisterRequest with RegisterRequestMappable {
  final String name;
  final String email;
  final String password;
  final String universityId;
  final UserRoleEnum userRole;
  final IList<String> finishedCourses;
  final int currentSemester;

  const RegisterRequest(
      {required this.name,
      required this.email,
      required this.password,
      required this.universityId,
      required this.finishedCourses,
      this.currentSemester = 0,
      this.userRole = UserRoleEnum.student});
}
