import 'package:kgk/core/utils/usecases/usecase.dart';
import 'package:kgk/core/utils/constants/app_data.dart';
import 'package:kgk/shared/domain/model/converter/converter_request_model.dart';
import 'package:kgk/shared/domain/repository/converter_repo.dart';

class ConvertDataFromCsvUseCase extends UseCase<void, ConverterRequestModel> {
  final ConverterRepo converterRepo;

  ConvertDataFromCsvUseCase({required this.converterRepo});

  @override
  Future<void> call({required ConverterRequestModel param}) async {
    AppData.productData = await converterRepo.convertCSVToJson(model: param);
  }
}
