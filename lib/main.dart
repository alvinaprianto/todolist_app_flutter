import 'package:flutter/material.dart';
import 'package:todolist_app_flutter/core/config.dart';
import 'package:todolist_app_flutter/core/app_router.dart';
import 'package:todolist_app_flutter/core/constants.dart';
import 'package:todolist_app_flutter/features/introduction/screens/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todolist_app_flutter/firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app_flutter/injection_container.dart';
import 'features/authentication/cubit/authentication_cubit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setUp();
  await initializeDateFormatting("id_ID", null)
      .then((_) => runApp(const MyApp()));
  category1.value.toRadixString(16);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: AppRouter.onGenerateRoute,
        title: 'App ToDO',
        theme: Config.myTheme,
        home: SplashScreen(),
      ),
    );
  }
}
