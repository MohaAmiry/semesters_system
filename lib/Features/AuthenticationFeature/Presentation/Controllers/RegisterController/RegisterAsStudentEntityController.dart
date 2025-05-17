import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../utils/SharedOperations.dart';
import '../../../Data/RequestsModels/RegisterRequestsModels/RegisterRequest.dart';

part 'RegisterAsStudentEntityController.g.dart';

@riverpod
class RegisterAsStudentEntityController
    extends _$RegisterAsStudentEntityController with SharedUserOperations {
  @override
  RegisterRequest build() {
    return RegisterRequest(
        name: "",
        email: "",
        password: "",
        universityId: "",
        finishedCourses: IList());
  }

  void setName(String newNameVal) {
    state = state.copyWith(name: newNameVal);
  }

  void setEmail(String newMailVal) {
    state = state.copyWith(email: newMailVal);
  }

  void setPassword(String newPassVal) =>
      state = state.copyWith(password: newPassVal);

  void setUniversityId(String universityId) =>
      state = state.copyWith(universityId: universityId);
}
