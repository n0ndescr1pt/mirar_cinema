import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mirar/src/injectable/init_injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  generateForDir: ['lib'],
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependency(String env) async =>
    await getIt.init(environment: env);
