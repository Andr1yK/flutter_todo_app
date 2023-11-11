abstract class UseCase<Type, Params> {
  Future<Type> call({required Params params});
}

abstract class StreamUseCase<Type, Params> {
  Stream<Type> call({required Params params});
}