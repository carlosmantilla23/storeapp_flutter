import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/login/presentation/pages/login_page.dart';
import 'package:storeapp/app/signup/presentation/pages/signup_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: "/",
      routes: [
        GoRoute(
          path: "/",
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: "/sign-up",
          builder: (context, state) => const SignUpPage(),
          name: "sign-up",
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

class TestStateful extends StatefulWidget {
  const TestStateful({super.key});

  @override
  State<TestStateful> createState() => TestStatefulState();
}

class TestStatefulState extends State<TestStateful> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
