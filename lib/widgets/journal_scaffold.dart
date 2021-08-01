import 'package:flutter/material.dart';
import 'package:journal/widgets/options.dart';

class JournalScaffold extends StatelessWidget {
  final bool back;
  final Text title;
  final Widget child;
  const JournalScaffold({
    required this.title,
    required this.child,
    this.back = false,
    Key? key
  }) :
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: back ? const BackButton() : null,
        title: title,
        actions: const [OptionsOpenWidget()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
      endDrawer: const OptionsWidget(),
    );
  }
}
