import 'package:flutter/material.dart';
import 'package:projeto_ge2/page/todo_list.dart';
import 'package:projeto_ge2/page/todo_list_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int ontapNavigatorBar = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'assets/imagens/logo.jpeg',
                fit: BoxFit.cover,
              )
            ],
          ),
          const TodoList(),
          Container(),
          const TodoConfig()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.blueGrey,
        currentIndex: ontapNavigatorBar,
        onTap: (
          int index,
        ) {
          setState(() {
            ontapNavigatorBar = index;
          });
          _pageController.animateToPage(index,
              curve: Curves.bounceOut,
              duration: const Duration(milliseconds: 500));
        },
        backgroundColor: Colors.blueAccent,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.house),
          ),
          BottomNavigationBarItem(
            label: 'Agenda',
            icon: Icon(Icons.assignment),
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(Icons.mark_unread_chat_alt_outlined),
          ),
          BottomNavigationBarItem(
              label: 'Configuração', icon: Icon(Icons.settings))
        ],
      ),
    );
  }
}
