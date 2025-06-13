import 'package:flutter/material.dart';
import 'screens/photos_master.dart'; 


class LikeItApp extends StatelessWidget {
  const LikeItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LikeIt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PhotosMaster(), // On met ici l'écran que tu as créé
    );
  }
}
