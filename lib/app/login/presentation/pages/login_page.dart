import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPassword = false;

  void togglePasswordVisibility() {
    setState(() {
      showPassword = true;
    });

    // Oculta la contraseña después de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showPassword = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const HeaderLoginWidget(),
                        const SizedBox(height: 20),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: "Correo electrónico",
                            prefixIcon: Icon(Icons.person),
                            hintText: "Escribe tu correo electrónico",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            prefixIcon: const Icon(Icons.lock),
                            hintText: "Escribe tu contraseña",
                            suffixIcon: GestureDetector(
                              onTap: togglePasswordVisibility,
                              child: Icon(
                                showPassword ? Icons.visibility : Icons.visibility_off,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            // TODO: INICIO DE SESION
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Iniciar Sesión", style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Divider(),
            const FooterLoginWidget(),
          ],
        ),
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Herbstlandschaft_%28am_Rebhang%29.jpg/800px-Herbstlandschaft_%28am_Rebhang%29.jpg",
          width: double.infinity,
          height: 120.0,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),
        const Text(
          "Iniciar Sesión",
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class FooterLoginWidget extends StatelessWidget {
  const FooterLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color buttonColor = Theme.of(context).primaryColor;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("¿Aún no tienes cuenta?"),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                context.go("/sign-up");
              },
              child: Text(
                "Regístrate",
                style: TextStyle(
                  color: buttonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
