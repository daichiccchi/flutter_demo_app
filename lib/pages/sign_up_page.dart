import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo_app/firestore/user_firestore.dart';
import 'package:flutter_demo_app/pages/login_page.dart';
import 'package:flutter_demo_app/pages/top_page.dart';
import 'package:flutter_demo_app/validators/validators.dart';

import '../handler/firebase_auth_handler.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final nameInputController = TextEditingController();
  final emailInputController = TextEditingController();
  final pwdInputController = TextEditingController();

  var acs = ActionCodeSettings(
      url: 'https://www.example.com/finishSignUp?cartId=1234',
      // This must be true
      handleCodeInApp: true,
      iOSBundleId: 'com.example.ios',
      androidPackageName: 'com.example.android',
      // installIfNotAvailable
      androidInstallApp: true,
      // minimumVersion
      androidMinimumVersion: '12');
  @override
  initState() {
    // TextEditingControllerによってフォームの入力を管理
    var nameInputController = new TextEditingController();
    var emailInputController = new TextEditingController();
    var pwdInputController = new TextEditingController();
    super.initState();
  }

  bool _hasError = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント登録'),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _signUpFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // エラーハンドリングによるメッセージを表示
                  FirebaseAuthExceptionHandler.showErrorMessage(_hasError, _errorMessage),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'お名前'),
                    controller: nameInputController,
                    validator: nameValidator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    keyboardType: TextInputType.emailAddress,
                    controller: emailInputController,
                    validator: emailValidator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'パスワード'),
                    controller: pwdInputController,
                    obscureText: true,
                    validator: passwordValidator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      child: const Text('新規登録'),
                      onPressed: () => {
                        if (_signUpFormKey.currentState!.validate())
                          {
                            FirebaseAuth.instance
                                // firebase_authにユーザーを登録
                                .createUserWithEmailAndPassword(
                                    email: emailInputController.text,
                                    password: pwdInputController.text)
                                .then((newUser) => {
                                      // firestoreのユーザーコレクションに追加
                                      UserFirestore.createUser(
                                          nameInputController.text,
                                          emailInputController.text,
                                          pwdInputController.text)
                                    })
                                .then((result) => {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TopPage()),
                                          (_) => false),
                                    })
                                // ignore: invalid_return_type_for_catch_error
                                .catchError((e) => {
                                      setState(() => _hasError = true),
                                      setState(() => _errorMessage =
                                          FirebaseAuthExceptionHandler
                                              .exceptionMessage(
                                                  FirebaseAuthExceptionHandler
                                                      .handleException(e)))
                                    }),
                                  
                          }
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: InkWell(
                        child: const Text(
                          'ログインはこちら',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 16),
                        ),
                        onTap: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const LoginPage(),
                            ),
                          );
                        }),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
