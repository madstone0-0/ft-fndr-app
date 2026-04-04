import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ft_fndr_app/models/history_repo.dart';
import 'package:ft_fndr_app/models/search_repo.dart';
import 'package:ft_fndr_app/providers/AuthNotifier.dart';
import 'package:ft_fndr_app/services/ApiService.dart';
import 'package:ft_fndr_app/services/AuthService.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocatorService() async {
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage(aOptions: AndroidOptions()));

  final dio = Dio();

  final api = ApiService(dio);
  final authService = AuthService(api, getIt<FlutterSecureStorage>());
  final authNotifier = AuthNotifier(authService);
  dio.interceptors.add(AuthInterceptor(getIt<FlutterSecureStorage>(), authNotifier));
  getIt.registerSingleton<Dio>(dio);

  getIt.registerSingleton<AuthNotifier>(authNotifier);
  getIt.registerSingleton<ApiService>(api);
  getIt.registerSingleton(authService);

  getIt.registerLazySingleton(() => HistoryRepository(getIt<ApiService>()));
  getIt.registerLazySingleton(() => SearchRepository(getIt<ApiService>()));
}
