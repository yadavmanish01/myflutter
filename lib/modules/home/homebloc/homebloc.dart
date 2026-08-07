import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutter/modules/home/homebloc/homeEvent.dart';
import 'package:myflutter/modules/home/homebloc/homestate.dart';

class Homebloc extends Bloc<Homeevent,Homestate>{
  Homebloc():super(Homestate()){
    on<ThemeSwitchEvent>(_isThemeswitch);
    on<LogoutEvent>(_islogout);}

  void _isThemeswitch(ThemeSwitchEvent event,Emitter<Homestate> emit){
  emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  //islogout

void _islogout(LogoutEvent event,Emitter<Homestate> emit){}
}
