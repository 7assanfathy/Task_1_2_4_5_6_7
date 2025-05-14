import 'package:flutter/material.dart';
import 'package:projects/quote/quote.dart';
import 'package:projects/quote/service.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<List<Quote>> future;

  @override
  void initState() {
    super.initState();
    future = fetchQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/quote.jpg"),
          ),
        ),
        child: FutureBuilder<List<Quote>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      SizedBox(height: 280,),
                      Text(snapshot.data![index].quote),
                      Text(snapshot.data![index].author),
                      Text(snapshot.data![index].category),
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Icon(
                  Icons.wifi_off_rounded,
                  color: Colors.green.shade100,
                  size: 200,
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
