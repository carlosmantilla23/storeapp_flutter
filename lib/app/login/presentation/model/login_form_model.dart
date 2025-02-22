import 'package:storeapp/app/login/domain/entity/login_entity.dart';

class LoginFormModel {
  final String email;
  final String password;

  LoginFormModel({required this.email, required this.password});

  LoginFormModel copyWith({String? email, String? password}) {
    return LoginFormModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  LoginEntity toEntity() {
    return LoginEntity(email: email, password: password);
  }
}

