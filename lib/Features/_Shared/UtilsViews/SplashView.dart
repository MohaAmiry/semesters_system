import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_system/Features/AuthenticationFeature/Domain/User/UserRole.dart';

import '../../../Router/MyRoutes.gr.dart';
import '../../AuthenticationFeature/Data/AuthController.dart';

@RoutePage()
class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authControllerProvider).whenData((value) async {
      if (value == null) {
        return context.router.replace(const LoginRoute());
      }
      if (value is Admin) {
        return context.router.replace(const AllSemestersRoute());
      }
      return context.router.replace(const StudentCurrentSemesterRoute());
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: Image.asset("assets/Logo.png")),
            const LoadingSpinner(),
          ],
        ),
      ),
    );
  }
}

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.square(
      dimension: 16,
      child: CircularProgressIndicator(
        strokeWidth: 1.5,
      ),
    );
  }
}
