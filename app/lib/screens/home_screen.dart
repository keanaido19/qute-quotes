import 'dart:async';

import 'package:app/screens/quote_screen.dart';
import 'package:flutter/material.dart';

import '../controllers/quote_controller.dart';
import '../models/quote_model.dart';

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
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Quote'),
                ),
                body: Center(
                  child: QuoteScreen(quote: quote),
                ),
              );
            }
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        return FutureBuilder<List<Quote>>(
          future: _quoteController.quotes,
          builder: (context, snapshot) {
            return const Center(child: CircularProgressIndicator());
          }
        );
      }
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
