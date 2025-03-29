import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/shared/data/source/local/converter_api.dart';
import 'package:kgk/shared/domain/model/converter/converter_request_model.dart';
import 'package:kgk/shared/domain/repository/converter_repo.dart';

class ConverterRepoImpl extends ConverterRepo {
  final ConverterAPI converterAPI;

  ConverterRepoImpl({required this.converterAPI});
  @override
  Future<List<Json>> convertCSVToJson(
      {required ConverterRequestModel model}) async {
    return await converterAPI.convert(filePath: model.filePath);
  }
}
