import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app_flutter/domain/models/common/asset.dart';
import 'package:money_app_flutter/domain/models/common/user.dart';
import 'package:money_app_flutter/presentation/cubit/assets/assets_cubit.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetsCubit()..load(),
      child: BlocBuilder<AssetsCubit, AssetsState>(
        builder: (context, state) {
          switch (state.status.runtimeType) {
            case LoadedStatus<List<Asset>>:
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.status.item!.length,
                itemBuilder: (context, index) {
                  final item = state.status.item![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Баланс: ${item.balance}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            case FailedStatus<List<Asset>>:
              return Center(
                child: Text(
                  state.status.message ?? "Неизвестная ошибка",
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
