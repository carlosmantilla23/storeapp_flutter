import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/app/login/domain/use_case/login_use_case.dart';
import 'package:storeapp/app/login/presentation/bloc/login_events.dart';
import 'package:storeapp/app/login/presentation/bloc/login_state.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late final LoginUseCase _loginUseCase;

  LoginBloc(super.initialState) {
    on<EmailChangedEvent>(_emailChangedEvent);
    on<PasswordChangedEvent>(_passwordChangedEvent);
    on<SubmitEvent>(_submitEvent);

    _loginUseCase = LoginUseCase();
  }

  void _emailChangedEvent(EmailChangedEvent event, Emitter<LoginState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(email: event.email),
    );

    emit(newState);
  }

  void _passwordChangedEvent(
      PasswordChangedEvent event, Emitter<LoginState> emit) {
    final newState = DataUpdateState(
      model: state.model.copyWith(password: event.password),
    );

    emit(newState);
  }

  void _submitEvent(SubmitEvent event, Emitter<LoginState> emit) {
    final bool result = _loginUseCase.invoke((state.model));

    late final LoginState newState;

    if (result) {
      newState = LoginSuccessState(model: state.model);
    } else {
      newState =
          LoginErrorState(model: state.model, message: "Error al Iniciar");
    }
    emit(newState);
  }
}
