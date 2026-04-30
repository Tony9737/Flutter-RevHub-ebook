import 'package:flutter/material.dart';
import 'package:flutter_hw3_car_collection/audio_manager.dart';
import 'package:flutter_hw3_car_collection/show_room_page.dart';

/*
  這個專案的主題是汽車展示廳，會展示一些我在網路上看到的有趣的車輛，並且提供一些基本的資訊和圖片。
  目標是讓使用者能夠輕鬆地瀏覽和了解不同的車輛，並且提供一個有趣的體驗。
*/
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioManager.instance.startBgm();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tony\'s Showroom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'AppFont'
      ),
      home: const IntroPage(),
    );
  }
}

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            // 使用 pushReplacement 來替換當前頁面，避免返回到介紹頁面
            context,
            MaterialPageRoute(builder: (context) => const ShowRoomPage()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background/intro_background.png'),
              fit: BoxFit.cover,
            ),
          ),
          height: double.infinity,
        ),
      ),
    );
  }
}
