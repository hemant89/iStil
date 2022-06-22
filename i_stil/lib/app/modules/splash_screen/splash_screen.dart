import 'package:flutter/material.dart';
import 'package:i_stil/app/const/color_const.dart';
import 'package:i_stil/app/modules/home_screen/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Permission.storage.request();

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "iStil",
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: KColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
