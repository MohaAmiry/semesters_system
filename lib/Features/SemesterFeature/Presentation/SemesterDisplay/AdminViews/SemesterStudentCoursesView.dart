import 'package:auto_route/annotations.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/SemesterDisplay/_Widgets/SemesterStudentCourseWidget.dart';

import '../../../../../utils/Resouces/ColorManager.dart';
import '../../../Domain/SemesterStudent.dart';
import '../_Notifiers/SemesterNotifier.dart';

@RoutePage()
class SemesterStudentCoursesView extends ConsumerWidget {
  final int studentIndex;
  final IList<SemesterStudent> students;

  const SemesterStudentCoursesView(
      {super.key, required this.studentIndex, required this.students});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var provider = ref.watch(semesterNotifierProvider(students: students));
    return Scaffold(
        appBar: AppBar(
          title: const Text("مواد الفصل"),
        ),
        backgroundColor: ColorManager.surface,
        body: ListView.builder(
          itemCount: provider.elementAt(studentIndex).selectedCourses.length,
          itemBuilder: (context, index) => SemesterStudentCourseWidget(
              students: students,
              semesterId: provider.elementAt(studentIndex).semesterId,
              studentCourseInfo: (
                studentIndex: studentIndex,
                courseIndex: index
              ),
              studentId: provider.elementAt(studentIndex).studentId),
        ));
  }
}
