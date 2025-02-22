import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:storeapp/app/login/presentation/bloc/login_bloc.dart';
import 'package:storeapp/app/login/presentation/bloc/login_events.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';

const String emailPattern =
    r"^(?:[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*|"
    r'"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\'
    r'[\x01-\x09\x0b\x0c\x0e-\x7f])*")@'
    r"(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z]{2,}|"
    r'\[(?:(?:25[0-5]|2[0-4]\d|[01]?\d\d?)(?:\.(?:25[0-5]|2[0-4]\d|[01]?\d\d?)){3})\])$';
final RegExp emailRegex = RegExp(emailPattern);

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(InitialState()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: const [
            HeaderLoginWidget(),
            Expanded(child: BodyLoginWidget()),
            FooterLoginWidget(),
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
    return SizedBox(
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Herbstlandschaft_%28am_Rebhang%29.jpg/800px-Herbstlandschaft_%28am_Rebhang%29.jpg",
            width: double.infinity,
            height: 100.0,
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

class BodyLoginWidget extends StatefulWidget {
  const BodyLoginWidget({super.key});

  @override
  State<BodyLoginWidget> createState() => _BodyLoginWidgetState();
}

class _BodyLoginWidgetState extends State<BodyLoginWidget> {
  bool _showPassword = false;
  Timer? _autoShowTimer;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _autoShowTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LoginBloc>();
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          GoRouter.of(context).pushReplacementNamed("home");
        } else if (state is LoginErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Error"),
              content: Text(state.message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          bool emailValid =
              state.model.email.isNotEmpty && emailRegex.hasMatch(state.model.email);
          bool passwordValid =
              state.model.password.replaceAll(" ", "").length >= 8;
          bool isValidForm = emailValid && passwordValid;

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.model.email),
                    TextFormField(
                      initialValue: state.model.email,
                      decoration: const InputDecoration(
                        labelText: "Correo electrónico",
                        prefixIcon: Icon(Icons.person),
                        hintText: "Escribe tu correo electrónico",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        bloc.add(EmailChangedEvent(email: value));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Campo obligatorio";
                        }
                        if (!emailRegex.hasMatch(value)) {
                          return "Correo inválido";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: state.model.password,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        labelText: "Contraseña",
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Escribe tu contraseña",
                        suffixIcon: InkWell(
                          onTap: () {
                            if (!_showPassword) {
                              _autoShowTimer?.cancel();
                              _autoShowTimer = Timer(const Duration(seconds: 3), () {
                                setState(() {
                                  _showPassword = false;
                                });
                              });
                            }
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(
                            _showPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) {
                        bloc.add(PasswordChangedEvent(password: value));
                      },
                      validator: (value) {
                        final trimmed = value?.replaceAll(" ", "") ?? "";
                        if (trimmed.length < 8) {
                          return "Contraseña inválida";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: isValidForm
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                bloc.add(SubmitEvent());
                              }
                            }
                          : null,
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
          );
        },
      ),
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
                GoRouter.of(context).pushNamed("sign-up");
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
