import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:flutter/material.dart';
import 'package:lwn_flutter_demo/rss_service.dart';

import 'homescreen.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        title: 'LWN Headlines',
        home: LWNHeadlineScreen(LWNRssService().getFeed())
    );
  }
}