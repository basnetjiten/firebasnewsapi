import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}

class CheckUserAuth extends AuthEvent {
  final FirebaseAuth auth;

  CheckUserAuth(this.auth);
}
