import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgk/core/utils/constants/app_consts.dart';
import 'package:kgk/core/utils/injections.dart';
import 'package:kgk/shared/domain/model/converter/converter_request_model.dart';
import 'package:kgk/shared/domain/usecases/convert_data_from_csv_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitState()) {
    on<OnSplashInit>(_onSplashInit);
  }

  Future<void> _onSplashInit(
      OnSplashInit event, Emitter<SplashState> emit) async {
    await Future.delayed(Duration(seconds: 3));

    await di.get<ConvertDataFromCsvUseCase>()(
        param: ConverterRequestModel(filePath: AppConsts.dataCsvFilePath));

    emit(SplashNavigate());
  }
}
