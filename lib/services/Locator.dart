import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ft_fndr_app/models/history_repo.dart';
import 'package:ft_fndr_app/providers/AuthNotifier.dart';
import 'package:ft_fndr_app/services/ApiService.dart';
import 'package:ft_fndr_app/services/AuthService.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocatorService() async {
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage(aOptions: AndroidOptions()));

  final dio = Dio();
  dio.interceptors.add(AuthInterceptor(getIt<FlutterSecureStorage>()));
  getIt.registerSingleton<Dio>(dio);

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton(() => AuthService(getIt<ApiService>(), getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => HistoryRepository(getIt<ApiService>()));
  getIt.registerSingleton<AuthNotifier>(AuthNotifier(getIt<AuthService>()));
}
