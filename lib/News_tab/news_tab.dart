import 'dart:convert';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:imitra/News_tab/news_model.dart';

class News_Tab extends StatefulWidget {
  const News_Tab({Key? key}) : super(key: key);

  @override
  State<News_Tab> createState() => _News_TabState();
}

class _News_TabState extends State<News_Tab> {
  var i = 0;
  List<Articles> articleList = [];
  List speechList = [];

  TextToSpeech tts = TextToSpeech();
  Future<List<Articles>> getArticle() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=4b05bf5d8f8943b3bfb55f3902b04ea2"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data['articles']) {
        articleList.add(Articles.fromJson(i));
        // speakList.add(Articles.fromJson(i));
      }
      return articleList;
    } else {
      throw Exception('Failed to load articles');
    }
  }

  speak(text) async {
    await tts.speak(text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    speak;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Articles>>(
              future: getArticle(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        speechList.add(articleList[index].title.toString());
                        for (var i in speechList) {
                          speak(i.toString());
                        }
                        return Card(
                          child: Column(
                            children: [
                              Text(articleList[index].title.toString()),
                            ],
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
