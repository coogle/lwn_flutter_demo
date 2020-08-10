import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:flutter/material.dart';

class LWNHeadlineScreen extends StatelessWidget
{
  final Rss1Feed feed;

  LWNHeadlineScreen(this.feed);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(feed.title)
      ),
      body: ListView.builder(
        itemCount: feed.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = feed.items[index];
          return ListTile(
            title: Text(item.title),
            contentPadding: EdgeInsets.all(16.0),
          );
        }
      )
    );
  }
}