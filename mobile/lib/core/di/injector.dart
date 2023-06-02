import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile/core/di/injector.config.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;


// This is a helper method to register all the models and services
@injectableInit
Future<void> configureDependencies() async {
  await Hive.initFlutter();

  // @todo: adapters for Hive
  getIt.init();
}
