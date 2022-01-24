import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:war/src/app.dart';

GlobalKey<NavigatorState> navigationApp = GlobalKey<NavigatorState>();

void main() async {
  await GetStorage.init();
  runApp(App());
}
