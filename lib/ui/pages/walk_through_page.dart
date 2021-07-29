import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/app_state.dart';

class WalkThroughPage extends StatelessWidget {
  const WalkThroughPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: "直近のTodoを管理",
              body: "今日もしくは明日までのTodoを作成しましょう。通知を設定することもできます。",
              image: Image.asset("assets/screenshots/add_todo_fill.png")
            ),
            PageViewModel(
              title: "Todoの確認と編集",
              body: "登録したTodoを一覧画面からタップすると、詳細を確認できます。",
                image: Image.asset("assets/screenshots/detail_todo.png")
            )
          ],
          done: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              "Done",
              style: Theme.of(context).textTheme.button?.apply(
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
          onDone: () {
            final appState = Provider.of<AppState>(context, listen: false);
            appState.updateCompleteWalkThroughStatus(isCompleted: true);
          },
          showDoneButton: true,
          showNextButton: true,
          next: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              "Next",
              style: Theme.of(context).textTheme.button?.apply(
                  color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}
