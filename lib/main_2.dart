import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joke Fetcher',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Joke Fetcher'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () async {
                  final response = await http.get(Uri.parse('https://v2.jokeapi.dev/joke/any'));
                  if (response.statusCode == 200) {
                    final Map<String, dynamic> data = jsonDecode(response.body);
                    final String setup = data['setup'];
                    final String delivery = data['delivery'];
                    final String joke = data['joke'];
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Joke'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text(setup),
                                Text(delivery),
                                Text(joke),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    throw Exception('Failed to fetch joke');
                  }
                },
                child: Text('Get Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
