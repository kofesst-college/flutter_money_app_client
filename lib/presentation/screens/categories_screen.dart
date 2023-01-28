import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_app_flutter/domain/models/common/category.dart';
import 'package:money_app_flutter/presentation/cubit/categories/categories_cubit.dart';
import 'package:money_app_flutter/presentation/utils/loading_status.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit()..load(),
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          switch (state.status.runtimeType) {
            case LoadedStatus<List<Category>>:
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
                          "Категория №${item.id}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            case FailedStatus<List<Category>>:
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
