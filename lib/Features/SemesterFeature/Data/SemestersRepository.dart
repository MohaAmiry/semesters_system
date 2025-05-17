import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/AuthenticationFeature/Data/AuthController.dart';
import 'package:semester_system/Features/AuthenticationFeature/Domain/User/UserResponseDTO.dart';
import 'package:semester_system/Features/AuthenticationFeature/Domain/User/UserRole.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterCourse.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudent.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudentCourse.dart';
import 'package:semester_system/Features/_Shared/AbstractDataRepository.dart';
import 'package:semester_system/utils/FirebaseConstants.dart';

import '../Domain/Semester.dart';

class SemestersRepository extends AbstractRepository {
  final Ref ref;

  SemestersRepository(this.ref);

  Stream<IList<Semester>> getAllSemesters() => firebaseFireStore
          .collection(FirebaseConstants.semestersCollection)
          .snapshots()
          .asyncMap((event) async {
        return (await event.docs
                .map((e) => SemesterDTO.fromMap(e.data()))
                .map((e) async => await parseSemesterFromDTO(e))
                .wait)
            .toIList()
            .sort((a, b) => a.semesterNumber < b.semesterNumber ? 0 : 1);
      });

  Stream<Semester> getSemesterById(String id) => firebaseFireStore
      .collection(FirebaseConstants.semestersCollection)
      .doc(id)
      .snapshots()
      .asyncMap((event) async =>
          await parseSemesterFromDTO(SemesterDTO.fromMap(event.data()!)));

  Future<SemesterCourse> parseSemesterCourseFromDTO(
      SemesterCourseDTO semesterCourseDTO) async {
    return semesterCourseDTO.toSemesterCourse(await ref
        .read(repositoryClientProvider)
        .coursesRepository
        .getCourseById(semesterCourseDTO.courseId));
  }

  Future<IList<SemesterCourse>>
      getStudentRemainingCoursesForNextSemesterByStudentId(
          String studentId) async {
    var studentInfo = (await ref
        .read(repositoryClientProvider)
        .authRepository
        .getStudentInfoById(studentId));
    var nextSemesterCourses = await getSemesterCoursesBySemesterNumber(
        studentInfo.currentSemester + 1);
    return nextSemesterCourses.removeWhere((semesterCourse) =>
        studentInfo.finishedCourses.any((finishedCourseId) =>
            finishedCourseId == semesterCourse.course.courseId));
  }

  Future<IList<SemesterCourse>>
      getStudentRemainingCoursesForNextSemesterBySemester(
          Semester semester, String studentId) async {
    var studentInfo = (await ref
        .read(repositoryClientProvider)
        .authRepository
        .getStudentInfoById(studentId));
    return semester.courses.removeWhere((semesterCourse) =>
        studentInfo.finishedCourses.any((finishedCourseId) =>
            finishedCourseId == semesterCourse.course.courseId));
  }

  Future<Semester> getStudentNextSemesterByStudentId(String studentId) async {
    var studentInfo = (await ref
        .read(repositoryClientProvider)
        .authRepository
        .getStudentInfoById(studentId));
    return getSemesterBySemesterNumber(studentInfo.currentSemester + 1);
  }

  Future<IList<SemesterCourse>> getSemesterCoursesBySemesterNumber(
      int number) async {
    return (await getSemesterBySemesterNumber(number)).courses;
  }

  Future<bool> canStudentRegisterForNextSemester(String studentId) async {
    var studentInfo = (await ref
        .read(repositoryClientProvider)
        .authRepository
        .getStudentInfoById(studentId));
    print("1-1");
    if (studentInfo.currentSemester == 0) return true;
    print("1-2");
    var nextSemester =
        await getSemesterBySemesterNumber(studentInfo.currentSemester);
    print("1-3");
    var result = nextSemester.students
        .firstWhere((student) => student.studentId == studentId,
            orElse: () => throw Exception("هذا الطالب غير مسجل بالفصل"))
        .selectedCourses
        .every((course) => course.didPass != null);
    print("1-4");
    if (!result) {
      throw Exception(
          "لا يمكن للطالب هذا التسجيل بالفصل لأنه لم يتم تحديد نجاحه أو رسوبه بجميع مواد الفصل الحالي.");
    }
    return true;
  }

  Future<Semester> getSemesterBySemesterNumber(int number) async {
    var doc = (await firebaseFireStore
        .collection(FirebaseConstants.semestersCollection)
        .where(Semester.firebaseSemesterNumber, isEqualTo: number)
        .get());
    print("aaa1");
    if (doc.size == 0) throw Exception("لا يوجد فصل رقمه $number");

    var semesterDTO = SemesterDTO.fromMap(doc.docs.first.data());
    var courses = semesterDTO.courses
        .map((element) async => parseSemesterCourseFromDTO(element))
        .wait;
    print(courses);
    var students = semesterDTO.students.map((element) async {
      return getStudentSemesterFromDTO(element);
    }).wait;
    print(students);

    return semesterDTO.toSemester(
        (await courses).toIList(), (await students).toIList());
  }

  Future<bool> addNewSemester(SemesterDTO semester) async {
    var result = await firebaseFireStore
        .collection(FirebaseConstants.semestersCollection)
        .add(semester.toMap());
    var semestersCount = (await firebaseFireStore
            .collection(FirebaseConstants.semestersCollection)
            .count()
            .get())
        .count!;
    await result.update({
      SemesterDTO.firebaseSemesterId: result.id,
      SemesterDTO.firebaseSemesterNumber: semestersCount
    });
    return true;
  }

  Future<bool> registerNewStudentInSemester(SemesterStudentDTO student) async {
    var semesterDoc = await firebaseFireStore
        .collection(FirebaseConstants.semestersCollection)
        .doc(student.semesterId)
        .get();
    var semesterDTO = SemesterDTO.fromMap(semesterDoc.data()!);
    if (semesterDTO.students
        .any((element) => element.studentId == student.studentId)) {
      throw Exception("لا يمكن تسجيل الطالب أكثر من مرة");
    }
    semesterDTO = semesterDTO.copyWith(
        students: semesterDTO.students.add(student),
        courses: semesterDTO.courses
            .map((course) => student.selectedCourses.any((selectedCourse) =>
                    selectedCourse.course == course.courseId)
                ? course.copyWith(studentsNumber: course.studentsNumber + 1)
                : course)
            .toIList());

    await firebaseFireStore
        .collection(FirebaseConstants.semestersCollection)
        .doc(student.semesterId)
        .update(semesterDTO.toMap());
    await firebaseFireStore
        .collection(FirebaseConstants.userDataCollection)
        .doc(student.studentId)
        .update(
            {UserResponseDTO.firebaseCurrentSemester: FieldValue.increment(1)});
    await ref.refresh(authControllerProvider.future);
    return true;
  }

  Stream<SemesterStudent> getStudentCurrentSemester(
      int currentSemesterNumber, String studentId) {
    return firebaseFireStore
        .collection(FirebaseConstants.semestersCollection)
        .where(Semester.firebaseSemesterNumber,
            isEqualTo: currentSemesterNumber)
        .snapshots()
        .asyncMap((event) async {
      if (event.size == 0) throw Exception("لا يوجد فصل حاليا");
      var semesterDTO = SemesterDTO.fromMap(event.docs.first.data());
      var student = semesterDTO.students
          .where((element) => element.studentId == studentId)
          .firstOrNull;
      if (student == null) {
        throw Exception("حصل خطأ اثناء جلب مواد الطالب");
      }
      return parseSemesterStudentFromDTO(student, semesterDTO.courses);
    });
  }

  Future<SemesterStudent> parseSemesterStudentFromDTO(
      SemesterStudentDTO semesterStudent,
      IList<SemesterCourseDTO> allSemesterCourses) async {
    var user = ref
        .read(repositoryClientProvider)
        .authRepository
        .getStudentInfoById(semesterStudent.studentId);
    /*
    var filteredCourses = allSemesterCourses.where((semesterCourse) =>
        semesterStudent.selectedCourses.any((studentCourse) =>
            studentCourse.course == semesterCourse.courseId));

     */

    var filtered = semesterStudent.selectedCourses.map((e) => (
          allSemesterCourses
              .firstWhere((element) => element.courseId == e.course),
          e.didPass
        ));

    var courses = filtered.map((e) async {
      return SemesterStudentCourse(
          course: await parseSemesterCourseFromDTO(e.$1), didPass: e.$2);
    });
    return semesterStudent.toStudentSemester(await user, await (courses.wait));
  }

  Future<bool> updateSemester(SemesterDTO updatedSemester) async {
    if (updatedSemester.courses.isEmpty) {
      throw Exception("لا يمكن اضافة فصل دراسي بلا مواد");
    }
    await firebaseFireStore
        .collection(FirebaseConstants.semestersCollection)
        .doc(updatedSemester.semesterId)
        .update(updatedSemester.toMap());
    return true;
  }

  Future<Semester> parseSemesterFromDTO(SemesterDTO semesterDTO) async {
    var courses = semesterDTO.courses
        .map((element) async => parseSemesterCourseFromDTO(element));
    var students = semesterDTO.students.map((element) async {
      return getStudentSemesterFromDTO(element);
    });

    return semesterDTO.toSemester(
        (await courses.wait).toIList(), (await students.wait).toIList());
  }

  Future<SemesterCourse> getSemesterCourseByCourseAndSemesterId(
      String courseId, String semesterId) async {
    var semesterDTO = SemesterDTO.fromMap((await firebaseFireStore
            .collection(FirebaseConstants.semestersCollection)
            .doc(semesterId)
            .get())
        .data()!);
    var semesterCourseDTO = semesterDTO.courses
        .where((element) => element.courseId == courseId)
        .firstOrNull;
    if (semesterCourseDTO == null) {
      throw Exception("لا توجد مادة بالعنوان المطلوب");
    }
    var course = await ref
        .read(repositoryClientProvider)
        .coursesRepository
        .getCourseById(semesterCourseDTO.courseId);
    return semesterCourseDTO.toSemesterCourse(course);
  }

  Future<SemesterStudent> getStudentSemesterFromDTO(
      SemesterStudentDTO studentSemester) async {
    var rawStudentData = ref
        .read(repositoryClientProvider)
        .authRepository
        .getStudentInfoById(studentSemester.studentId);
    var studentCourses = studentSemester.selectedCourses.map((e) async {
      var course = await getSemesterCourseByCourseAndSemesterId(
          e.course, studentSemester.semesterId);
      return SemesterStudentCourse(course: course, didPass: e.didPass);
    });

    return studentSemester.toStudentSemester(
        await rawStudentData, await (studentCourses.wait));
  }

  Future<bool> setSemesterCourseStatusForStudent(String semesterId,
      String studentId, String courseId, bool didPass) async {
    var semesterDTODoc = firebaseFireStore
        .collection(FirebaseConstants.semestersCollection)
        .doc(semesterId);

    var semesterDTO = SemesterDTO.fromMap((await semesterDTODoc.get()).data()!);

    semesterDTO = semesterDTO.copyWith(
        students: semesterDTO.students.replaceFirstWhere(
            (student) => student.studentId == studentId,
            (student) => student!.copyWith(
                selectedCourses: student.selectedCourses.replaceFirstWhere(
                    (course) => course.course == courseId,
                    (course) => course!.copyWith(didPass: didPass)))));
    await semesterDTODoc.update(semesterDTO.toMap());
    if (didPass) {
      await addCourseToStudentFinishedCourses(studentId, courseId);
    }

    return true;
  }

  Future<bool> addCourseToStudentFinishedCourses(
      String studentId, String courseId) async {
    await firebaseFireStore
        .collection(FirebaseConstants.userDataCollection)
        .doc(studentId)
        .update({
      UserRole.firebaseFinishedCourses: FieldValue.arrayUnion([courseId])
    });
    return true;
  }
}
