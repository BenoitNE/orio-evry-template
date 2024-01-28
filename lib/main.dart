import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orio_evry_template/screen/home_screen.dart';
import 'package:orio_evry_template/util/routing_util.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final RoutingUtil _routing = RoutingUtil();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: _routing.getRoutesApp(context),
      home: const HomeScreen(),
    );
  }
}
