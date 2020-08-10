import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:flutter/material.dart';
import 'package:lwn_flutter_demo/rss_service.dart';

import 'homescreen.dart';

void main() async {
  final Rss1Feed feed = await LWNRssService().getFeed();
  runApp(DemoApp(feed));
}

class DemoApp extends StatelessWidget
{
  final Rss1Feed feed;

  DemoApp(this.feed);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        title: 'LWN Headlines',
        home: LWNHeadlineScreen(feed)
    );
  }
}