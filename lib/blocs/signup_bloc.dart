import 'package:rxdart/rxdart.dart';
import 'package:xlo/models/user.dart';

enum signUpState { IDLE, LOADING, ERROR }

class SignUpBlocState {
  signUpState state;
  String errorMessage;

  SignUpBlocState(this.state, {this.errorMessage});
}

class SignUpBloc {
  final BehaviorSubject<SignUpBlocState> _stateController =
      BehaviorSubject<SignUpBlocState>.seeded(SignUpBlocState(signUpState.IDLE));

  Stream<SignUpBlocState> get outState => _stateController.stream;

  void SignUp() async {
    _stateController.add(SignUpBlocState(signUpState.LOADING));

    await Future.delayed(Duration(seconds: 3));

    _stateController.add(SignUpBlocState(signUpState.IDLE));
  }

  User user = User();

  void setName(String name) {
    user.name = name;
  }

  void setEmail(String email) {
    user.email = email.toLowerCase();
  }

  void setPassword(String password) {
    user.password = password;
  }

  void dispose() {
    _stateController.close();
  }
}
