import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/screen_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SwipeCard(),
    );
  }
}

class SwipeCard extends StatefulWidget {
  const SwipeCard({super.key});

  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  final List<SwipeItem> _swipeItems = [];
  MatchEngine? _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final List<String> _names = ['Red', 'Blue', 'Green', 'Orange'];
  final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
        content: Content(text: _names[i], color: _colors[i]),
        likeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Liked ${_names[i]}'),
          ));
        },
        nopeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Nope ${_names[i]}'),
            duration: const Duration(milliseconds: 500),
          ));
        },
        superlikeAction: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Superliked ${_names[i]}'),
            duration: const Duration(milliseconds: 500),
          ));
        },
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Animated Swipe Cards'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CodeViewScreen('Swipe Cards'),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor:
          Get.isDarkMode ? Colors.black : Colors.white,
      body: Column(
        children: [
          Container(
            height: 550,
            child: SwipeCards(
              matchEngine: _matchEngine!,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: _swipeItems[index].content.color,
                  child: Text(
                    _swipeItems[index].content.text!,
                    style: const TextStyle(fontSize: 100, color: Colors.white),
                  ),
                );
              },
              onStackFinished: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Finished'),
                  duration: Duration(milliseconds: 500),
                ));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  _matchEngine!.currentItem!.nope();
                },
                child: const Text(
                  'Nope',
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 5,
                color: Colors.red,
              ),
              MaterialButton(
                onPressed: () {
                  _matchEngine!.currentItem!.superLike();
                },
                child: const Text(
                  'Superlike',
                  style: TextStyle(color: Colors.black),
                ),
                elevation: 5,
                color: Colors.blue,
              ),
              MaterialButton(
                onPressed: () {
                  _matchEngine!.currentItem!.like();
                },
                child: const Text(
                  'Like',
                  style: TextStyle(color: Colors.white),
                ),
                elevation: 5,
                color: Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SwipeItem {
  final Content content;
  final VoidCallback likeAction;
  final VoidCallback nopeAction;
  final VoidCallback superlikeAction;

  SwipeItem({
    required this.content,
    required this.likeAction,
    required this.nopeAction,
    required this.superlikeAction,
  });
}

class MatchEngine {
  final List<SwipeItem> swipeItems;
  SwipeItem? currentItem;

  MatchEngine({required this.swipeItems}) {
    currentItem = swipeItems.isNotEmpty ? swipeItems[0] : null;
  }

  void cycleItems() {
    if (swipeItems.isNotEmpty) {
      swipeItems.add(swipeItems.removeAt(0));
      currentItem = swipeItems[0];
    }
  }
}

class Content {
  final String text;
  final Color color;

  Content({required this.text, required this.color});
}

class CodeViewScreen extends StatelessWidget {
  final String title;

  const CodeViewScreen(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('Code view screen'),
      ),
    );
  }
}
