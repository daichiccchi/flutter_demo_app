import 'package:flutter/material.dart';
import 'package:flutter_demo_app/pages/sign_up_page.dart';
import 'package:flutter_demo_app/pages/top_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_demo_app/firestore/user_firestore.dart';
import 'package:flutter_demo_app/validators/validators.dart';
import '../handler/firebase_auth_handler.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // フォームを一意に管理するためのキーを定義する
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final emailInputController = TextEditingController();
  final pwdInputController = TextEditingController();
  @override
  initState() {
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
        title: const Text('ログイン'),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // エラーハンドリングによるメッセージを表示
                  FirebaseAuthExceptionHandler.showErrorMessage(_hasError, _errorMessage),
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
                    validator: passwordValidator,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        child: const Text('ログイン'),
                        onPressed: () => {
                          if (_loginFormKey.currentState!.validate())
                            {
                              // firebaseAuthで認証
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailInputController.text,
                                      password: pwdInputController.text)
                                  .then((currentUser) =>
                                      // firestore内にデータが存在するか確認
                                      UserFirestore.userCollection
                                          .where('email',
                                              isEqualTo:
                                                  currentUser.user!.email)
                                          .where('password',
                                              isEqualTo: currentUser
                                                  .additionalUserInfo!
                                                  .providerId)
                                          .get()
                                          .then((result) => {
                                                !result.docs.isEmpty
                                                    ? Navigator.pushAndRemoveUntil(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const TopPage()),
                                                        (_) => false)
                                                    : setState(
                                                        () => _hasError = true),
                                                setState(() => _errorMessage =
                                                    FirebaseAuthExceptionHandler
                                                        .exceptionMessage(
                                                            FirebaseAuthResultStatus
                                                                .UserNotFound))
                                              })
                                          .catchError((e) => {
                                                setState(
                                                    () => _hasError = true),
                                                setState(() => _errorMessage =
                                                    FirebaseAuthExceptionHandler
                                                        .exceptionMessage(
                                                            FirebaseAuthExceptionHandler
                                                                .handleException(
                                                                    e)))
                                              }))
                                  .catchError((e) => {
                                        setState(() => _hasError = true),
                                        setState(() => _errorMessage =
                                            FirebaseAuthExceptionHandler
                                                .exceptionMessage(
                                                    FirebaseAuthExceptionHandler
                                                        .handleException(e)))
                                      })
                            }
                        },
                      )),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: InkWell(
                        child: const Text(
                          'アカウントをお持ちでない方はこちら',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const SignUpPage(),
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
