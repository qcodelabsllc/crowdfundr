import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_utils/shared_utils.dart';

import 'core/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init dependencies here

  runZonedGuarded(
      () => runApp(const CrowdfundrApp()), (error, stack) => logger.e(error));
}
