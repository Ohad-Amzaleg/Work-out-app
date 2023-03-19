import 'package:flutter/material.dart';

class MyFood extends StatefulWidget {
  static const String id='MyFood';
  const MyFood({Key? key}) : super(key: key);

  @override
  State<MyFood> createState() => _MyFoodState();
}

class _MyFoodState extends State<MyFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Food'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBox(context, Icons.photo_camera, 'Add Food'),
              const SizedBox(width: 40.0),
              _buildBox(context, Icons.list, 'Calories Tracker'),
            ],
          ),
          const SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBox(context, Icons.food_bank_sharp, 'Recipes'),
                const SizedBox(width: 220.0),
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
