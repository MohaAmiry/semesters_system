import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:semester_system/ExceptionHandler/MessageEmitter.dart';
import 'package:semester_system/Features/SemesterFeature/Domain/Time.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/AddSemester/Notifiers/AddSemesterNotifier.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/AddSemester/Notifiers/SelectedCourseNotifier.dart';
import 'package:semester_system/Features/SemesterFeature/Presentation/_Widgets/AddSemesterCourseWidget.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/ErrorView.dart';
import 'package:semester_system/Features/_Shared/UtilsViews/LoadingView.dart';
import 'package:semester_system/utils/Extensions.dart';
import 'package:semester_system/utils/Resouces/ThemeManager.dart';

import '../../../../utils/Resouces/ColorManager.dart';
import '../../../../utils/Resouces/ValuesManager.dart';
import '../../Domain/Course.dart';
import '../Courses/Notifiers/AddCourseNotifier.dart';

@RoutePage()
class AddSemesterView extends ConsumerStatefulWidget {
  const AddSemesterView({super.key});

  @override
  ConsumerState createState() => _AddSemesterViewState();
}

class _AddSemesterViewState extends ConsumerState<AddSemesterView> {
  final TextEditingController timeFromController = TextEditingController();
  final TextEditingController timeToController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  bool isPractical = false;
  Day day = Day.saturday;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("إضافة فصل جديد"),
      ),
      backgroundColor: ColorManager.surface,
      body: ref.watch(allAvailableCoursesProvider).when(
            data: (data) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(PaddingValuesManager.p20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    summerSelectionAndCourseSelectionAndCapacityWidget(data),
                    courseTimeWidget(),
                    choosePracticalAndAddWidget(),
                    insertedCourseTimesWidget(context),
                    insertedCoursesWidget(),
                    ElevatedButton(
                        onPressed: () async {
                          var result = await ref
                              .read(addSemesterNotifierProvider.notifier)
                              .addSemester();
                          if (result && context.mounted) {
                            context.router.maybePop();
                          }
                        },
                        child: Text("إضافة فصل جديد"))
                  ],
                ),
              ),
            ),
            error: (Object error, StackTrace stackTrace) =>
                ErrorView(error: error),
            loading: () => const LoadingView(),
          ),
    );
  }

  Widget courseTimeWidget() => Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: PaddingValuesManager.p20),
            decoration: BoxDecoration(
                color: ColorManager.primaryContainer,
                borderRadius: BorderRadius.circular(AppSizeManager.s10),
                border: Border.all(color: ColorManager.primary20opacity)),
            child: DropdownButton<Day>(
              hint: const Align(
                  alignment: Alignment.centerLeft, child: Text("يوم المادة")),
              isExpanded: true,
              underline: Container(),
              alignment: Alignment.bottomCenter,
              elevation: 0,
              borderRadius: BorderRadius.circular(AppSizeManager.s10),
              value: day,
              icon: const Icon(Icons.keyboard_arrow_down),
              style: Theme.of(context).textTheme.headlineMedium,
              isDense: true,
              menuMaxHeight: MediaQuery.sizeOf(context).height * 0.4,
              padding: const EdgeInsets.symmetric(
                  horizontal: PaddingValuesManager.p10,
                  vertical: PaddingValuesManager.p10),
              dropdownColor: ColorManager.primaryContainer,
              items: Day.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                  .toList(),
              onChanged: (Day? value) {
                if (value == null) return;
                setState(() {
                  day = value;
                });
              },
            ),
          ),
          InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              onTap: () async {
                DateTime? dateTime = await showOmniDateTimePicker(
                  context: context,
                  type: OmniDateTimePickerType.time,
                  is24HourMode: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 650,
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1.drive(
                        Tween(
                          begin: 0,
                          end: 1,
                        ),
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 400),
                  barrierDismissible: true,
                );
                timeFromController.text = dateTime?.toTime() ?? "";
              },
              child: TextFormField(
                controller: timeFromController,
                enabled: false,
                decoration: const InputDecoration(
                  hintText: "وقت بداية المحاضرة",
                  labelText: "وقت بداية المحاضرة",
                  helperText: "",
                ),
              )),
          InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              onTap: () async {
                if (timeFromController.value.text.isEmpty) {
                  ref.read(messageEmitterProvider.notifier).setFailed(
                      message: Exception("قم باختيار وقت البداية أولًا"));
                  return;
                }
                DateTime? dateTime = await showOmniDateTimePicker(
                  context: context,
                  type: OmniDateTimePickerType.time,
                  is24HourMode: true,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  constraints: const BoxConstraints(
                    maxWidth: 350,
                    maxHeight: 650,
                  ),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1.drive(
                        Tween(
                          begin: 0,
                          end: 1,
                        ),
                      ),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 400),
                  barrierDismissible: true,
                );
                var toTime = dateTime?.toTime() ?? "";
                if (toTime.isEmpty) return;
                var parsedFromTime = Time.fromString(timeFromController.text);
                var parsedToTime = Time.fromString(toTime);
                if (!Time.isStartBeforeEnd(parsedFromTime, parsedToTime)) {
                  ref.read(messageEmitterProvider.notifier).setFailed(
                      message:
                          Exception("لا يمكن ان يكون وقت النهاية قبل البداية"));
                  return;
                }
                timeToController.text = dateTime?.toTime() ?? "";
              },
              child: TextFormField(
                controller: timeToController,
                enabled: false,
                decoration: const InputDecoration(
                  hintText: "وقت نهاية المحاضرة",
                  labelText: "وقت نهاية المحاضرة",
                  helperText: "",
                ),
              )),
        ],
      );

  Widget summerSelectionAndCourseSelectionAndCapacityWidget(
          List<Course> data) =>
      Column(
        children: [
          Row(
            children: [
              Checkbox(
                  value:
                      ref.watch(addSemesterNotifierProvider).isSummerSemester,
                  onChanged: (value) => setState(() {
                        ref
                            .watch(addSemesterNotifierProvider.notifier)
                            .setSemesterType(value!);
                      })),
              const Text("هل هذا فصل صيفي؟")
            ],
          ),
          const Divider(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: PaddingValuesManager.p20),
            decoration: BoxDecoration(
                color: ColorManager.primaryContainer,
                borderRadius: BorderRadius.circular(AppSizeManager.s10),
                border: Border.all(color: ColorManager.primary20opacity)),
            child: DropdownButton<CourseDTO?>(
              hint: const Align(
                  alignment: Alignment.centerLeft, child: Text("قائمة المواد")),
              isExpanded: true,
              underline: Container(),
              alignment: Alignment.bottomCenter,
              elevation: 0,
              borderRadius: BorderRadius.circular(AppSizeManager.s10),
              value: ref.watch(selectedCourseNotifierProvider
                  .select((value) => value.course)),
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
                      value: e.toCourseDTO(),
                      child: Text(e.overViewString),
                    ),
                  )
                  .toList(),
              onChanged: (CourseDTO? value) {
                if (value == null) return;
                ref
                    .read(selectedCourseNotifierProvider.notifier)
                    .setCourse(value);
              },
            ),
          ),
          TextFormField(
            controller: capacityController,
            onChanged: (value) => ref
                .read(selectedCourseNotifierProvider.notifier)
                .setCapacity(value),
            keyboardType: const TextInputType.numberWithOptions(signed: true),
            decoration: const InputDecoration(
              hintText: "السعة",
              labelText: "السعة",
              helperText: "",
            ),
          ),
        ],
      );

  Widget insertedCourseTimesWidget(BuildContext context) => Column(
        children: [
          Card(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text("محاضرات النظري",
                      style: Theme.of(context).textTheme.headlineMedium),
                  ...ref.watch(selectedCourseNotifierProvider).theoryTime.map(
                        (element) => Row(
                          children: [
                            Text(element.toString()),
                            IconButton(
                                onPressed: () => ref
                                    .read(
                                        selectedCourseNotifierProvider.notifier)
                                    .removeTime(element, false),
                                icon: const Icon(Icons.remove,
                                    color: ColorManager.error)),
                          ],
                        ),
                      ),
                  Text("محاضرات العملي",
                      style: Theme.of(context).textTheme.headlineMedium),
                  ...ref
                      .watch(selectedCourseNotifierProvider)
                      .practicalTime
                      .map((element) => Row(children: [
                            Text(element.toString()),
                            IconButton(
                                onPressed: () => ref
                                    .read(
                                        selectedCourseNotifierProvider.notifier)
                                    .removeTime(element, true),
                                icon: const Icon(Icons.remove,
                                    color: ColorManager.error))
                          ])),
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () => ref
                  .read(addSemesterNotifierProvider.notifier)
                  .addCourse(ref
                      .read(selectedCourseNotifierProvider)
                      .toAddSemesterCourseEntity()),
              child: const Text("إضافة مادة جديدة"))
        ],
      );

  Widget choosePracticalAndAddWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                  value: isPractical,
                  onChanged: (value) => setState(() {
                        isPractical = value!;
                      })),
              const Text("محاضرة عملي")
            ],
          ),
          ElevatedButton(
              style: ThemeManager.getElevatedButtonThemeSmall().style?.copyWith(
                  backgroundColor:
                      const WidgetStatePropertyAll(ColorManager.secondary)),
              onPressed: () {
                ref.read(selectedCourseNotifierProvider.notifier).addTime(
                    CourseTime(
                        from: Time.fromString(timeFromController.value.text),
                        to: Time.fromString(timeToController.value.text),
                        day: day),
                    isPractical);
              },
              child: const Text("إضافة محاضرة"))
        ],
      );

  Widget insertedCoursesWidget() {
    final courses =
        ref.watch(addSemesterNotifierProvider.select((value) => value.courses));
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: courses.isEmpty
              ? const SizedBox(
                  width: double.infinity,
                  child: Center(child: Text("لا توجد مواد مضافة")))
              : Column(
                  children: courses
                      .map((element) => AddSemesterCourseWidget(
                            course: element,
                            removeFunc: () => ref
                                .read(addSemesterNotifierProvider.notifier)
                                .removeCourse(element),
                          ))
                      .toList(),
                )),
    );
  }
}
