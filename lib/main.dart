import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Pages/splash_page.dart';
import 'package:to_do_app/Provider/quoteprovider.dart';
import 'package:to_do_app/Provider/taskprovider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => QuoteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      home: const SplashScreen(),
    );
  }
}
