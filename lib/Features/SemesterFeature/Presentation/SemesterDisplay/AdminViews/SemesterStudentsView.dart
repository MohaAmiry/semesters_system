import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/Resouces/ColorManager.dart';
import '../../../Domain/Semester.dart';
import '../_Notifiers/SemesterNotifier.dart';
import '../_Widgets/SemesterStudentWidget.dart';

@RoutePage()
class SemesterStudentsView extends ConsumerWidget {
  final Semester semester;

  const SemesterStudentsView({super.key, required this.semester});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        ref.watch(semesterNotifierProvider(students: semester.students));
    return Scaffold(
      appBar: AppBar(
        title: const Text("الطلاب المسجلون بالفصل"),
      ),
      backgroundColor: ColorManager.surface,
      body: ListView.builder(
        itemCount: provider.length,
        itemBuilder: (context, index) => SemesterStudentWidget(
          studentIndex: index,
          students: provider,
        ),
      ),
    );
  }
}
