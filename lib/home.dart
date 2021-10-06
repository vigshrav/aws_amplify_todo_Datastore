import 'dart:async';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:aws_amplify_todo/DB.dart';
import 'package:aws_amplify_todo/amplifyconfiguration.dart';
import 'package:aws_amplify_todo/models/ModelProvider.dart';
import 'package:aws_amplify_todo/models/ToDoList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late StreamSubscription _subscription;
  List _todos = [];
  String _todoTitle = '';
  String errTXT = '';
  final fieldText = TextEditingController();
  late FocusNode focusnode;

  @override
  void initState() {
    _todos = [];
    _initializeApp();
    super.initState();
    focusnode = FocusNode();
  }

  @override
  void dispose() {
    _subscription.cancel();
    focusnode.dispose();
    super.dispose();
  }

  Future<void> _initializeApp() async {
    await _configureAmplify();
    _subscription = Amplify.DataStore.observe(ToDoList.classType).listen((event) {
      _fetchTodos();
    });
    await _fetchTodos();
  }

  Future<void> _configureAmplify() async {
    try{
      await Amplify.addPlugins([_dataStorePlugin, _apiPlugin]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {print (e);}
  }

  Future<void> _fetchTodos() async {

    List<ToDoList> _todofromDB = await DBServices().fetchAllToDo();
    setState(() {
      _todos = _todofromDB;
    });

  }

  final AmplifyDataStore _dataStorePlugin =
    AmplifyDataStore(modelProvider: ModelProvider.instance);
  final AmplifyAPI _apiPlugin = AmplifyAPI();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    saveTodo(_todoTitle) async {
      await DBServices().createToDo(_todoTitle);
    }

    return Scaffold(
      
      appBar: AppBar(
        title: Text('ToDo List'),
        backgroundColor: Colors.orange,
        ),

      body: Container(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            //Center(child: Text('No ToDo Items to show')),
            Padding(padding:EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: fieldText,
                      focusNode: focusnode,
                      cursorColor: Colors.orange,
                      decoration: InputDecoration(
                        labelText: 'ADD NEW TO-DO',
                        labelStyle: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0),),
                          borderSide: BorderSide(color: Colors.grey)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0),),
                          borderSide: BorderSide(width: 2.0, color: Colors.orange)
                        ),
                        suffixIcon: IconButton(
                          color: Colors.orange,
                          icon: Icon(Icons.add),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()){
                              await saveTodo(_todoTitle);
                              setState(() {
                                _todoTitle = '';
                              });
                              fieldText.clear();
                              FocusScope.of(context).unfocus();                            
                            }
                          },
                        ),
                      ),
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      onChanged: (val) {
                        setState(() => _todoTitle = val);
                      },
                      validator: (val) => val!.isEmpty ? 'Input required!' : null,
                    ),
                    Text(errTXT, style: TextStyle(color: Colors.red),),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    //leading: IconButton(icon: Icon(Icons.clear), onPressed: () {},),
                    title: Text('${_todos[index].title}', style: _textStyle(_todos[index].isComplete),),
                    trailing: Checkbox(value: _todos[index].isComplete, onChanged: (bool? newVal) => DBServices().updateToDo(_todos[index], newVal!),),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _textStyle(boolVal) {
  if (boolVal == true) {return TextStyle (decoration: TextDecoration.lineThrough);}
  else return TextStyle(fontWeight: FontWeight.normal);
}