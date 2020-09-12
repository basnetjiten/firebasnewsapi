import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}
class InitialAuthState extends AuthState{}

class UserLoggedInState extends AuthState{
  final FirebaseUser user;
  UserLoggedInState({this.user});
}
class UserNotLoggedInState extends AuthState{}