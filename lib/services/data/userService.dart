import 'package:ahadu_uber/Screens/mainscreen.dart';
import 'package:ahadu_uber/models/usermodel.dart';
import 'package:ahadu_uber/services/notification/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class UserService {
  DatabaseReference userRef =
      FirebaseDatabase.instance.reference().child("users");

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signup(UserToSignup user, BuildContext context) async {
    var toast = Toast();
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
              email: user.email,
              password: user.password,
            )
            .catchError(
              (errMsg) => {
                toast.errorNotification(
                  errMsg.message,
                  context,
                ),
              },
            ))
        .user;

    if (firebaseUser != null) {
      // Map userDataMap = {
      //   "name": nameController.text.trim(),
      //   "email": emailController.text.trim(),
      //   "phone": phoneController.text.trim(),
      // };
      //userRef.child(firebaseUser.uid).set(user);
      Navigator.pushNamedAndRemoveUntil(
        context,
        MainScreen.idScreen,
        (route) => false,
      );
      toast.successNotification("Successful", context);
    } else {
      toast.errorNotification(
        "Something went wrong. Signup not successful",
        context,
      );
    }
  }

  void login(UserToLogin user, BuildContext context) async {
    var toast = Toast();
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
              email: user.email,
              password: user.password,
            )
            .catchError(
              (errMsg) => {
                toast.errorNotification(
                  errMsg.message,
                  context,
                ),
              },
            ))
        .user;

    if (firebaseUser != null) {
      // Map userDataMap = {
      //   "name": nameController.text.trim(),
      //   "email": emailController.text.trim(),
      //   "phone": phoneController.text.trim(),
      // };
      print(firebaseUser);
      userRef
          .child(firebaseUser.uid)
          .once()
          .then((value) => (DataSnapshot snap) {
                if (snap.value != null) {
                  print(snap);
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.idScreen, (route) => false);
                  toast.successNotification("Logged In Successfully", context);
                } else {
                  _firebaseAuth.signOut();
                  toast.errorNotification(
                      "User Doesn't exist. Try Again", context);
                }
              });
    } else {
      toast.errorNotification("Error Occured Try Again", context);
    }
  }
}
