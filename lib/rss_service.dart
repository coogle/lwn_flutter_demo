import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:http/http.dart' as http;

class LWNRssService {
  final _targetUrl = 'https://lwn.net/headlines/newrss';

  Future<Rss1Feed> getFeed() =>
      http.read(_targetUrl)
          .then((xmlString) => Rss1Feed.parse(xmlString));
}