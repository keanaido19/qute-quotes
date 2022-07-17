import 'package:flutter/material.dart';

import '../models/quote_model.dart';

class QuoteScreen extends StatelessWidget {

  final Quote quote;

  const QuoteScreen({Key? key, required this.quote}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(),
            ),
            Text(
              '"${quote.text}"',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 24, fontStyle: FontStyle.italic
              ),
            ),
            const SizedBox(
                height: 30.0
            ),
            Text(
              '- ${quote.name}',
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
            ElevatedButton(
                onPressed: () {Navigator.pop(context);},
                child: const Text('close')
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
