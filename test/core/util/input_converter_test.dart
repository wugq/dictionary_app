import 'package:dictionary/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
      'should return an integer when the string represents an unsigned integer',
      () {
        const str = '123';
        final result = inputConverter.stringToUnsignedInteger(str);

        expect(result, const Right(123));
      },
    );
    test('should return a failure when the string is not an integer', () {
      const str = "123abc";
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a failure when the string is a negative integer', () {
      const str = "-123";
      final result = inputConverter.stringToUnsignedInteger(str);
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
