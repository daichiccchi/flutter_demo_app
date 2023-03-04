
class User {
  String name;
  String uid;
  String? imagePath; //null許容
  String lastMessage;
  // コンストラクタ
  User ({
    required this.name,
    required this.uid,
    this.imagePath,
    this.lastMessage = '',
  });
}