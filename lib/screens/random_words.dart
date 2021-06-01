import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

final List<WordPair> _wordPairs = <WordPair>[];
final Set<WordPair> _savedWordPair = Set<WordPair>();

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  Widget _buildRow(WordPair _pair) {
    final bool alreadySaved = _savedWordPair.contains(_pair);

    return ListTile(
      title: Text(
        _pair.asPascalCase,
        style: TextStyle(color: Colors.black87, fontSize: 17),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite_rounded : Icons.favorite_border_rounded,
        color: alreadySaved ? Colors.redAccent : Colors.black54,
      ),
      leading: Icon(
        Icons.keyboard_arrow_right_rounded,
        size: 27,
        color: Colors.black54,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPair.remove(_pair);
          } else {
            _savedWordPair.add(_pair);
            print(_savedWordPair);
          }
        });
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int item) {
        if (item.isOdd)
          return const Divider();
        else {
          final int index = item ~/ 2;

          if (index >= _wordPairs.length) {
            _wordPairs.addAll(generateWordPairs(safeOnly: false).take(10));
            print('list expanded $index');
          }

          return _buildRow(_wordPairs[index]);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    void _pushSaved() {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _savedWordPair.map((WordPair pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
          );
        });

        final List<Widget> divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Saved WordPairs',
            ),
          ),
          body: ListView(
            children: divided,
          ),
        );
      }));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'WordPair-gen',
            style: TextStyle(
              fontSize: 21,
            ),
          ),
          actions: <Widget>[
            Container(
              child: IconButton(
                onPressed: _pushSaved,
                icon: Icon(
                  Icons.lightbulb_outline_sharp,
                  color: Colors.white,
                ),
                iconSize: 30,
              ),
              margin: EdgeInsets.only(right: 12),
            )
          ],
          centerTitle: true,
          elevation: 10,
        ),
        body: _buildList());
  }
}
