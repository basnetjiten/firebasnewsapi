import 'package:app/blocs/authentication_bloc/event.dart';
import 'package:app/blocs/authentication_bloc/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationBloc() : super(InitialAuthState());


  @override
  Stream<AuthState> mapEventToState(event) async* {
    if (event is CheckUserAuth) {

      final User currentUser =  FirebaseAuth.instance.currentUser as FirebaseUser;
      if (currentUser != null) {
        yield UserLoggedInState(user: currentUser);
      } else {
        yield UserNotLoggedInState();
      }
    }
  }
}
