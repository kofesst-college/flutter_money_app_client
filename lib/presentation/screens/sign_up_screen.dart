import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app_flutter/presentation/cubit/auth/auth_cubit.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  static final _emailRegex = RegExp(
    r"^[a-zA-Z\d.a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+",
  );

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          switch (state.tokenStatus.runtimeType) {
            case IdleStatus<String>:
            case FailedStatus<String>:
              return Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value?.trim().isEmpty != false) {
                          return "Это обязательное поле";
                        }
                        if (!_emailRegex.hasMatch(value!)) {
                          return "Некорректный email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Имя пользователя',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value?.trim().isNotEmpty == true) {
                          return null;
                        }
                        return "Это обязательное поле";
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Пароль',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value?.trim().isNotEmpty == true) {
                          return null;
                        }
                        return "Это обязательное поле";
                      },
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() != true) {
                          return;
                        }
                        final email = _emailController.value.text;
                        final username = _usernameController.value.text;
                        final password = _passwordController.value.text;
                        context
                            .read<AuthCubit>()
                            .signUp(
                              email: email,
                              username: username,
                              password: password,
                            )
                            .then(
                          (error) {
                            if (error == null) {
                              Navigator.pushReplacementNamed(
                                context,
                                "/profile",
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                ),
                              );
                            }
                          },
                        );
                      },
                      child: const Text(
                        'Зарегистрироваться',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed("/sign-in");
                      },
                      child: const Text(
                        'Ещё нет профиля?',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              );
            default:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
