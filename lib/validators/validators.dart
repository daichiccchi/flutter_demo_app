import 'package:form_field_validator/form_field_validator.dart';

final nameValidator = MultiValidator([
  RequiredValidator(errorText: '名前を入力してください'),
]);

final emailValidator = MultiValidator([
  RequiredValidator(errorText: 'メールアドレスを入力してください'),
  PatternValidator(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
      errorText: '正しいEmailのフォーマットで入力してください')
]);

final passwordValidator = MultiValidator([
  RequiredValidator(errorText: 'パスワードを入力してください'),
  PatternValidator(
    r'^[a-zA-Z0-9]{6,}$', 
    errorText: '6文字以上の半角英数字で入力してください'
  )
]);
