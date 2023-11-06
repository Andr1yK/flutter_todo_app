import 'package:firebase_database/firebase_database.dart';
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

  // FirebaseDatabase.instance.setPersistenceEnabled(true);
  // FirebaseDatabase.instance.ref().keepSynced(true);

  runApp(const App());
}
