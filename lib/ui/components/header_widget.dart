import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final List<FlatButton> actions;

  HeaderWidget({@required this.child, @required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 48),
              Row(
                children: <Widget>[
                  Text(title, style: Theme.of(context).textTheme.display1),
                  Spacer(),
                  ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return actions[index];
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 8);
                      },
                      itemCount: actions?.length ?? 0),
                  SizedBox(width: 20),
                ],
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
