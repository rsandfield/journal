import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome!",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 10,),
          Text(
              "There are no journal entries yet!",
              style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10,),
          Text(
              "Press the '+' icon to get started.",
            style: Theme.of(context).textTheme.headline5,
          ),
        ],
      ),
    );
  }
}
