import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCGevkW-mZ3ZRxtMwW76XaI7ZNxI3dz42o",
            authDomain: "loginapp-4500a.firebaseapp.com",
            projectId: "loginapp-4500a",
            storageBucket: "loginapp-4500a.appspot.com",
            messagingSenderId: "1061678945651",
            appId: "1:1061678945651:web:cd39ed8154b206f15ca106",
            measurementId: "G-BRV0GQLZQW"));
  } else {
    await Firebase.initializeApp();
  }
}
