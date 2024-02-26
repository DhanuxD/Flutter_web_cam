import 'package:flutter/material.dart';
import 'package:flutter_web_cam/screens/camera_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WebCam(),
              ),
            );
          },
          child: const Text(
            'Open Camera',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ),
    );
  }
}
