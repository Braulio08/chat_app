import '../widgets/auth/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final dynamic appBar = AppBar(
      title: const Text('ChatApp'),
      centerTitle: true,
    );
    return Scaffold(
      appBar: appBar,
      body: AuthForm(),
    );
  }
}
