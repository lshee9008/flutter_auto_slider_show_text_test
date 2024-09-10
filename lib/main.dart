import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextSliderExample(),
    );
  }
}

class TextSliderExample extends StatefulWidget {
  @override
  _TextSliderExampleState createState() => _TextSliderExampleState();
}

class _TextSliderExampleState extends State<TextSliderExample> {
  int _currentIndex = 0;
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
    _startSliding();
  }

  Future<void> _startSliding() async {
    while (true) {
      await Future.delayed(Duration(seconds: 3), () {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _textList.length;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auto Sliding Text"),
      ),
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 1), // 아래에서 시작
                end: Offset(0, 0), // 제자리에서 끝
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Text(
            _textList[_currentIndex],
            key: ValueKey<String>(_textList[_currentIndex]),
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}






// import 'dart:async';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SliderExample(),
//     );
//   }
// }

// class SliderExample extends StatefulWidget {
//   @override
//   _SliderExampleState createState() => _SliderExampleState();
// }

// class _SliderExampleState extends State<SliderExample> {
//   late PageController _pageController;
//   int _currentPage = 0;
//   Timer? _timer;

//   final List<String> _textList = [
//     "Text 1",
//     "Text 2",
//     "Text 3",
//     "Text 4",
//     "Text 5",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: 0);

//     _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
//       if (_currentPage < _textList.length) {
//         _currentPage++;
//         _pageController.animateToPage(
//           _currentPage,
//           duration: Duration(milliseconds: 300),
//           curve: Curves.easeIn,
//         );
//       }
//     });

//     _pageController.addListener(() {
//       if (_pageController.page == _textList.length.toDouble()) {
//         // 가상 페이지(마지막 페이지 이후의 페이지)에 도달했을 때
//         setState(() {
//           _currentPage = 0;
//         });
//         _pageController.jumpToPage(0);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Auto Sliding Text List"),
//       ),
//       body: PageView.builder(
//         controller: _pageController,
//         itemCount: _textList.length + 1, // 가상 페이지를 위해 +1
//         itemBuilder: (context, index) {
//           if (index == _textList.length) {
//             // 마지막 가상 페이지 처리
//             return Center(
//               child: Text(
//                 _textList[0], // 첫 번째 페이지의 텍스트를 표시
//                 style: TextStyle(fontSize: 24),
//               ),
//             );
//           }
//           return Center(
//             child: Text(
//               _textList[index],
//               style: TextStyle(fontSize: 24),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
