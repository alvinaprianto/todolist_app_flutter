import 'package:get_it/get_it.dart';
import 'package:todolist_app_flutter/features/authentication/repositories/auth_repositories.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerFactory(() => AuthRepositories());
}
