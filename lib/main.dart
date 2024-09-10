import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SliderExample(),
    );
  }
}

class SliderExample extends StatefulWidget {
  @override
  _SliderExampleState createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<String> _textList = [
    "Text 1",
    "Text 2",
    "Text 3",
    "Text 4",
    "Text 5",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);

    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _textList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto Sliding Text List"),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: _textList.length,
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              _textList[index],
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),
    );
  }
}
