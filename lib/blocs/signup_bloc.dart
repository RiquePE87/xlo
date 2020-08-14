import 'package:rxdart/rxdart.dart';

enum signUpState{IDLE, LOADING, ERROR}

class SignUpBlocState{

   signUpState state;
   String errorMessage;

   SignUpBlocState(this.state, {this.errorMessage});
}

class SignUpBloc{

  final BehaviorSubject<SignUpBlocState> _stateController =
  BehaviorSubject<SignUpBlocState>.seeded(SignUpBlocState(signUpState.IDLE));

  Stream<SignUpBlocState> get outState => _stateController.stream;

  void dispose(){
    _stateController.close();
  }
}