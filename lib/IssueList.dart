import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class IssueList extends StatefulWidget {
  final String title;

  IssueList({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _IssueListState();
  }
}

class _IssueListState extends State<IssueList> {
  int page = 1;
  List<String> issues;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var length = issues?.length ?? 0;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          if (index == length) {
            _fetchData();
            return new Center(
              child: new Container(
                margin: const EdgeInsets.only(top: 8.0),
                width: 32.0,
                height: 32.0,
                child: const CircularProgressIndicator(),
              ),
            );
          } else if (index > length) {
            return null;
          }

          String title = issues[index];
          return new Container(
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(color: Colors.grey.shade300),
              ),
            ),
            child: new ListTile(
              key: new ValueKey<String>(title),
              title: new Text(title),
            ),
          );
        },
      ),
    );
  }

  Future<void> _fetchData() async {
    print(page);
    String url =
        'https://api.github.com/repositories/31792824/issues?page=$page';
    if (loading) {
      return null;
    }
    loading = true;
    try {
      var resp = await http.get(url);
      var data = json.decode(resp.body);
      setState(() {
        page += 1;
        if (data is List) {
          if (issues == null) {
            issues = <String>[];
          }
          data.forEach((dynamic e) {
            if (e is Map) {
              issues.add(e['title'] as String);
            }
          });
        }
      });
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }
}
