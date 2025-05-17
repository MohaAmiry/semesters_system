import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/AuthenticationFeature/Data/AuthController.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/SemesterStudent.dart';
import 'package:semester_system/Router/MyRoutes.gr.dart';
import 'package:semester_system/utils/Resouces/ColorManager.dart';

import '../../../../AuthenticationFeature/Domain/User/UserRole.dart';
import '../_Notifiers/SemesterNotifier.dart';

class SemesterStudentWidget extends ConsumerWidget {
  final int studentIndex;
  final IList<SemesterStudent> students;

  const SemesterStudentWidget(
      {super.key, required this.studentIndex, required this.students});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(semesterNotifierProvider(students: students));
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("اسم الطالب: ${provider.elementAt(studentIndex).studentName}",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: ColorManager.secondary)),
            Text(
                "رقم الطالب الجامعي: ${provider.elementAt(studentIndex).universityId}",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: ColorManager.secondary)),
            const Divider(),
            Align(
              alignment: Alignment.center,
              child: Text(
                "بيانات المواد",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            InkWell(
              onTap: () => ref.watch(authControllerProvider).value is Student
                  ? null
                  : context.router.push(SemesterStudentCoursesRoute(
                      studentIndex: studentIndex, students: students)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("عدد المواد المسجلة"),
                      Text(provider
                          .elementAt(studentIndex)
                          .selectedCourses
                          .length
                          .toString())
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("عدد المواد الناجحة",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  color: ColorManager
                                      .onSurfaceVariant1LightGreen)),
                      Text(
                          provider
                              .elementAt(studentIndex)
                              .selectedCourses
                              .where((element) => element.didPass ?? false)
                              .length
                              .toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  color:
                                      ColorManager.onSurfaceVariant1LightGreen))
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "عدد المواد الراسبة",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color:
                                    ColorManager.onSurfaceVariant1LightRedPink),
                      ),
                      Text(
                        provider
                            .elementAt(studentIndex)
                            .selectedCourses
                            .where((element) => !(element.didPass ?? true))
                            .length
                            .toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color:
                                    ColorManager.onSurfaceVariant1LightRedPink),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
