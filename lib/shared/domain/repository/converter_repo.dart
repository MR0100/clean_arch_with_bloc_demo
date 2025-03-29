import 'package:kgk/core/utils/constants/app_types.dart';
import 'package:kgk/shared/domain/model/converter/converter_request_model.dart';

abstract class ConverterRepo {
  Future<List<Json>> convertCSVToJson({required ConverterRequestModel model});
}
