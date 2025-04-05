import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';


void main () async{
  await Hive.initFlutter();
  var box =await Hive.openBox('test');



  runApp(CupertinoApp(
    debugShowCheckedModeBanner: false,

    home: MyApp(),));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List <dynamic> todoList = [];
  TextEditingController _addTask = TextEditingController();
  var box = Hive.box('test');
  @override
  void initState() {

    try {
      todoList = box.get('todo');
      print(todoList);
    }catch (e) {
      todoList = [];
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text ('Task', style: TextStyle(color: CupertinoColors.systemYellow),)
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
          Row(
            children: [
              Text('ToDo', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30)),
            ],
          ),

                 Expanded(child: ListView.builder(
                     itemCount: todoList.length,
                     itemBuilder: (context, int index){
                       final item= todoList;
                      return GestureDetector(
                        onLongPress: (){
                          showCupertinoDialog(context: context, builder: (context){
                            return CupertinoAlertDialog(
                              title: Text('Delete'),
                              content: Text ('Remove ${item[index]['task']} ?'),
                              actions: [
                                CupertinoButton(child: Text ('Yes', style: TextStyle(color: CupertinoColors.destructiveRed),), onPressed: (){
                                    setState(() {
                                      item.removeAt(index);
                                      box.put('todo', item);
                                    });
                                  Navigator.pop(context);
                                }),
        ),
      ),
    );
  }
}