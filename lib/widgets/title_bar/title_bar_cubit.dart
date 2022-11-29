import 'package:bloc/bloc.dart';

part 'title_bar_state.dart';

class TitleBarCubit extends Cubit<TitleBarInitial> {
  TitleBarCubit() : super(TitleBarInitial(true));

  void deactivate() {
    if (state.isBackButtonActive == false) return;
    emit(TitleBarInitial(false));
  }

  void activate() {
    if (state.isBackButtonActive) return;
    emit(TitleBarInitial(true));
  }
}
