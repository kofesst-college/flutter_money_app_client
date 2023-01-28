import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';

part 'asset.g.dart';

@freezed
class Asset with _$Asset {
  const factory Asset({
    required int id,
    required String name,
    required double balance,
  }) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}
