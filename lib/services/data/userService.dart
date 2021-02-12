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
  void signup(UserToRegister user, BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    var toast = Toast();
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
              email: user.email,
              password: user.password,
            )
            .catchError(
              (errMsg) => {
                toast.errorNotification(
                  errMsg.toString(),
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
      userRef.child(firebaseUser.uid).set(user);
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
}
