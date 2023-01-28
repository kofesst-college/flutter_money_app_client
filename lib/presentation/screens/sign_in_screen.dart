import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app_flutter/presentation/cubit/auth/auth_cubit.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
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
              return SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                          final username = _usernameController.value.text;
                          final password = _passwordController.value.text;
                          context
                              .read<AuthCubit>()
                              .signIn(username: username, password: password)
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
                          'Войти в профиль',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 50),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed("/sign-up");
                        },
                        child: const Text(
                          'Уже есть профиль?',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
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
