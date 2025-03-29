import 'package:get_it/get_it.dart';
import 'package:kgk/feature/cart/presentation/bloc/cart_bloc.dart';
import 'package:kgk/feature/onboarding/presentation/bloc/dashboard/dashboard_bloc.dart';
import 'package:kgk/feature/onboarding/presentation/bloc/splash/splash_bloc.dart';
import 'package:kgk/feature/products/data/repositories/product_repo_impl.dart';
import 'package:kgk/feature/products/data/sources/local/product/product_api.dart';
import 'package:kgk/feature/products/data/sources/local/product/product_api_impl.dart';
import 'package:kgk/feature/products/domain/repositories/product_repo.dart';
import 'package:kgk/feature/products/domain/usecases/product/load_product_usecase.dart';
import 'package:kgk/feature/products/presentation/bloc/filter/filter_bloc.dart';
import 'package:kgk/feature/products/presentation/bloc/product/product_bloc.dart';
import 'package:kgk/shared/data/repository/converter_repo_impl.dart';
import 'package:kgk/shared/data/source/local/converter_api.dart';
import 'package:kgk/shared/data/source/local/converter_api_impl.dart';
import 'package:kgk/shared/domain/repository/converter_repo.dart';
import 'package:kgk/shared/domain/usecases/convert_data_from_csv_usecase.dart';

final di = GetIt.instance;

Future<void> initInjections() async {
  // register API instances.
  di
    ..registerLazySingleton<ConverterAPI>(() => ConverterAPIImpl())
    ..registerLazySingleton<ProductAPI>(() => ProductApiImpl());

  // register REPOSITORIES instance.
  di
    ..registerLazySingleton<ConverterRepo>(
      () => ConverterRepoImpl(converterAPI: di.get<ConverterAPI>()),
    )
    ..registerLazySingleton<ProductRepo>(
        () => ProductRepoImpl(productAPI: di.get<ProductAPI>()));

  // register USE CASES instance.
  di
    ..registerLazySingleton<ConvertDataFromCsvUseCase>(
      () => ConvertDataFromCsvUseCase(converterRepo: di.get<ConverterRepo>()),
    )
    ..registerLazySingleton<LoadProductUseCase>(
        () => LoadProductUseCase(productRepo: di.get<ProductRepo>()));

  // register BLOC.
  di
    ..registerLazySingleton<SplashBloc>(() => SplashBloc())
    ..registerLazySingleton<DashboardBloc>(() => DashboardBloc())
    ..registerLazySingleton<ProductBloc>(() => ProductBloc())
    ..registerLazySingleton<FilterBloc>(
        () => FilterBloc(productBloc: di.get<ProductBloc>()))
    ..registerLazySingleton<CartBloc>(() => CartBloc());
}
