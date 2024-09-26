import 'package:rxdart/rxdart.dart';

class AppConfig {
  AppConfig() {
    _configStream.add(Config());
  }
  final BehaviorSubject<Config> _configStream = BehaviorSubject<Config>();

  Config get config => _configStream.value;

  set setConfig(Config config) => _configStream.add(config);
}

class Config {
  const Config();
}
