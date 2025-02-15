import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0), 
        child: Container(
          margin: EdgeInsets.only(right: 32.0, left: 32.0, top: 70.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const HeaderLoginWidget(),
              const SizedBox(height: 20), 
              const TextField(
                decoration: InputDecoration(labelText: "Correo electrónico", prefixIcon: Icon(Icons.person), hintText: "Escribe tu correo electrónico"),keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Contraseña", prefixIcon: Icon(Icons.lock), hintText: "Escribe tu contraseña"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Iniciar Sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Herbstlandschaft_%28am_Rebhang%29.jpg/800px-Herbstlandschaft_%28am_Rebhang%29.jpg",
            width: double.infinity,
            height: 120.0,
            fit: BoxFit.cover,
          ),
          const Text(
            "Iniciar Sesión",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
