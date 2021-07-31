import 'package:flutter/material.dart';
import 'package:journal/widgets/journal_headlines.dart';
import 'package:journal/widgets/options.dart';

class JournalWidget extends StatefulWidget {
  const JournalWidget({Key? key}) : super(key: key);

  @override
  State<JournalWidget> createState() => _JournalWidgetState();
}

class _JournalWidgetState extends State<JournalWidget> {
  // https://stackoverflow.com/questions/47435231/open-drawer-on-clicking-appbar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Journal"),
        actions: const [OptionsOpenWidget()],
      ),
      body: const HeadlineList(),
      endDrawer: const OptionsWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/create');
        },
        tooltip: "Add journal entry",
        child: const Icon(Icons.add),
      ),
    );
  }
}



class RatingWidget extends StatelessWidget {
  final int rating;

  const RatingWidget(this.rating, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List<Icon>.generate(5, (i) {
        if (i < rating) {
          return const Icon(Icons.star);
        } else {
          return const Icon(Icons.star_outline);
        }
      }),
    );
  }
}

