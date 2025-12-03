import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medical_care/core/size_config.dart';
import 'package:medical_care/features/layout/view/layout_view.dart';
import 'package:medical_care/generated/l10n.dart';
=======
import 'signup/signup_view.dart';
>>>>>>> 76a4d9acb8678f1b244cfe9d9965c96dd3e2cc6a

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    SizeConfig.init(context);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('ar')],
      home: const LayoutView(),
=======
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const SignUpView(),
>>>>>>> 76a4d9acb8678f1b244cfe9d9965c96dd3e2cc6a
    );
  }
}
