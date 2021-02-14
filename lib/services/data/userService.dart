import 'package:ahadu_uber/Screens/mainscreen.dart';
import 'package:ahadu_uber/models/usermodel.dart';
import 'package:ahadu_uber/services/notification/toast.dart';
import 'package:ahadu_uber/widgets/progressDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UserService {
  DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child("users");
  Toast toast = Toast();

  void signup(UserToSignup user, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Signing Up",
          );
        });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      toast.successNotification("Signup Successful", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      toast.errorNotification(e.code, context);
    } catch (e) {
      Navigator.pop(context);
      toast.errorNotification(e, context);
    }
  }

  void login(UserToLogin user, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Loging In",
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      toast.successNotification("Login Succeful", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      toast.errorNotification(e.code, context);
    } catch (e) {
      Navigator.pop(context);
      toast.errorNotification(e, context);
    }
  }
}
