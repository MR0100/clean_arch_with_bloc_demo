import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/router/app_router.dart';
import 'package:kgk/core/utils/constants/app_shared_pref_key.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:kgk/feature/onboarding/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:kgk/feature/onboarding/presentation/bloc/splash/splash_bloc.dart';
import 'package:kgk/feature/products/presentation/bloc/filter/filter_bloc.dart';
import 'package:kgk/feature/products/presentation/bloc/product/product_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();

  await initInjections();
  runApp(KGKApplication());
}

class KGKApplication extends StatefulWidget {
  const KGKApplication({super.key});

  @override
  State<KGKApplication> createState() => _KGKApplicationState();
}

class _KGKApplicationState extends State<KGKApplication> {
  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider will set the boundaries for all the Bloc object we create.
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(create: (_) => di.get<SplashBloc>()),
        BlocProvider<DashboardBloc>(create: (_) => di.get<DashboardBloc>()),
        BlocProvider<ProductBloc>(create: (_) => di.get<ProductBloc>()),
        BlocProvider<FilterBloc>(create: (_) => di.get<FilterBloc>()),
        BlocProvider<CartBloc>(create: (_) => di.get<CartBloc>()),
      ],
      child: MaterialApp(
        initialRoute: AppRouterPaths.root.path,
        onGenerateRoute: AppRouter.onGenerate,
      ),
    );
  }
}
