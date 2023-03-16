import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestore {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final userCollection = firestore.collection('user');
  // ユーザーを作成する処理
  static Future<void> createUser(name, email, password) async {
    try {
      // ユーザーコレクションに追加するメソッド
      userCollection.add({'name': name, 'email': email, 'password': password});
      print('アカウント作成完了');
    } catch (e) {
      print(e);
    }
  }

  static Future<void> getLoginUser(email, password) async {
    try {
      var user = userCollection
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();
    } catch (e) {
      print('DBアクセスエラー');
    }
  }
}
