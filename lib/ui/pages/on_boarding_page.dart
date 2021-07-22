import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todooo/states/on_boarding_state.dart';
import 'package:todooo/ui/components/curved_curtain.dart';
import 'package:todooo/ui/components/props_account_widget.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

enum FormType { SignUp, SignIn, None }

class _OnBoardingPageState extends State<OnBoardingPage> {
  double height = 0;
  double opacity = 0;
  double bottomHeight = 0;

  FormType formType = FormType.None;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      setState(() {
        height = 360;
        opacity = 1;
        bottomHeight = 360;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final OnBoardingState onBoardingState = Provider.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          "アカウント登録のメリット",
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 2,
        icon: Icon(Icons.info_outline),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              barrierColor: Theme.of(context).primaryColor.withAlpha(120),
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Wrap(
                  children: [
                    PropsAccountWidget()
                  ],
                );
              });
        },
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: Theme.of(context).backgroundColor,
          ),
          AnimatedContainer(
            height: height,
            duration: Duration(seconds: 1),
            curve: Curves.easeOut,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Opacity(
                  opacity: 0.6,
                  child: ClipPath(
                    child: Container(
                      height: 240,
                      color: Theme.of(context).primaryColor,
                    ),
                    clipper: CurvedCurtain(),
                  ),
                ),
                ClipPath(
                  child: Container(
                    height: 200,
                    color: Theme.of(context).primaryColor,
                  ),
                  clipper: CurvedCurtain(),
                ),
                Positioned(
                    top: 64,
                    child: AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: opacity,
                      child: Text(
                        "Welcome to Todooo",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.apply(fontWeightDelta: 2, color: Colors.white),
                      ),
                    )),
              ],
            ),
          ),
          Positioned(
              right: 32,
              left: 32,
              bottom: 80,
              top: height == 0 ? 96 : null,
              child: AnimatedContainer(
                height: bottomHeight,
                duration: Duration(milliseconds: 700),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 700),
                  opacity: opacity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            height: 150,
                            child: Image.asset("assets/icon/icon_clear.png")),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: buildForm(context, onDecide: () async {
                            if (formType == FormType.SignIn) {
                              try {
                                await onBoardingState.signInWithEmail();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("$e")));
                              }
                            } else if (formType == FormType.SignUp) {
                              try {
                                await onBoardingState.signUpWithEmail();
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("$e")));
                              }
                            }
                          }),
                        ),
                        buildSelection(context)
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  List<Widget> buildForm(BuildContext context, {required Function() onDecide}) {
    final OnBoardingState state = Provider.of(context);

    final spacer = SizedBox(
      height: 24,
    );

    final decideButton = Padding(
        padding: const EdgeInsets.all(12),
        child: ElevatedButton(
          onPressed: onDecide,
          child: Text("決定"),
          style: ElevatedButton.styleFrom(
            onPrimary: Theme.of(context).primaryColor,
            primary: Theme.of(context).backgroundColor,
          ),
        ));

    final emailInput = TextField(
      decoration: InputDecoration(labelText: "メールアドレス"),
      onChanged: (text) {
        state.email = text;
      },
    );
    final passwordInput = TextField(
      decoration: InputDecoration(labelText: "パスワード"),
      onChanged: (text) {
        state.password = text;
      },
    );
    if (formType == FormType.SignUp) {
      final confirmPasswordInput = TextField(
        decoration: InputDecoration(labelText: "確認用パスワード"),
        onChanged: (text) {
          state.confirmPassword = text;
        },
      );
      return [
        emailInput,
        spacer,
        passwordInput,
        spacer,
        confirmPasswordInput,
        spacer,
        decideButton
      ];
    }
    if (formType == FormType.None) {
      return [];
    }

    return [emailInput, spacer, passwordInput, spacer, decideButton];
  }

  Widget buildSelection(BuildContext context) {
    final OnBoardingState onBoardingState = Provider.of(context);

    if (formType != FormType.None) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                height = 360;
                formType = FormType.None;
              });
            },
            style: ElevatedButton.styleFrom(
                onPrimary: Theme.of(context).backgroundColor,
                primary: Theme.of(context).primaryColor),
            child: Text("キャンセル")),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  formType = FormType.SignUp;
                  height = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                  onPrimary: Theme.of(context).backgroundColor,
                  primary: Theme.of(context).primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "メールアドレスで登録",
                ),
              )),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  formType = FormType.SignIn;
                  height = 0;
                });
              },
              style: ElevatedButton.styleFrom(
                  onPrimary: Theme.of(context).backgroundColor,
                  primary: Theme.of(context).primaryColor),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "メールアドレスでログイン",
                ),
              )),
        ),
        SizedBox(
          height: 16,
        ),
        ElevatedButton(
            onPressed: () {
              onBoardingState.signInAsGuest();
            },
            style: ElevatedButton.styleFrom(
                onPrimary: Theme.of(context).backgroundColor,
                primary: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "まずはゲストで始める",
              ),
            )),
      ],
    );
  }
}
