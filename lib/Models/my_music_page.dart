import 'package:flutter/material.dart';

class MyMusic extends StatefulWidget {
  static const String id='MyMusic';
  const MyMusic({Key? key}) : super(key: key);

  @override
  State<MyMusic> createState() => _MyMusicState();
}

class _MyMusicState extends State<MyMusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Music'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBox(context, Icons.apple, 'Apple Music'),
              const SizedBox(width: 40.0),
              _buildBox(context, Icons.music_note, 'Spotify'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBox(BuildContext context, IconData iconData, String text) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/$text');
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      child: SizedBox(
        width: 120.0,
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 50.0),
            const SizedBox(height: 10.0),
            Text(text, style: const TextStyle(fontSize: 20.0)),
          ],
        ),
      ),
    );
  }
}
