import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Pagina de Inicio",
              style: TextStyle(fontSize: 48.0),
            ),
            OutlinedButton(
              onPressed: () => context.go("/"),
              child: const Text("Ir al login"),
            ),
          ],
        ),
      ),
    );
  }
}
