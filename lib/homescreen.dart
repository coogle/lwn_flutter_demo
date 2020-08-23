import 'package:dart_rss/domain/rss1_feed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:lwn_flutter_demo/rss_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LWNHeadlineScreen extends StatelessWidget
{
  Future<Rss1Feed> feed;

  LWNHeadlineScreen(this.feed);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(
            title: Text("LWN RSS Reader")
        ),
        body: FutureBuilder<Rss1Feed>(
            future: feed,
            builder: (context, snapshot) {

              if(snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.items.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      final item = snapshot.data.items[index];
                      return ListTile(
                          title: Text(
                              item.title,
                              style: TextStyle(fontWeight: FontWeight.bold)
                          ),
                          subtitle: Html(
                              data: "<p>" + item.description.trim() + "</p>",
                              onLinkTap: (url) async {

                                debugPrint("Attempting to launch: $url");

                                if(await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                          ),
                          contentPadding: EdgeInsets.only(
                              left: 10.0,
                              right: 16.0,
                              top: 0,
                              bottom: 0
                          ),

                          onTap: () async {

                            RegExp exp = new RegExp(
                                r'^http[s]?:\/\/lwn.net\/Articles\/([0-9]+).*',
                                multiLine: false
                            );

                            if(!exp.hasMatch(item.link)) {
                              debugPrint("Could not find an article ID in the URL");
                              return;
                            }

                            String articleId = exp.firstMatch(item.link).group(1);
                            String linkUrl = "https://lwn.net/Articles/" + articleId;

                            if(await canLaunch(linkUrl)) {
                              await launch(linkUrl);
                            } else {
                              throw 'Could not launch $linkUrl';
                            }
                          }
                      );
                    }
                );
              } else if(snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Center(
                  child: CircularProgressIndicator()
              );
            }
        )
    );
  }
}

