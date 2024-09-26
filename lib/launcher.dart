import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tokoonline/constans.dart'; // Ensure Palette is defined here
import 'package:tokoonline/users/landingpage.dart' as users;

class LauncherPage extends StatefulWidget {
  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    startLaunching(); // Call startLaunching() in initState
  }

  startLaunching() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return users.LandingPage(); // Use the correct class name
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Toko Online'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: const Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Palette.bg1, Palette.bg2], // Updated with your Palette colors
          ),
        ),
        child: Center(
          child: Image.asset(
            "assets/logo2.png", // Ensure the logo path is correct
            height: 100.0,
            width: 280.0,
          ),
        ),
      ),
    );
  }
}
