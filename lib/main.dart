import 'package:flutter/widgets.dart';

import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/firebase_options.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();

  runApp(const App());
}
