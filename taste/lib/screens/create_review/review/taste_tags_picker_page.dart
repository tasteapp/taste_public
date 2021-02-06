import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:taste/screens/create_review/review/create_review.dart';
import 'package:taste/theme/style.dart';

class TasteTagsPickerPage extends StatefulWidget {
  const TasteTagsPickerPage(
      {Key key,
      @required this.selected,
      @required this.title,
      this.subtitle = false,
      @required this.tags})
      : super(key: key);
  final Set<String> selected;
  final String title;
  final Map<String, String> tags;
  final bool subtitle;

  @override
  _TasteTagsPickerPageState createState() => _TasteTagsPickerPageState();
}

class _TasteTagsPickerPageState extends State<TasteTagsPickerPage> {
  final controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: kAppBarTitleStyle),
          centerTitle: true,
          actions: [AcceptButton()],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autocorrect: false,
                controller: controller,
                decoration: const InputDecoration(
                    hintText: "Search for Taste tag",
                    border: OutlineInputBorder()),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 50),
              child: Wrap(
                  children: widget.tags.entries
                      .where((e) => widget.selected.contains(e.key))
                      .map(emoji)
                      .toList()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 0.5,
                color: Colors.black,
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    Wrap(
                        children: widget.tags.entries
                            .where((e) => e.value
                                .toLowerCase()
                                .contains(controller.text.toLowerCase()))
                            .map(emoji)
                            .toList()),
                  ],
                ),
              ),
            )),
          ],
        ));
  }

  Widget emoji(MapEntry<String, String> entry) {
    final e = entry.key;
    final selected = widget.selected.contains(e);
    return GestureDetector(
      onTap: () {
        controller.clear();
        if (widget.selected.contains(e)) {
          setState(() {
            widget.selected.remove(e);
          });
        } else {
          setState(() {
            widget.selected.add(e);
          });
        }
      },
      child: TasteTagTile(
          selected: selected,
          emoji: e,
          subtitle: widget.subtitle ? entry.value : null),
    );
  }

  int sortFn(MapEntry<int, MapEntry<String, String>> a,
      MapEntry<int, MapEntry<String, String>> b) {
    final containsA = widget.selected.contains(a.value.key);
    final containsB = widget.selected.contains(b.value.key);
    if (containsA != containsB) {
      return containsA ? -1 : 1;
    }
    return a.key.compareTo(b.key);
  }
}

class TasteTagTile extends StatelessWidget {
  TasteTagTile({
    @required this.emoji,
    this.selected = false,
    this.subtitle,
  }) : super(key: Key(emoji));

  final bool selected;
  final String emoji;
  final String subtitle;

  bool get showSubtitle => subtitle?.isNotEmpty ?? false;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: selected ? 8 : 0,
        child: Container(
            width: showSubtitle ? 40 : null,
            decoration: BoxDecoration(
                border: Border.all(
                    color: selected ? Colors.black : Colors.white, width: 1),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(emoji, style: const TextStyle(fontSize: 25)),
                ),
                Visibility(
                    visible: showSubtitle,
                    child: Container(
                      height: 20,
                      child: AutoSizeText(
                        subtitle ?? '',
                        textAlign: TextAlign.center,
                        maxFontSize: 10,
                        minFontSize: 6,
                        wrapWords: false,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    )),
              ],
            )));
  }
}
