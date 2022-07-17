import 'package:app/screens/quote_screen.dart';
import 'package:flutter/material.dart';

import '../models/quote_model.dart';

class CreateQuoteScreen extends StatelessWidget {
  const CreateQuoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quote'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute<void>(
                                builder: (context) {
                                  return const QuoteScreen(
                                      quote : Quote(
                                          id: 1, text: 'lol', name: 'lol'
                                      )
                                  );
                                }
                                )
                        );
                        },
                      child: const Text('save')
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
                    flex: 2,
                    child: Container(),
                  ),
                ]
              ),
            ]
          ),
        ),
      ),
    );
  }
}
