import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Course.dart';
import 'package:semester_system/Features/_Shared/AbstractDataRepository.dart';
import 'package:semester_system/utils/FirebaseConstants.dart';

class CoursesRepository extends AbstractRepository {
  final Ref ref;

  CoursesRepository(this.ref);

  Future<List<Course>> getAllCourses() async {
    var rawCourses = (await firebaseFireStore
            .collection(FirebaseConstants.coursesCollection)
            .get())
        .docs
        .map((e) => CourseDTO.fromMap(e.data()))
        .toList();
    var preRequisites = await rawCourses.map((e) async {
      var futures = e.preRequisitesIds.map((element) async {
        return CourseDTO.fromMap((await firebaseFireStore
                .collection(FirebaseConstants.coursesCollection)
                .doc(element)
                .get())
            .data()!);
      });
      return futures.wait;
    }).wait;
    List<Course> courses = [];
    for (int i = 0; i < rawCourses.length; i++) {
      courses.add(rawCourses.elementAt(i).toCourse(preRequisites.elementAt(i)));
    }
    return courses;
  }

  Stream<List<Course>> getAllCoursesStream() {
    return firebaseFireStore
        .collection(FirebaseConstants.coursesCollection)
        .snapshots()
        .asyncMap((e) async {
      var courses = e.docs.map((e) async {
        var course = CourseDTO.fromMap(e.data());

        var preRequisites = await course.preRequisitesIds.map((e) async {
          var futures = CourseDTO.fromMap((await firebaseFireStore
                  .collection(FirebaseConstants.coursesCollection)
                  .doc(e)
                  .get())
              .data()!);
          return futures;
        }).wait;

        return course.toCourse(preRequisites);
      }).wait;

      return courses;
    });
  }

  Future<Course> getCourseById(String courseId) async {
    var rawCourse = CourseDTO.fromMap((await firebaseFireStore
            .collection(FirebaseConstants.coursesCollection)
            .doc(courseId)
            .get())
        .data()!);
    var preRequisites = await rawCourse.preRequisitesIds.map((e) async {
      var futures = CourseDTO.fromMap((await firebaseFireStore
              .collection(FirebaseConstants.coursesCollection)
              .doc(e)
              .get())
          .data()!);
      return futures;
    }).wait;
    return rawCourse.toCourse(preRequisites);
  }

  Future<List<Course>> getStudentFinishedCourses(String studentId) async {
    var user = await ref
        .read(repositoryClientProvider)
        .authRepository
        .getStudentInfoById(studentId);
    return await user.finishedCourses.map((e) => getCourseById(e)).wait;
  }

  Future<List<Course>> getStudentRemainingCourses(String studentId) async {
    var user = await ref
        .read(repositoryClientProvider)
        .authRepository
        .getStudentInfoById(studentId);
    return (await firebaseFireStore
            .collection(FirebaseConstants.coursesCollection)
            .where(Course.firebaseCourseId, whereNotIn: user.finishedCourses)
            .get())
        .docs
        .map((e) => Course.fromMap(e.data()))
        .toList();
  }

  Future<bool> addCourse(CourseDTO course) async {
    var courses = await getAllCourses();

    if (courses.any((element) => element.courseNumber == course.courseNumber)) {
      throw Exception("توجد مادة بنفس الرقم");
    }
    if (courses.any((element) => element.courseName == course.courseName)) {
      throw Exception("توجد مادة بنفس الأسم");
    }

    var result = await firebaseFireStore
        .collection(FirebaseConstants.coursesCollection)
        .add(course.toMap());
    await result.update({CourseDTO.firebaseCourseId: result.id});

    return true;
  }

  Future<bool> removeCourseById(String id) async {
    await firebaseFireStore
        .collection(FirebaseConstants.coursesCollection)
        .doc(id)
        .delete();
    return true;
  }
}
