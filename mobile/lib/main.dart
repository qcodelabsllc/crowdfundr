import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/core/di/injector.dart';
import 'package:shared_utils/shared_utils.dart';

import 'core/app.dart';

/// run the app in a zone to catch errors
void main() async => runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();

      // init dependencies here
      await configureDependencies();

      // run the app
      runApp(const CrowdfundrApp());
    }, (error, stack) => logger.e(error));
