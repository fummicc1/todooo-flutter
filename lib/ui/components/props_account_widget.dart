import 'package:flutter/material.dart';
import 'package:todooo/ui/components/rounded_text_widget.dart';

class PropsAccountWidget extends StatelessWidget {
  const PropsAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Theme.of(context).backgroundColor,
          elevation: 8,
          child: Column(
            children: [
              SizedBox(height: 8,),
              Text("アカウント登録のメリット", style: Theme.of(context).textTheme.headline6,),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedTextWidget(
                  message: "他の端末で同じアカウントにログインすると、Todoをシェアできます",
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
