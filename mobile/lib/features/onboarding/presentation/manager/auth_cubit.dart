import 'package:bloc/bloc.dart';
import 'package:shared_utils/shared_utils.dart';

class AuthCubit extends Cubit<BlocState> {
  AuthCubit() : super(BlocState.initialState());

  Future<bool> get isLoggedIn async => false;
}
