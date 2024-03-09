import 'package:dartz/dartz.dart';
import 'package:todotask/core/error/failure.dart';

abstract class BaseUseCase<T , Parameter> {
  Future<Either<Failure , T>> call(Parameter parameter);
}