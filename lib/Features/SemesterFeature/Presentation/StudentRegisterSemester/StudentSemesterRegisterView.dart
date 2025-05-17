import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/ScheduleCourseTimes.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/StudentRegisterSemester/Notifiers/StudentSemesterRegisterNotifiers.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/_Widgets/SchedulaDayWidget.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/_Widgets/SemesterCourseWidget.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/ErrorView.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/LoadingView.dart';

import '../../../../utils/Resouces/ColorManager.dart';
import '../../Domain/SemesterCourse.dart';

@RoutePage()
class StudentSemesterRegisterView extends ConsumerStatefulWidget {
  const StudentSemesterRegisterView({super.key});

  @override
  ConsumerState createState() => _StudentSemesterRegisterViewState();
}

class _StudentSemesterRegisterViewState
    extends ConsumerState<StudentSemesterRegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تسجيل مواد الفصل الجديد"),
      ),
      backgroundColor: ColorManager.surface,
      body: ref.watch(studentSemesterRegisterNotifierProvider).when(
          data: (data) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      courseSelectionWidget(data.remainingCourses),
                      const Divider(),
                      selectedCoursesWidget(data.selectedCourse),
                      const Divider(),
                      scheduleWidget(data.selectedCourse),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            var result = await ref
                                .read(studentSemesterRegisterNotifierProvider
                                    .notifier)
                                .registerSemester();
                            if (result && context.mounted) {
                              context.router.maybePop();
                            }
                          },
                          child: const Text("إتمام التسجيل"))
                    ],
                  ),
                ),
              ),
          error: (error, stackTrace) => ErrorView(error: error),
          loading: () => const LoadingView()),
    );
  }

  Widget courseSelectionWidget(IList<SemesterCourse> courses) => ElevatedButton(
      onPressed: () async {
        var result = await displayCoursesDialog(context, courses);
        if (result != null) {
          ref
              .read(studentSemesterRegisterNotifierProvider.notifier)
              .addCourse(result);
        }
      },
      child: const SizedBox(
          width: double.infinity,
          child: Center(child: Text("عرض قائمة المواد"))));

  Widget selectedCoursesWidget(IList<SemesterCourse> selectedCourses) => Card(
          child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("المواد المضافة",
                style: Theme.of(context).textTheme.headlineMedium),
            selectedCourses.isEmpty
                ? const SizedBox(
                    width: double.infinity, child: Text("لا يوجد مواد مضافة"))
                : ListView.builder(
                    itemCount: selectedCourses.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  onPressed: () => ref
                                      .read(
                                          studentSemesterRegisterNotifierProvider
                                              .notifier)
                                      .removeCourse(
                                          selectedCourses.elementAt(index)),
                                  icon: const Icon(
                                    Icons.remove,
                                    color: ColorManager.error,
                                  ),
                                ),
                              ),
                              SemesterCourseWidget(
                                  course: selectedCourses.elementAt(index))
                            ],
                          ),
                        )),
          ],
        ),
      ));

  Widget scheduleWidget(IList<SemesterCourse> selectedCourses) => Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "عدد الساعات الأقصى: ${ref.watch(studentSemesterRegisterNotifierProvider).requireValue.hoursLimit}"),
                    Text(
                        "عدد الساعات المسجلة: ${ref.watch(studentSemesterRegisterNotifierProvider).requireValue.currentRegisteredHours}"),
                  ],
                ),
                const Divider(),
                ScheduleDayWidget(
                    coursesTimes: ScheduleCourseTime.getTimesFromAllCourse(
                        selectedCourses)),
              ],
            ),
          ),
        ),
      );

  Future<SemesterCourse?> displayCoursesDialog(
      BuildContext context, IList<SemesterCourse> courses) async {
    return await showDialog<SemesterCourse>(
      context: context,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: const Text("المواد المتاحة"),
          content: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.8,
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: courses.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () async {
                      await context.router.maybePop(courses.elementAt(index));
                    },
                    child: SemesterCourseSelectableWidget(
                        course: courses.elementAt(index),
                        color: ref
                            .read(studentSemesterRegisterNotifierProvider
                                .notifier)
                            .getColor(courses.elementAt(index))))),
          ),
        );
      },
    );
  }
}
