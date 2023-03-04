import 'package:flutter/material.dart';

import '../model/message.dart';
import 'package:intl/intl.dart' as intl;

class TalkRoomPage extends StatefulWidget {
  // 遷移元の画面から値を受け取る準備
  final String name;

  const TalkRoomPage(this.name, {Key? key}) : super(key: key);

  @override
  State<TalkRoomPage> createState() => _TalkRoomPageState();
}

class _TalkRoomPageState extends State<TalkRoomPage> {
  List<Message> messageList = [
    Message(
      message: 'こんにちは',
      isMe: false,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: true,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: false,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'あああああああああああああああああああああああああああああああああああああああああああああああああああ',
      isMe: true,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: false,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: true,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: false,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'あああああああああああああああああああああああああああああああああああああああああああああああああああ',
      isMe: true,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: false,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: true,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: false,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'あああああああああああああああああああああああああああああああああああああああああああああああああああ',
      isMe: true,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: false,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: true,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'こんにちは',
      isMe: false,
      sendTime: DateTime.now(),
    ),
    Message(
      message: 'あああああああああああああああああああああああああああああああああああああああああああああああああああ',
      isMe: true,
      sendTime: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
          // StatefulWidgetクラス内で定義している変数を使う場合は変数名の前に「widget」を付ける。
          title: Text(widget.name)),
      body: Stack( // ListView.builderの上に要素を乗っける(下に追記すればするほど上に重なっていく)
        alignment:Alignment.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: ListView.builder(
                physics: const RangeMaintainingScrollPhysics(), // 画面幅を超えるような要素数になった時にスクロール可能
                shrinkWrap: true, // 現在表示している子要素に含まれるウィジェットのサイズにする
                reverse: true, //　逆スクロール
                itemCount: messageList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: index == 0 ? 8 : 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      textDirection: messageList[index].isMe ?
                      TextDirection.rtl : TextDirection.ltr,
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.6
                          ),
                          decoration: BoxDecoration(
                            color: messageList[index].isMe ? Colors.green : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                messageList[index].message
                            ),
                          ),
                        ),
                        Text(intl.DateFormat('HH:MM').format(messageList[index].sendTime)),
                      ],
                    ),
                  );
                }),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                height: 60,
                // コンテナの子要素にRowウィジェットを入れる場合はchildプロパティを使う。
                child: Row(
                  children: [
                    const Flexible(child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        decoration: InputDecoration(
                          // カーソルの位置を調整
                          contentPadding: EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        ),
                      ),
                    )),
                    IconButton(onPressed: () {

                    },
                        icon: const Icon(Icons.send))
                  ],

                ),
              ),
              Container(
                color: Colors.white,
                // ステータスバーのの高さに余白を適用
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
