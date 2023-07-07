import 'package:hospitals_app/src/core/gps/gps_bloc.dart';
import 'package:hospitals_app/src/core/utils/security_storage.dart';
import 'package:hospitals_app/src/data/datasource/login/local/local_remote_data_source.dart';
import 'package:hospitals_app/src/data/datasource/login/remote/login_remote_data_source.dart';
import 'package:hospitals_app/src/domain/usecases/login/login_use_cases.dart';
import 'package:hospitals_app/src/domain/usecases/register/register_use_cases.dart';
import 'package:hospitals_app/src/presentation/login/bloc/login_bloc.dart';
import 'package:hospitals_app/src/presentation/register/bloc/register_bloc.dart';
import 'package:hospitals_app/src/presentation/splash/bloc/splash_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:hospitals_app/src/domain/repositories/home/home_repositories.dart';
import 'package:hospitals_app/src/domain/usecases/home/home_usecases.dart';
import 'package:hospitals_app/src/presentation/home/bloc/home_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'src/core/network/network_info.dart';
import 'src/data/datasource/home/local/home_local_data_source.dart';
import 'src/data/datasource/home/remote/home_remote_data_source.dart';
import 'src/data/datasource/register/remote/register_remote_data_source.dart';
import 'src/data/datasource/splash/local/splash_local_data_source.dart';
import 'src/data/repository/home/home_repository_impl.dart';
import 'src/data/repository/login/login_repository.dart';
import 'src/data/repository/register/register_repository.dart';
import 'src/data/repository/splash/splash_repository.dart';
import 'src/domain/repositories/login/login_repositories.dart';
import 'src/domain/repositories/register/register_repositories.dart';
import 'src/domain/repositories/splash/splash_repositories.dart';
import 'src/domain/usecases/splash/splash_usecases.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await initBookDetail();
}

Future<void> initBookDetail() async {
  
  //! External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
    connectionChecker: sl<InternetConnectionChecker>()
   )
  );
  sl.registerLazySingleton(() => SecurityStorage());

  // Remote data sources
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<RegisterRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(client: sl()),
  );

  // Local data sources
  sl.registerLazySingleton<HomeLocalDataSource>(
   () => HomeLocalDataSourceImpl(
    securityStorage: sl<SecurityStorage>()
   ),
  );
  sl.registerLazySingleton<LoginLocalDataSource>(
    () => LoginLocalDataSourceImpl(
     securityStorage: sl<SecurityStorage>()
    ),
  );
  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(
     securityStorage: sl<SecurityStorage>()
    ),
  );

  // Repository
  sl.registerLazySingleton<HomeRepositories>(
    () => HomeRepositoryImpl(
      localDataSource: sl<HomeLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      remoteDataSource: sl<HomeRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<RegisterRepositories>(
    () => RegisterRepositoryImpl(
      networkInfo: sl<NetworkInfo>(),
      remoteDataSource: sl<RegisterRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<LoginRepositories>(
    () => LoginRepositoryImpl(
      localDataSource: sl<LoginLocalDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      remoteDataSource: sl<LoginRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<SplashRepositories>(
    () => SplashRepositoryImpl(
      localDataSource: sl<SplashLocalDataSource>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => HomeUseCases(homeRepositories: sl<HomeRepositories>()));
  sl.registerLazySingleton(() => RegisterUseCases(registerRepositories: sl<RegisterRepositories>()));
  sl.registerLazySingleton(() => LoginUseCases(loginRepositories: sl<LoginRepositories>()));
  sl.registerLazySingleton(() => SplashUseCases(splashRepositories: sl<SplashRepositories>()));

  // Bloc
  sl.registerFactory(() => HomeBloc(useCases: sl<HomeUseCases>()));
  sl.registerFactory(() => RegisterBloc(useCases: sl<RegisterUseCases>()));
  sl.registerFactory(() => LoginBloc(useCases: sl<LoginUseCases>()));
  sl.registerLazySingleton(() => SplashBloc(useCases: sl<SplashUseCases>()));
  sl.registerLazySingleton(() => GpsBloc());



}