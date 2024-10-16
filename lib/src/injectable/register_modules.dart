import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class AppModule {
  @Singleton(env: [Environment.prod, Environment.test])
  Talker getProdTalker() {
    return TalkerFlutter.init(
      filter: BaseTalkerFilter(types: []),
      settings: TalkerSettings(enabled: true),
    );
  }

  @preResolve
  @Singleton(env: [Environment.prod])
  Future<SharedPreferences> getProdSharedPreference() async {
    return await SharedPreferences.getInstance();
  }
}
