enum LoginState {IDLE, LOADING, LOADING_FACE, ERROR, DONE}

class LoginBlocState{

  LoginState state;
  String error;

  LoginBlocState(this.state, {this.error});
}