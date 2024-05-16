import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const TextStyle tituloFont = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

class _MyHomePageState extends State<MyHomePage> {
  final String apiURL =
      'https://newsapi.org/v2/top-headlines?country=us&apiKey=b07bceb3309c4982b002f1d4c154ed64';
  List data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body)['articles'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.airplane_ticket),
            SizedBox(width: 10),
            Text(
              "Hable Como Habla",
              style: tituloFont,
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 48, 10, 138),
        foregroundColor: Colors.white,
        elevation: 10,
        centerTitle: true,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: data.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data[index]['title'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          data[index]['description'] ??
                              'No description available',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Image.network(
                          data[index]['urlToImage'] ?? 'No Imagen',
                          scale: 2,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
