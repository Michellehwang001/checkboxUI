import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> items = <String>['A', 'B', 'C'];
  final Set<int> checkedIndexes = {0, 2};
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('할 일 목록'),
        actions: [
          IconButton(icon: Icon(Icons.delete), onPressed: () {})
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8.0),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            //height: 50,
            child: Row(
              children: [
                Checkbox(
                  onChanged: (bool newValue) {
                    if(newValue == true) {
                      checkedIndexes.add(index);
                    } else {
                      checkedIndexes.remove(index);
                    }
                  },
                  value: checkedIndexes.contains(index),
                ),
                Text('Items ${items[index]}'),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _addTodo(context),
          child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodo(BuildContext context) {
    showDialog(context: context,
        builder: (_) => AlertDialog(
          title: Text('할일 입력하세요!'),
          content: TextField(
            controller: _textController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(onPressed: () {
              setState(() {
                items.add(_textController.text);
                _textController.clear();
              });
              Navigator.pop(context);
            }, child: Text('추가')),
          ],
        ));
  }
}
