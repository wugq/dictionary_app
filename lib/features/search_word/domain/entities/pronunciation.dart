import 'package:equatable/equatable.dart';

class Pronunciation extends Equatable {
  final String audio;
  final String text;

  const Pronunciation(this.audio, this.text);

  @override
  List<Object?> get props => [audio, text];
}
