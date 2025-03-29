import 'package:kgk/core/utils/constants/app_types.dart';

abstract class ConverterAPI {
  Future<List<Json>> convert({required String filePath});
}
