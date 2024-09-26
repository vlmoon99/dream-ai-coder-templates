import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void binds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      "/",
      child: (context) => Scaffold(
        body: Center(
          child: Text("Hello World"),
        ),
      ),
    );
  }
}
