import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Course.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/LoadingView.dart';

import '../../../../utils/Resouces/ColorManager.dart';
import '../../../../utils/Resouces/ValuesManager.dart';
import '../../../_Shared/UtilsViews/ErrorView.dart';
import 'Notifiers/AddCourseNotifier.dart';

@RoutePage()
class AddCourseView extends ConsumerStatefulWidget {
  const AddCourseView({super.key});

  @override
  ConsumerState createState() => _AddCourseViewState();
}

class _AddCourseViewState extends ConsumerState<AddCourseView> {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController courseNumberController = TextEditingController();
  final TextEditingController courseHoursController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.watch(addCourseNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة مادة جديدة"),
      ),
      backgroundColor: ColorManager.surface,
      body: ref.watch(allAvailableCoursesProvider).when(
            data: (data) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(PaddingValuesManager.p20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    courseInfoWidget(),
                    const Divider(),
                    prerequisiteWidget(data),
                    const SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: () async {
                          var result = await ref
                              .read(addCourseNotifierProvider.notifier)
                              .addCourse();
                          if (result && context.mounted) {
                            context.router.maybePop();
                          }
                        },
                        child: const Text("إضافة مادة جديدة"))
                  ],
                ),
              ),
            ),
            error: (error, stackTrace) => ErrorView(error: error),
            loading: () => const LoadingView(),
          ),
    );
  }

  // **************************** helpers!

  Widget courseInfoWidget() => Column(children: [
        TextFormField(
            controller: courseNameController,
            onChanged: (value) =>
                ref.read(addCourseNotifierProvider.notifier).setName(value),
            decoration: const InputDecoration(
                helperText: "",
                labelText: "اسم المادة",
                hintText: "اسم المادة")),
        TextFormField(
            controller: courseNumberController,
            onChanged: (value) =>
                ref.read(addCourseNotifierProvider.notifier).setNumber(value),
            decoration: const InputDecoration(
                helperText: "",
                labelText: "رقم المادة",
                hintText: "رقم المادة")),
        TextFormField(
            controller: courseHoursController,
            onChanged: (value) =>
                ref.read(addCourseNotifierProvider.notifier).setHours(value),
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            decoration: const InputDecoration(
                helperText: "",
                labelText: "ساعات المادة",
                hintText: "ساعات المادة")),
      ]);

  Widget prerequisiteWidget(List<Course> data) => Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: PaddingValuesManager.p20),
            decoration: BoxDecoration(
                color: ColorManager.primaryContainer,
                borderRadius: BorderRadius.circular(AppSizeManager.s10),
                border: Border.all(color: ColorManager.primary20opacity)),
            child: DropdownButton<Course?>(
              hint: const Align(
                  alignment: Alignment.centerLeft, child: Text("قائمة المواد")),
              isExpanded: true,
              underline: Container(),
              alignment: Alignment.bottomCenter,
              elevation: 0,
              borderRadius: BorderRadius.circular(AppSizeManager.s10),
              value: null,
              icon: const Icon(Icons.keyboard_arrow_down),
              style: Theme.of(context).textTheme.headlineMedium,
              isDense: true,
              menuMaxHeight: MediaQuery.sizeOf(context).height * 0.4,
              padding: const EdgeInsets.symmetric(
                  horizontal: PaddingValuesManager.p10,
                  vertical: PaddingValuesManager.p10),
              dropdownColor: ColorManager.primaryContainer,
              items: data
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.overViewString),
                    ),
                  )
                  .toList(),
              onChanged: (Course? value) {
                if (value == null) return;
                ref
                    .read(addCourseNotifierProvider.notifier)
                    .addPrerequisite(value);
              },
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ref
                            .watch(addCourseNotifierProvider)
                            .preRequisites
                            .isEmpty
                        ? const Center(child: Text("لا توجد متطلبات سابقة"))
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ref
                                .watch(addCourseNotifierProvider)
                                .preRequisites
                                .length,
                            itemBuilder: (context, index) => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(ref
                                    .watch(addCourseNotifierProvider)
                                    .preRequisites
                                    .elementAt(index)
                                    .overViewString),
                                IconButton(
                                  onPressed: () => ref
                                      .read(addCourseNotifierProvider.notifier)
                                      .removePrerequisite(index),
                                  icon: const Icon(Icons.remove_circle,
                                      color: ColorManager.error),
                                )
                              ],
                            ),
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      );
}
