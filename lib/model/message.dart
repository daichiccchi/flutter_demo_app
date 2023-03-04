class Message {
  String message; // 本文
  bool isMe; // 自分が送ったメッセージか
  DateTime sendTime; // 送信日時
  // コンストラクタ
  Message({
    required this.message,
    required this.isMe,
    required this.sendTime,
  });
}