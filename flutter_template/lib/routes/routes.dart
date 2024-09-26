// ignore_for_file: library_private_types_in_public_api, overridden_fields

class Routes {
  static final _Auth auth = _Auth();
}

class _Auth extends RouteClass {
  @override
  String module = '/auth';
  String intro = '/';
}

abstract class RouteClass {
  String module = '/';

  String getRoute(String moduleRoute) => module + moduleRoute;

  String getModule() => '$module/';
}
