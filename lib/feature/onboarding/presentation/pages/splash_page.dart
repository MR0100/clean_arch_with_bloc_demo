import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/router/app_router.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/onboarding/presentation/bloc/splash/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    di.get<SplashBloc>().add(OnSplashInit());
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashNavigate) {
          Navigator.pushReplacementNamed(
            context,
            AppRouterPaths.dashboard.path,
          );
        }
      },
      child: Scaffold(
        body: Center(
          child: Text(
            "KGK\nSplash Screen",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
