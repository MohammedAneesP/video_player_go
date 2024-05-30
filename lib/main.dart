import 'package:flutter/material.dart';
import 'package:go_video_player/presentation/screens/splash_screen.dart';
import 'package:go_video_player/provider/video_provider.dart';
import 'package:provider/provider.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VideoProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
    // );
  }
}
