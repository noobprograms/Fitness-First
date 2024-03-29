import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_app/providers/auth_provider.dart' as authP;

import 'package:flutter_fitness_app/utils/imageConstants.dart';
import 'package:flutter_fitness_app/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> curveAnimation;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    // var loginBool =
    //     Provider.of<AuthProvider>(context, listen: false).isLoggedIn;
    curveAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.bounceOut)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Provider.of<authP.AuthProvider>(context, listen: false)
                  .initAuthScreen(context, FirebaseAuth.instance.currentUser);
            }
          });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 35, 37, 46),
      body: Stack(
        children: [
          PositionedTransition(
            rect: RelativeRectTween(
                    begin: RelativeRect.fromLTRB(0, 0, 0, screenHeight / 6),
                    end: RelativeRect.fromLTRB(0, screenHeight / 7, 0, 0))
                .animate(curveAnimation),
            child: Center(child: Image.asset(ImageConstant.logo)),
          ),
        ],
      ),
    );
  }
}
