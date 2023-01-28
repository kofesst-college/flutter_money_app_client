import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app_flutter/domain/models/common/user.dart';
import 'package:money_app_flutter/presentation/cubit/profile/profile_cubit.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          switch (state.profileStatus.runtimeType) {
            case LoadedStatus<User>:
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email: ${state.profileStatus.item!.email}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Имя пользователя: ${state.profileStatus.item!.userName}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/assets");
                        },
                        child: const Text(
                          'Счета',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/categories");
                        },
                        child: const Text(
                          'Категории',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/transactions");
                        },
                        child: const Text(
                          'Транзакции',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          AppModule.getPreferencesRepository()
                              .removeSavedApiToken()
                              .then((value) {
                            Navigator.of(context)
                                .pushReplacementNamed("/sign-in");
                          });
                        },
                        child: const Text(
                          'Выйти из профиля',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case FailedStatus<User>:
              return Center(
                child: Text(
                  state.profileStatus.message ?? "Неизвестная ошибка",
                ),
              );
            case IdleStatus<User>:
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await context.read<ProfileCubit>().loadProfile();
                    },
                    child: const Text('Sign in'),
                  ),
                ],
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
