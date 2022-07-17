import 'dart:async';

import 'package:app/screens/quote_screen.dart';
import 'package:flutter/material.dart';

import '../controllers/quote_controller.dart';
import '../models/quote_model.dart';
import 'create_quote_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final QuoteController _quoteController = QuoteController();

  final Stream _stream = (() {
    late final StreamController controller;
    controller = StreamController(
      onListen: () async {
        while (true) {
          controller.add(1);
          await Future<void>.delayed(const Duration(seconds: 1));
        }
      },
    );
    return controller.stream;
  })();

  void _showQuote(Quote quote) {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              return QuoteScreen(quote : quote);
            }
        )
    );
  }

  void _createQuote() {
    Navigator.of(context).push(
        MaterialPageRoute<void>(
            builder: (context) {
              return const CreateQuoteScreen();
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qute Quotes'),
      ),
      body: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            return FutureBuilder<List<Quote>>(
                future: _quoteController.quotes,
                builder: (
                    BuildContext context,
                    AsyncSnapshot snapshot
                    )
                {
                  if (snapshot.hasError) return const FailedConnectionWidget();
                  if (snapshot.hasData) {
                    List<Quote> quotes = snapshot.data!;
                    return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: quotes.length * 2,
                      itemBuilder: (context, i) {
                        if (i.isOdd) return const Divider();
                        final index = i ~/ 2;
                        return ListTile(
                          title: Text(quotes[index].text),
                          onTap: () {
                            setState(() {
                              _showQuote(quotes[index]);
                            });
                          },
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'createQuote_floatingActionButton',
        tooltip: 'Create a Quote',
        onPressed: () => {_createQuote()},
        child: const Icon(Icons.create)
      ),
    );
  }
}

class FailedConnectionWidget extends StatelessWidget {
  const FailedConnectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(
              Icons.error_outline,
              size: 150,
            ),
            const SizedBox(
                height: 10.0
            ),
            Text(
                'Failed to connect to Qute Quote Server!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6
            ),
          ],
        ),
      ),
    );
  }
}
