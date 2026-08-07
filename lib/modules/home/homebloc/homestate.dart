import 'package:equatable/equatable.dart';

class Homestate extends Equatable {
  final bool isSwitch;
  Homestate({this.isSwitch=false});

  Homestate copyWith({bool? isSwitch}) {
    return Homestate(
      isSwitch: isSwitch??this.isSwitch
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isSwitch];
}
