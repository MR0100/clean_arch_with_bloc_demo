abstract class UseCase<T, Param> {
  Future<T> call({required Param param});
}
