import 'package:flutter/material.dart';

import '../../presentation/pages/login_page.dart';
import '../../presentation/pages/register_page.dart';

class ToggleWidget extends StatefulWidget {
  const ToggleWidget({super.key});

  @override
  State<ToggleWidget> createState() => _ToggleWidgetState();
}

class _ToggleWidgetState extends State<ToggleWidget> {
  bool showLogin = true;

  void toggle() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(onTap: toggle);
    } else {
      return RegisterPage(onTap: toggle);
    }
  }
}
