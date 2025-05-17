// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element

import '../Features/AuthenticationFeature/Data/RequestsModels/LoginRequest/LoginEntityRequest.dart'
    as p0;
import '../Features/AuthenticationFeature/Data/RequestsModels/RegisterRequestsModels/RegisterRequest.dart'
    as p1;
import '../Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart'
    as p2;
import '../Features/AuthenticationFeature/Domain/User/UserRole.dart' as p3;
import '../Features/SemesterFeature/Domain/Course.dart' as p4;
import '../Features/SemesterFeature/Domain/ScheduleCourseTimes.dart' as p5;
import '../Features/SemesterFeature/Domain/Semester.dart' as p6;
import '../Features/SemesterFeature/Domain/SemesterCourse.dart' as p7;
import '../Features/SemesterFeature/Domain/SemesterStudent.dart' as p8;
import '../Features/SemesterFeature/Domain/SemesterStudentCourse.dart' as p9;
import '../Features/SemesterFeature/Domain/Time.dart' as p10;
import '../Features/SemesterFeature/Presentation/AddSemester/Enitities/AddSemesterCourseEntity.dart'
    as p11;
import '../Features/SemesterFeature/Presentation/AddSemester/Enitities/AddSemesterEntity.dart'
    as p12;
import '../Features/SemesterFeature/Presentation/StudentRegisterSemester/Entity/StudentSemesterRegisterEntity.dart'
    as p13;

void initializeMappers() {
  p0.LoginRequestMapper.ensureInitialized();
  p1.RegisterRequestMapper.ensureInitialized();
  p2.UserResponseDTOMapper.ensureInitialized();
  p3.UserRoleMapper.ensureInitialized();
  p3.AdminMapper.ensureInitialized();
  p3.StudentMapper.ensureInitialized();
  p3.UserRoleEnumMapper.ensureInitialized();
  p4.CourseDTOMapper.ensureInitialized();
  p4.CourseMapper.ensureInitialized();
  p5.ScheduleCourseTimeMapper.ensureInitialized();
  p6.SemesterDTOMapper.ensureInitialized();
  p6.SemesterMapper.ensureInitialized();
  p7.SemesterCourseMapper.ensureInitialized();
  p7.SemesterCourseDTOMapper.ensureInitialized();
  p8.SemesterStudentMapper.ensureInitialized();
  p8.SemesterStudentDTOMapper.ensureInitialized();
  p9.SemesterStudentCourseDTOMapper.ensureInitialized();
  p9.SemesterStudentCourseMapper.ensureInitialized();
  p10.TimeMapper.ensureInitialized();
  p10.CourseTimeMapper.ensureInitialized();
  p10.DayMapper.ensureInitialized();
  p11.AddSemesterCourseEntityMapper.ensureInitialized();
  p12.AddSemesterEntityMapper.ensureInitialized();
  p13.StudentSemesterRegisterEntityMapper.ensureInitialized();
}
