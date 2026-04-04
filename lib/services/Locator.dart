import 'package:dio/dio.dart';
import 'package:ft_fndr_app/services/ApiService.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> setupLocatorService() async {
  getIt.registerSingleton<Dio>(Dio());
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
}
