import 'package:flutter/material.dart';
import 'package:journal/widgets/journal_headlines.dart';
import 'package:journal/widgets/options.dart';

class JournalScaffold extends StatelessWidget {
  final bool back;
  final Text title;
  final GlobalKey<HeadlineListState> headlines;
  final Widget child;

  const JournalScaffold({
    required this.title,
    required this.headlines,
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
      endDrawer: OptionsWidget(headlines: headlines,),
    );
  }
}
