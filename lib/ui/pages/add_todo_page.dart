import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/chabge_notifier/add_todo_store.dart';

class AddToDoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AddToDoStore addToDoStore = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 96,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 48,
                      left: 0,
                      child: Text(addToDoStore.pageTitle,
                          style: Theme.of(context).textTheme.display1),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      height: 48,
                      child: IconButton(
                          icon: Icon(Icons.create, size: 32), onPressed: () {}),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
