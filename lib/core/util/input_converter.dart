import '../error/failure.dart';

import 'package:dartz/dartz.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    try {
      int num = int.parse(str);
      if (num < 0) {
        return Left(InvalidInputFailure());
      }
      return Right(num);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
