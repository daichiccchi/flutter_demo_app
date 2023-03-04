import 'package:flutter/material.dart';
import 'package:flutter_demo_app/pages/talk_room_page.dart';
import '../model/user.dart';
import 'setting_profile_page.dart';

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<User> userList = [
    User(
      name: '田中',
      uid: '1',
      imagePath:
          'https://thumb.ac-illust.com/eb/eb9f2bf93d3c0c063a5951e925d305ed_t.jpeg',
      lastMessage: 'こんにちは',
    ),
    User(
      name: '佐藤',
      uid: '2',
      imagePath:
          'https://thumb.ac-illust.com/7c/7cc54d8e3b2d75c6491ce4062ab3fca6_t.jpeg',
      lastMessage: '元気ですか',
    ),
    User(
      name: '鈴木',
      uid: '2',
      imagePath: null,
      lastMessage: '',
    )
  ];
  String noImage =
      'https://thumb.ac-illust.com/73/7387030e5a5600726e5309496353969a_t.jpeg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('demo app'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
                icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingProfilePage(),
                    )
                );
              },
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: userList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TalkRoomPage(userList[index].name),
                    ),
                  );
                },
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userList[index].imagePath ?? noImage,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(userList[index].name,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                            userList[index].lastMessage != ''
                            ? userList[index].lastMessage : 'メッセージはありません',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
